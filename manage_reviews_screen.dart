import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ManageReviewsScreen extends StatefulWidget {
  const ManageReviewsScreen({super.key});

  @override
  State<ManageReviewsScreen> createState() => _ManageReviewsScreenState();
}

class _ManageReviewsScreenState extends State<ManageReviewsScreen> {
  String _filter = 'all';

  final List<Map<String, dynamic>> _reviews = [
    {
      'id': '1',
      'name': 'Chinedu Okafor',
      'rating': 5.0,
      'message': 'Excellent service! My bathroom looks brand new. Very professional and clean work.',
      'service': 'Bathroom Renovation',
      'approved': true,
      'featured': true,
      'date': 'Jan 15, 2024',
    },
    {
      'id': '2',
      'name': 'Amina Bello',
      'rating': 5.0,
      'message': 'The gate installation was done perfectly. Strong and beautiful design.',
      'service': 'Gate Installation',
      'approved': true,
      'featured': true,
      'date': 'Dec 28, 2023',
    },
    {
      'id': '3',
      'name': 'Tunde Adeyemi',
      'rating': 4.5,
      'message': 'Great painting job on my house exterior. The color matching was spot on.',
      'service': 'House Painting',
      'approved': true,
      'featured': false,
      'date': 'Dec 10, 2023',
    },
    {
      'id': '4',
      'name': 'Unknown User',
      'rating': 2.0,
      'message': 'Not satisfied with the work. Took too long and left a mess.',
      'service': 'Plumbing Repairs',
      'approved': false,
      'featured': false,
      'date': 'Nov 5, 2023',
    },
    {
      'id': '5',
      'name': 'Ngozi Eze',
      'rating': 5.0,
      'message': 'My living room transformation is absolutely stunning!',
      'service': 'Interior Decoration',
      'approved': false,
      'featured': false,
      'date': 'Nov 22, 2023',
    },
  ];

  List<Map<String, dynamic>> get filteredReviews {
    if (_filter == 'all') return _reviews;
    if (_filter == 'pending') return _reviews.where((r) => !r['approved']).toList();
    if (_filter == 'approved') return _reviews.where((r) => r['approved']).toList();
    if (_filter == 'featured') return _reviews.where((r) => r['featured']).toList();
    return _reviews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Reviews'),
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('All', 'all'),
                _buildFilterChip('Pending', 'pending'),
                _buildFilterChip('Approved', 'approved'),
                _buildFilterChip('Featured', 'featured'),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                return _buildReviewCard(filteredReviews[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filter == value;
    return GestureDetector(
      onTap: () => setState(() => _filter = value),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                (review['name'] as String)[0],
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
            title: Row(
              children: [
                Text(
                  review['name'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                if (review['featured'])
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 12, color: AppColors.secondary),
                        SizedBox(width: 2),
                        Text(
                          'Featured',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      i < (review['rating'] as double).floor()
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      size: 16,
                      color: AppColors.secondary,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  review['service'],
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'approve') {
                  setState(() => review['approved'] = true);
                } else if (value == 'feature') {
                  setState(() => review['featured'] = !review['featured']);
                } else if (value == 'delete') {
                  setState(() => _reviews.remove(review));
                }
              },
              itemBuilder: (context) => [
                if (!review['approved'])
                  const PopupMenuItem(value: 'approve', child: Row(children: [Icon(Icons.check, size: 18, color: AppColors.completed), SizedBox(width: 8), Text('Approve')])),
                PopupMenuItem(
                  value: 'feature',
                  child: Row(
                    children: [
                      Icon(review['featured'] ? Icons.star_border : Icons.star, size: 18, color: AppColors.secondary),
                      const SizedBox(width: 8),
                      Text(review['featured'] ? 'Unfeature' : 'Feature on Home'),
                    ],
                  ),
                ),
                const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, size: 18, color: AppColors.error), SizedBox(width: 8), Text('Delete', style: TextStyle(color: AppColors.error))])),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                review['message'],
                style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
