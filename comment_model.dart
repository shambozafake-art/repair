class CommentModel {
  final String id;
  final String projectId;
  final String userName;
  final String comment;
  final bool isApproved;
  final String? reply;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.projectId,
    required this.userName,
    required this.comment,
    this.isApproved = false,
    this.reply,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      projectId: json['project_id'] ?? '',
      userName: json['user_name'] ?? '',
      comment: json['comment'] ?? '',
      isApproved: json['is_approved'] ?? false,
      reply: json['reply'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'user_name': userName,
      'comment': comment,
      'is_approved': isApproved,
      'reply': reply,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
