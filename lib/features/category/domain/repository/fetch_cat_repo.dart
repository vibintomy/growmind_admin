
import 'package:growmind_admin/features/category/domain/entities/category.dart';
abstract class FetchCatRepo {
  Future<List<FetchCategory>>fetchcategory();
}