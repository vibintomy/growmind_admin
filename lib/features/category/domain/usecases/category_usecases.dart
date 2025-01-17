import 'dart:typed_data';

import 'package:growmind_admin/features/category/domain/repository/category_repo.dart';

class UploadImageUsecase {
  final CategoryRepo repository;
  UploadImageUsecase(this.repository);
  Future<String> call(String filePath, {Uint8List? fileBytes}) async {
    return repository.uploadImage(filePath, fileBytes: fileBytes);
  }

  Future<String> uploadImageFromBytes(Uint8List fileBytes) async {
    return repository.uploadImageFromBytes(fileBytes);
  }
}

class SubmitCategoryUsecase {
  final CategoryRepo repository;
  SubmitCategoryUsecase(this.repository);
  Future<void> call({
    required String category,
    required String imageUrl,
  }) {
    return repository.submitCategory(category: category, imageUrl:imageUrl );
  }
}
