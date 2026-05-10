class BookingModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String? whatsappNumber;
  final String? email;
  final String location;
  final String serviceNeeded;
  final DateTime preferredDate;
  final String preferredTime;
  final String problemDescription;
  final String? imageUrl;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  BookingModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.whatsappNumber,
    this.email,
    required this.location,
    required this.serviceNeeded,
    required this.preferredDate,
    required this.preferredTime,
    required this.problemDescription,
    this.imageUrl,
    this.status = 'pending',
    required this.createdAt,
    this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      whatsappNumber: json['whatsapp_number'],
      email: json['email'],
      location: json['location'] ?? '',
      serviceNeeded: json['service_needed'] ?? '',
      preferredDate: json['preferred_date'] != null
          ? DateTime.parse(json['preferred_date'])
          : DateTime.now(),
      preferredTime: json['preferred_time'] ?? '',
      problemDescription: json['problem_description'] ?? '',
      imageUrl: json['image_url'],
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'whatsapp_number': whatsappNumber,
      'email': email,
      'location': location,
      'service_needed': serviceNeeded,
      'preferred_date': preferredDate.toIso8601String(),
      'preferred_time': preferredTime,
      'problem_description': problemDescription,
      'image_url': imageUrl,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
