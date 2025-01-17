import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/category/domain/usecases/category_usecases.dart';
import 'package:growmind_admin/features/category/presentation/bloc/category_bloc/category_event.dart';
import 'package:growmind_admin/features/category/presentation/bloc/category_bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final UploadImageUsecase uploadImageUsecase;
  final SubmitCategoryUsecase submitCategoryUsecase;
  CategoryBloc(
      {required this.uploadImageUsecase, required this.submitCategoryUsecase})
      : super(CategoryInitial()) {
    on<UploadImageEvent>((event, emit) async {
      emit(ImageUpLoading());

      try {
        String imageUrl;
      
          if (event.fileBytes != null) {
          imageUrl = await uploadImageUsecase. uploadImageFromBytes(event.fileBytes!);
        } else {
          throw Exception('No file path or bytes provided for upload');
        }
        emit(ImageUploaded(imageUrl));
      } catch (e) {
        emit(CategoryError('Failed to upload image $e'));
      }
    });
    on<SubmitCategoryEvent>((event, emit) async {
      emit(CategorySubmitting());

      try {
        await submitCategoryUsecase(
            category: event.category, imageUrl: event.imageUrl);
        emit(CategorySucess());
      } catch (e) {
        emit(CategoryError('Failed to add Category'));
      }
    });
  }
}
