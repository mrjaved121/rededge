import 'dart:io';
import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/hive_service.dart';
import '../models/photo_model.dart';

class PhotoLocalDataSource {
  Box get _photosBox => HiveService.getBox(HiveService.photosBox);

  Future<void> savePhoto(PhotoModel photo) async {
    try {
      await _photosBox.put(photo.id, photo);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<List<PhotoModel>> getPhotosForStep(
      String jobId,
      String stepId,
      ) async {
    try {
      return _photosBox.values
          .cast<PhotoModel>()
          .where((p) => p.jobId == jobId && p.stepId == stepId)
          .toList()
        ..sort((a, b) => a.capturedAt.compareTo(b.capturedAt));
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> deletePhoto(String photoId) async {
    try {
      final photo = _photosBox.get(photoId) as PhotoModel?;
      if (photo != null) {
        // Delete file
        final file = File(photo.localPath);
        if (await file.exists()) await file.delete();
        // Delete record
        await _photosBox.delete(photoId);
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  static Future<String> savePhotoFile(Uint8List bytes, String photoId) async {
    final dir = await getApplicationDocumentsDirectory();
    final photoDir = Directory('${dir.path}/photos');
    await photoDir.create(recursive: true);
    final file = File('${photoDir.path}/$photoId.jpg');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}