import 'dart:async';

import 'package:growmind_admin/features/category/domain/entities/subcategory.dart';

abstract class FetchSubcatRepo {
  Future<List<Subcategory>> fetchSubCategory({required String categoryId});
  Future<void> delete({required String categoryId,required String subcategoryId});
   Future<void> updateData({required String categoryId,required String subcategoryId,required String name});
}
