import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/home/domain/usecases/get_admin_usecases.dart';
import 'package:growmind_admin/features/home/presentation/bloc/admin_bloc/admin_event.dart';
import 'package:growmind_admin/features/home/presentation/bloc/admin_bloc/admin_state.dart';

class AdminBloc extends Bloc <AdminEvent,AdminState>{
  final GetAdminUsecases getAdminUsecases;
  AdminBloc(this.getAdminUsecases) : super(AdminInitial()) {
    on<GetAdminEvent>((event, emit) async {
      emit(AdminLoading());
      try {
        final getValues = await getAdminUsecases.call();
        emit(AdminLoaded(getValues));
      } catch (e) {
        emit(AdminError(e.toString()));
      }
    });
  }
}
