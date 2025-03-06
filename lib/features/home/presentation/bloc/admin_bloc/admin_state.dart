import 'package:growmind_admin/features/home/domain/entities/admin_entites.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final AdminEntities adminEntities;
  AdminLoaded(this.adminEntities);
}

class AdminError extends AdminState {
  final String error;
  AdminError(this.error);
}
