import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:growmind_admin/core/utils/cloudinary.dart';
import 'package:growmind_admin/features/category/data/datasource/category_remote_datasource.dart';
import 'package:growmind_admin/features/category/data/datasource/subcategory_remote_datasource.dart';
import 'package:growmind_admin/features/category/data/repositories/category_repositories.dart';
import 'package:growmind_admin/features/category/data/repositories/fetch_category_repo_impl.dart';
import 'package:growmind_admin/features/category/data/repositories/fetch_subcategory_repo_impl.dart';
import 'package:growmind_admin/features/category/data/repositories/subcatgor_rep_impl.dart';
import 'package:growmind_admin/features/category/domain/repository/category_repo.dart';
import 'package:growmind_admin/features/category/domain/repository/fetch_cat_repo.dart';
import 'package:growmind_admin/features/category/domain/repository/fetch_subcat_repo.dart';
import 'package:growmind_admin/features/category/domain/repository/subcategory_repo.dart';
import 'package:growmind_admin/features/category/domain/usecases/category_usecases.dart';
import 'package:growmind_admin/features/category/domain/usecases/fetch_category_usecases.dart';
import 'package:growmind_admin/features/category/domain/usecases/fetch_subcategory_usecases.dart';
import 'package:growmind_admin/features/category/domain/usecases/subcategory_usecases.dart';
import 'package:growmind_admin/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_category_bloc/fetch_category_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_bloc.dart';
import 'package:growmind_admin/features/category/presentation/bloc/subcategory_bloc/subcategory_bloc.dart';

final getIt = GetIt.instance;
//  data layer
void setUp() {
  getIt.registerLazySingleton<Cloudinary>(() => Cloudinary.signedConfig(
      cloudName: 'dj01ka9ga',
      apiKey: '642889674424333',
      apiSecret: 'EB9XFjTTm5kNygU6hxJMls79Tj8'));
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<CategoryRepo>(() => CategoryRepositoriesImpl(
      cloudinary: getIt<Cloudinary>(), firestore: getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<CategoryRemoteDatasource>(
      () => CategoryRemoteDatasource(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<FetchCatRepo>(() => FetchCategoryRepoImpl(
      getIt<CategoryRemoteDatasource>(), getIt<FirebaseFirestore>()));

  getIt.registerLazySingleton<SubcategoryRepo>(
      () => SubcatgorRepImpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<SubcategoryRemoteDatasource>(
      () => SubcategoryRemoteDatasource(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<FetchSubcatRepo>(() => FetchSubcategoryRepoImpl(
      getIt<SubcategoryRemoteDatasource>(), getIt<FirebaseFirestore>()));

// domain layer

  getIt.registerLazySingleton(() => UploadImageUsecase(getIt<CategoryRepo>()));
  getIt.registerLazySingleton(
      () => SubmitCategoryUsecase(getIt<CategoryRepo>()));
  getIt.registerLazySingleton(() => GetCategory(getIt<FetchCatRepo>()));

  getIt.registerLazySingleton(
      () => SubcategoryUsecases(getIt<SubcategoryRepo>()));
  getIt.registerLazySingleton(() => GetSubcategory(getIt<FetchSubcatRepo>()));

  //  presentation layer
  getIt.registerFactory(() => CategoryBloc(
      uploadImageUsecase: getIt<UploadImageUsecase>(),
      submitCategoryUsecase: getIt<SubmitCategoryUsecase>()));

  getIt.registerFactory(() => FetchCategoryBloc(getIt<GetCategory>()));

  getIt.registerFactory(() => SubcategoryBloc(getIt<SubcategoryUsecases>()));

  getIt.registerFactory(() => FetchSubcategoryBloc(getIt<GetSubcategory>()));
}
