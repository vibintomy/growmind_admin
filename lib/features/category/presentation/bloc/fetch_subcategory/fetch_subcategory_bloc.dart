import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/category/domain/usecases/fetch_subcategory_usecases.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_event.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_subcategory/fetch_subcategory_state.dart';

class FetchSubcategoryBloc
    extends Bloc<FetchSubcategoryEvent, FetchSubcategoryState> {
  final GetSubcategory subcategory;
  FetchSubcategoryBloc(this.subcategory) : super(FetchSubcategoryInitial()) {
    on<GetSubcategoryEvent>((event, emit) async {
      emit(FetchSubcategoryLoading());
      try {
        final fetchSubCategory =
            await subcategory.call(categoryId: event.categoryId);
        emit(FetchSubcategoryLoaded(fetchSubCategory));
      } catch (e) {
        emit(FetchSubcategoryError('Error to fetch data'));
      }
    });

    on<DeleteSubcategoryEvent>((event, emit) async {
      emit(FetchSubcategoryLoading());
      try {
        await subcategory.delete(
            categoryId: event.categoryId, subcategoryId: event.subcategoryId);
        final updatedSubCategory =
            await subcategory.call(categoryId: event.categoryId);
        emit(FetchSubcategoryLoaded(updatedSubCategory));
      } catch (e) {
        throw Exception(FetchSubcategoryError('Error to delete the data'));
      }
    });
    on<UpdateSubcategoryEvent>((event, emit) async {
      emit(FetchSubcategoryLoading());

      try {
        await subcategory.updateData(
            categoryId: event.categoryId,
            subcategoryId: event.subcategoryId,
            name: event.name);
      
        final updatedSubCategory =
            await subcategory.call(categoryId: event.categoryId);

        emit(FetchSubcategoryLoaded(updatedSubCategory));
      } catch (e) {
        throw Exception(FetchSubcategoryError('Error in updating data'));
      }
    });
  }
}
