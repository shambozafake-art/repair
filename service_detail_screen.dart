import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_button.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceId;

  const ServiceDetailScreen({super.key, required this.serviceId});

  final Map<String, Map<String, dynamic>> _serviceDetails = const {
    '1': {
      'name': 'House Decoration',
      'description': 'Complete house decoration services including wall treatments, lighting design, and furniture arrangement to transform your living space into a beautiful home.',
      'features': [
        'Wall painting and texture',
        'Lighting design and installation',
        'Furniture arrangement',
        'Curtain and blind installation',
        'Wall art and decor placement',
      ],
      'price': 'From ₦150,000',
      'duration': '3-7 days',
      'icon': Icons.format_paint,
      'color': Color(0xFF4ECDC4),
    },
    '2': {
      'name': 'Interior Decoration',
      'description': 'Professional interior design services to create beautiful, functional spaces that reflect your personal style and needs.',
      'features': [
        'Space planning',
        'Color consultation',
        'Material selection',
        'Custom furniture design',
        '3D visualization',
      ],
      'price': 'From ₦100,000',
      'duration': '5-10 days',
      'icon': Icons.chair,
      'color': Color(0xFF9D4EDD),
    },
  };

  Map<String, dynamic> get service {
    return _serviceDetails[serviceId] ?? _serviceDetails['1']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      (service['color'] as Color).withOpacity(0.8),
                      (service['color'] as Color),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        service['icon'] as IconData,
                        size: 80,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        service['name'],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price & Duration
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          Icons.attach_money,
                          'Price',
                          service['price'],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          Icons.schedule,
                          'Duration',
                          service['duration'],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'About This Service',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service['description'],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                  ),

                  const SizedBox(height: 24),

                  // Features
                  Text(
                    'What's Included',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    (service['features'] as List).length,
                    (index) => _buildFeatureItem((service['features'] as List)[index]),
                  ),

                  const SizedBox(height: 32),

                  // CTA Buttons
                  CustomButton(
                    text: 'Book This Service',
                    onPressed: () => context.go('/booking'),
                    icon: Icons.calendar_today,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Request Custom Quote',
                    onPressed: () => context.go('/booking'),
                    isOutlined: true,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              size: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
