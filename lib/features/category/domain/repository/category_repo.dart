import 'dart:typed_data';

abstract class CategoryRepo {
  Future<String> uploadImage(String filePath, {Uint8List? fileBytes});
  Future<String> uploadImageFromBytes(Uint8List fileBytes);
  Future<void> submitCategory(
      {required String category, required String imageUrl});
}
