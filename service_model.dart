class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double? startingPrice;
  final String? priceText;
  final String category;
  final bool isActive;
  final DateTime createdAt;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.startingPrice,
    this.priceText,
    required this.category,
    this.isActive = true,
    required this.createdAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      startingPrice: json['starting_price'] != null
          ? (json['starting_price'] as num).toDouble()
          : null,
      priceText: json['price_text'],
      category: json['category'] ?? 'General',
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'starting_price': startingPrice,
      'price_text': priceText,
      'category': category,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
