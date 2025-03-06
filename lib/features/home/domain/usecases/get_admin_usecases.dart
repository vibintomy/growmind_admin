import 'package:growmind_admin/features/home/domain/entities/admin_entites.dart';
import 'package:growmind_admin/features/home/domain/repositories/admin_repositories.dart';

class GetAdminUsecases {
  final AdminRepositories adminRepositories;
  GetAdminUsecases(this.adminRepositories);

  Future<AdminEntities> call() {
    return adminRepositories.getAdminStats();
  }
}
