import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/category/domain/usecases/subcategory_usecases.dart';
import 'package:growmind_admin/features/category/presentation/bloc/subcategory_bloc/subcategory_event.dart';
import 'package:growmind_admin/features/category/presentation/bloc/subcategory_bloc/subcategory_state.dart';

class SubcategoryBloc extends Bloc<SubcategoryEvent, SubcategoryState> {
  final SubcategoryUsecases subcategoryUsecases;
  SubcategoryBloc(this.subcategoryUsecases) : super(SubCategoryInitial()) {
    on<SubmitCategoryEvent>((event, emit) async {
      emit(SubCategorySubmitting());
      try {
        await subcategoryUsecases.call(
            name: event.name, categoryId: event.categoryId);
        emit(SubCategorySuccess());
      } catch (e) {
        emit(SubCategoryError(e.toString()));
      }
    });
  }
}
