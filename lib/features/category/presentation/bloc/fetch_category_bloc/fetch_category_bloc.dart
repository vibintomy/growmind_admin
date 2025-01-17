import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/category/domain/usecases/fetch_category_usecases.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_category_bloc/fetch_category_event.dart';
import 'package:growmind_admin/features/category/presentation/bloc/fetch_category_bloc/fetch_category_state.dart';

class FetchCategoryBloc extends Bloc<FetchCategoryEvent, FetchCategoryState> {
  final GetCategory getCategory;
  FetchCategoryBloc(this.getCategory) : super(FetchCategoryInitial()) {
    on<FetchCategoryEvent>((event, emit) async {
      emit(FetchCategoryLoading());
      try {
        final fetchCategory = await getCategory.call();
       
        emit(FetchCategoryLoaded(fetchCategory));
      } catch (e) {
        emit(FetchCategoryError(e.toString()));
      }
    });
  }
}
