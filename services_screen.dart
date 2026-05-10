import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/loading_widget.dart';
import '../../models/service_model.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<ServiceModel> _services = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Decoration',
    'Repairs',
    'Installation',
    'Plumbing',
    'Painting',
  ];

  final List<Map<String, dynamic>> _demoServices = [
    {
      'id': '1',
      'name': 'House Decoration',
      'description': 'Complete house decoration services including wall treatments, lighting design, and furniture arrangement to transform your living space.',
      'category': 'Decoration',
      'price': 'From ₦150,000',
      'icon': Icons.format_paint,
      'color': Color(0xFF4ECDC4),
    },
    {
      'id': '2',
      'name': 'Interior Decoration',
      'description': 'Professional interior design services to create beautiful, functional spaces that reflect your personal style.',
      'category': 'Decoration',
      'price': 'From ₦100,000',
      'icon': Icons.chair,
      'color': Color(0xFF9D4EDD),
    },
    {
      'id': '3',
      'name': 'Gate Fixing',
      'description': 'Expert gate repair services for all types of gates including sliding, swing, and automatic gates.',
      'category': 'Repairs',
      'price': 'From ₦25,000',
      'icon': Icons.door_front_door,
      'color': Color(0xFFFF6B6B),
    },
    {
      'id': '4',
      'name': 'Gate Installation',
      'description': 'Professional gate installation with high-quality materials and modern designs for security and aesthetics.',
      'category': 'Installation',
      'price': 'From ₦80,000',
      'icon': Icons.door_sliding,
      'color': Color(0xFFFF9F1C),
    },
    {
      'id': '5',
      'name': 'Welding Repairs',
      'description': 'Skilled welding services for metal gates, railings, furniture, and structural repairs.',
      'category': 'Repairs',
      'price': 'From ₦15,000',
      'icon': Icons.construction,
      'color': Color(0xFFE63946),
    },
    {
      'id': '6',
      'name': 'Shower Installation',
      'description': 'Modern shower installation with premium fixtures and waterproofing for a luxurious bathroom experience.',
      'category': 'Installation',
      'price': 'From ₦45,000',
      'icon': Icons.shower,
      'color': Color(0xFF457B9D),
    },
    {
      'id': '7',
      'name': 'Bathroom Fittings',
      'description': 'Complete bathroom fitting services including sinks, toilets, taps, and accessories installation.',
      'category': 'Plumbing',
      'price': 'From ₦35,000',
      'icon': Icons.bathroom,
      'color': Color(0xFF2A9D8F),
    },
    {
      'id': '8',
      'name': 'Plumbing Repairs',
      'description': 'Fast and reliable plumbing repairs for leaks, pipe bursts, blocked drains, and water heater issues.',
      'category': 'Plumbing',
      'price': 'From ₦10,000',
      'icon': Icons.plumbing,
      'color': Color(0xFF1D3557),
    },
    {
      'id': '9',
      'name': 'Painting',
      'description': 'Interior and exterior painting with premium paints and professional finishing for a flawless look.',
      'category': 'Painting',
      'price': 'From ₦50,000',
      'icon': Icons.brush,
      'color': Color(0xFFF4A261),
    },
    {
      'id': '10',
      'name': 'Tiling',
      'description': 'Expert floor and wall tiling with precise cuts and perfect alignment for kitchens, bathrooms, and living areas.',
      'category': 'Installation',
      'price': 'From ₦40,000',
      'icon': Icons.grid_on,
      'color': Color(0xFF6B705C),
    },
    {
      'id': '11',
      'name': 'Ceiling Repairs',
      'description': 'Ceiling repair and installation services including POP, suspended, and gypsum board ceilings.',
      'category': 'Repairs',
      'price': 'From ₦30,000',
      'icon': Icons.roofing,
      'color': Color(0xFFBC6C25),
    },
    {
      'id': '12',
      'name': 'General Maintenance',
      'description': 'Comprehensive home maintenance services to keep your property in top condition year-round.',
      'category': 'Repairs',
      'price': 'Request Quote',
      'icon': Icons.handyman,
      'color': Color(0xFF606C38),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> get filteredServices {
    if (_selectedCategory == 'All') return _demoServices;
    return _demoServices.where((s) => s['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Our Services'),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.handyman_rounded, size: 48, color: Colors.white70),
                        SizedBox(height: 8),
                        Text(
                          'Professional Services for Your Home',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Category Filter
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = category),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Services Grid
          _isLoading
              ? const SliverFillRemaining(child: LoadingWidget(message: 'Loading services...'))
              : SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final service = filteredServices[index];
                        return _buildServiceCard(context, service);
                      },
                      childCount: filteredServices.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service) {
    return GestureDetector(
      onTap: () => context.go('/services/\${service['id']}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: (service['color'] as Color).withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Center(
                  child: Icon(
                    service['icon'] as IconData,
                    size: 48,
                    color: service['color'] as Color,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service['description'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          service['price'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: service['price'] == 'Request Quote' 
                                ? AppColors.primary 
                                : AppColors.secondary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
