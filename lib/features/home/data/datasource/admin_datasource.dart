import 'package:growmind_admin/features/home/domain/entities/admin_entites.dart';

abstract class AdminDatasource {
  Future<AdminEntities> getAdminStats();
}
