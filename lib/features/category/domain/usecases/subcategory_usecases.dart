import 'package:growmind_admin/features/category/domain/repository/subcategory_repo.dart';

class SubcategoryUsecases {
  final SubcategoryRepo subcategoryRepo;
  SubcategoryUsecases(this.subcategoryRepo);
  Future<void> call({required String name, required String categoryId}) {
    return subcategoryRepo.subcategory(name: name, categoryId: categoryId);
  }
}
