import 'package:growmind_admin/features/category/domain/entities/category.dart';
import 'package:growmind_admin/features/category/domain/repository/fetch_cat_repo.dart';

class GetCategory {
  final FetchCatRepo fetchCatRepo;
  GetCategory(this.fetchCatRepo);

  Future<List<FetchCategory>> call() async {
    final category = await fetchCatRepo.fetchcategory();
    return category;
  }
}
