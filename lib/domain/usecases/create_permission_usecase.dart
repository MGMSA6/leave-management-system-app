import 'package:either_dart/either.dart';

import '../../core/errors/failures.dart';
import '../../data/models/request/create_permission_model.dart';
import '../entities/permission_entity.dart';
import '../repositories/create_permission_repository.dart';

class CreatePermissionUseCase {
  final CreatePermissionRepository createPermissionRepository;

  CreatePermissionUseCase(this.createPermissionRepository);

  Future<Either<Failure, PermissionEntity>> call(
      CreatePermissionModel createPermissionModel) async {
    return await createPermissionRepository
        .createPermission(createPermissionModel);
  }
}
