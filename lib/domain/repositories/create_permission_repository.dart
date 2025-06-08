import 'package:either_dart/either.dart';
import 'package:manam_leave_management/domain/entities/permission_entity.dart';

import '../../core/errors/failures.dart';
import '../../data/models/request/create_permission_model.dart';

abstract class CreatePermissionRepository {
  Future<Either<Failure, PermissionEntity>> createPermission(
      CreatePermissionModel createPermissionModel);
}
