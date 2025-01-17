class FetchSubcategoryModel {
  final String id;
  final String name;
  FetchSubcategoryModel({required this.id, required this.name});

  factory FetchSubcategoryModel.fromFirestore(Map<String, dynamic> json) {
    return FetchSubcategoryModel(
        id: json['id'] ?? '', name: json['name'] ?? '');
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
