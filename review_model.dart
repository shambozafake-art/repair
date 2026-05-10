class ReviewModel {
  final String id;
  final String customerName;
  final double rating;
  final String reviewMessage;
  final String serviceDone;
  final DateTime date;
  final bool isApproved;
  final bool isFeatured;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.customerName,
    required this.rating,
    required this.reviewMessage,
    required this.serviceDone,
    required this.date,
    this.isApproved = false,
    this.isFeatured = false,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      customerName: json['customer_name'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      reviewMessage: json['review_message'] ?? '',
      serviceDone: json['service_done'] ?? '',
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
      isApproved: json['is_approved'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
      'rating': rating,
      'review_message': reviewMessage,
      'service_done': serviceDone,
      'date': date.toIso8601String(),
      'is_approved': isApproved,
      'is_featured': isFeatured,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
