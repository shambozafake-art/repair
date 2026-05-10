import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class UploadService {
  static final _storage = SupabaseService.client.storage;
  static const String _bucketName = 'project-images';

  static Future<String> uploadImage(Uint8List bytes, String fileName) async {
    final path = 'images/\${DateTime.now().millisecondsSinceEpoch}_\$fileName';
    await _storage.from(_bucketName).uploadBinary(path, bytes);
    return _storage.from(_bucketName).getPublicUrl(path);
  }

  static Future<void> deleteImage(String url) async {
    try {
      final path = url.split('/').last;
      await _storage.from(_bucketName).remove([path]);
    } catch (e) {
      // Ignore deletion errors
    }
  }
}
