import 'package:growmind_admin/features/home/data/datasource/admin_datasource.dart';
import 'package:growmind_admin/features/home/domain/entities/admin_entites.dart';
import 'package:growmind_admin/features/home/domain/repositories/admin_repositories.dart';

class AdminRepoImpl implements AdminRepositories {
  final AdminDatasource adminDatasource;
  AdminRepoImpl(this.adminDatasource);
  @override
  Future<AdminEntities> getAdminStats() async {
    return await adminDatasource.getAdminStats();
  }
}
