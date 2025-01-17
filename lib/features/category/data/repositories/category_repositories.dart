import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_admin/core/utils/cloudinary.dart';
import 'package:growmind_admin/features/category/domain/repository/category_repo.dart';

class CategoryRepositoriesImpl extends CategoryRepo {
  final Cloudinary cloudinary;
  final FirebaseFirestore firestore;
  CategoryRepositoriesImpl({required this.cloudinary, required this.firestore});

  @override
  Future<String> uploadImage(String filePath, {Uint8List? fileBytes}) async {
    try {
      final imageUrl = fileBytes != null
          ? await cloudinary.uploadImageFromBytes(fileBytes)
          : await cloudinary.uploadImage(File(filePath));

      return imageUrl;
    } catch (e) {
      throw Exception('Cloudinary upload error $e');
    }
  }

  @override
  Future<String> uploadImageFromBytes(Uint8List fileBytes) async {
    try {
      final imageUrl = await cloudinary.uploadImageFromBytes(fileBytes);
      return imageUrl;
    } catch (e) {
      throw Exception('Cloudinary upload error $e');
    }
  }

  @override
  Future<void> submitCategory({
    required String category,
    required String imageUrl,
  }) async {
    try {
      final categoryValues = await firestore.collection('category').add({
        'category': category,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
       
      });
      await categoryValues.update({'id': categoryValues.id});
    } catch (e) {
      throw Exception('Firestore error');
    }
  }
}
