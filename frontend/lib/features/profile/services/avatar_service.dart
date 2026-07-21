import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AvatarService {
  AvatarService._();

  static final AvatarService instance = AvatarService._();

  final SupabaseClient _supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  Future<File?> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (image == null) return null;

    return File(image.path);
  }

  /// Pick image from camera
  Future<File?> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (image == null) return null;

    return File(image.path);
  }

  /// Compress image before upload
  Future<File> compressImage(File file) async {
    final bytes = await file.readAsBytes();

    final image = img.decodeImage(bytes);

    if (image == null) {
      return file;
    }

    final resized = img.copyResize(image, width: 600);

    final jpg = img.encodeJpg(resized, quality: 85);

    final dir = await getTemporaryDirectory();

    final compressed = File('${dir.path}/avatar.jpg');

    await compressed.writeAsBytes(jpg);

    return compressed;
  }

  /// Upload avatar and return public URL
  Future<String> uploadAvatar(File imageFile) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in.");
    }

    final compressed = await compressImage(imageFile);

    final path = '${user.id}/profile.jpg';

    await _supabase.storage
        .from('avatars')
        .upload(path, compressed, fileOptions: const FileOptions(upsert: true));

    return _supabase.storage.from('avatars').getPublicUrl(path);
  }

  /// Delete avatar
  Future<void> deleteAvatar() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return;

    await _supabase.storage.from('avatars').remove(['${user.id}/profile.jpg']);
  }
}
