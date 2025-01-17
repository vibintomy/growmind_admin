class FetchCategoryModel {
  final String id;
  final String? category;
  final String? imageUrl;

  FetchCategoryModel(
      {required this.id, required this.category, required this.imageUrl});

  factory FetchCategoryModel.fromFirestore(Map<String, dynamic> json) {
    return FetchCategoryModel(
        id: json['id'],
        category: json['category'] ?? '',
        imageUrl: json['imageUrl'] ?? '');
  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'category':category,  
      'imageUrl':imageUrl
    };
  }
}
