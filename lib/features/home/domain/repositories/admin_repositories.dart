
import 'package:growmind_admin/features/home/domain/entities/admin_entites.dart';

abstract class AdminRepositories {
  Future< AdminEntities> getAdminStats();
}
