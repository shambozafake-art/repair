import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Chinedu Okafor',
      'rating': 5.0,
      'message': 'Excellent service! My bathroom looks brand new. Very professional and clean work. Would definitely recommend to anyone looking for quality home repairs.',
      'service': 'Bathroom Renovation',
      'date': 'Jan 15, 2024',
      'avatar': 'C',
    },
    {
      'name': 'Amina Bello',
      'rating': 5.0,
      'message': 'The gate installation was done perfectly. Strong and beautiful design. The team was punctual and very respectful. Highly recommend!',
      'service': 'Gate Installation',
      'date': 'Dec 28, 2023',
      'avatar': 'A',
    },
    {
      'name': 'Tunde Adeyemi',
      'rating': 4.5,
      'message': 'Great painting job on my house exterior. The color matching was spot on and the finish is smooth. Only wish they had finished a day earlier.',
      'service': 'House Painting',
      'date': 'Dec 10, 2023',
      'avatar': 'T',
    },
    {
      'name': 'Ngozi Eze',
      'rating': 5.0,
      'message': 'My living room transformation is absolutely stunning! The interior decoration team understood my vision perfectly and delivered beyond expectations.',
      'service': 'Interior Decoration',
      'date': 'Nov 22, 2023',
      'avatar': 'N',
    },
    {
      'name': 'Kunle Johnson',
      'rating': 5.0,
      'message': 'Fixed my leaking pipes within hours. Very professional plumber who explained everything clearly. Fair pricing too!',
      'service': 'Plumbing Repairs',
      'date': 'Nov 5, 2023',
      'avatar': 'K',
    },
    {
      'name': 'Fatima Ibrahim',
      'rating': 4.0,
      'message': 'Good welding work on my balcony railing. Strong and durable. Minor delay in delivery but quality makes up for it.',
      'service': 'Welding Repairs',
      'date': 'Oct 18, 2023',
      'avatar': 'F',
    },
  ];

  double get _averageRating {
    if (_reviews.isEmpty) return 0;
    return _reviews.map((r) => r['rating'] as double).reduce((a, b) => a + b) / _reviews.length;
  }

  Map<int, int> get _ratingDistribution {
    final dist = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in _reviews) {
      final rating = (review['rating'] as double).round();
      dist[rating] = (dist[rating] ?? 0) + 1;
    }
    return dist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Customer Reviews'),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _averageRating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: List.generate(5, (i) {
                                    return Icon(
                                      i < _averageRating.floor()
                                          ? Icons.star_rounded
                                          : Icons.star_border_rounded,
                                      color: AppColors.secondary,
                                      size: 20,
                                    );
                                  }),
                                ),
                                Text(
                                  '\${_reviews.length} reviews',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Rating Distribution
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Column(
                children: [5, 4, 3, 2, 1].map((star) {
                  final count = _ratingDistribution[star] ?? 0;
                  final percentage = _reviews.isEmpty ? 0.0 : count / _reviews.length;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          '\$star',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, size: 14, color: AppColors.secondary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: percentage,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                star >= 4 ? AppColors.completed : 
                                star >= 3 ? AppColors.pending : AppColors.error,
                              ),
                              minHeight: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '\$count',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Reviews List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final review = _reviews[index];
                  return _buildReviewCard(review);
                },
                childCount: _reviews.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  review['avatar'],
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review['date'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: AppColors.secondary),
                  const SizedBox(width: 2),
                  Text(
                    review['rating'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review['message'],
            style: const TextStyle(
              color: AppColors.textSecondary,
              height: 1.6,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Service: \${review['service']}',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.primary.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
