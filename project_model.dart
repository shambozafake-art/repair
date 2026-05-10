class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String beforeImageUrl;
  final String afterImageUrl;
  final List<String> imageUrls;
  final String location;
  final String serviceType;
  final DateTime dateCompleted;
  final int likes;
  final int comments;
  final bool isPublished;
  final DateTime createdAt;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.beforeImageUrl,
    required this.afterImageUrl,
    this.imageUrls = const [],
    required this.location,
    required this.serviceType,
    required this.dateCompleted,
    this.likes = 0,
    this.comments = 0,
    this.isPublished = true,
    required this.createdAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      beforeImageUrl: json['before_image_url'] ?? '',
      afterImageUrl: json['after_image_url'] ?? '',
      imageUrls: List<String>.from(json['image_urls'] ?? []),
      location: json['location'] ?? '',
      serviceType: json['service_type'] ?? '',
      dateCompleted: json['date_completed'] != null
          ? DateTime.parse(json['date_completed'])
          : DateTime.now(),
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      isPublished: json['is_published'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'before_image_url': beforeImageUrl,
      'after_image_url': afterImageUrl,
      'image_urls': imageUrls,
      'location': location,
      'service_type': serviceType,
      'date_completed': dateCompleted.toIso8601String(),
      'likes': likes,
      'comments': comments,
      'is_published': isPublished,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
