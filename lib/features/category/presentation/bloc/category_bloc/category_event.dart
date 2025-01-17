import 'dart:typed_data';

abstract class CategoryEvent {}

class UploadImageEvent extends CategoryEvent {
 
  final Uint8List? fileBytes;
  UploadImageEvent(this.fileBytes);
}

class SubmitCategoryEvent extends CategoryEvent {
  final String category;
  final String imageUrl;
  

  SubmitCategoryEvent(
      {required this.category, required this.imageUrl});
}

