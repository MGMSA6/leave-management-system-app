import 'package:either_dart/src/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';
import 'package:manam_leave_management/data/models/request/create_permission_model.dart';
import 'package:manam_leave_management/domain/entities/permission_entity.dart';
import 'package:manam_leave_management/domain/repositories/create_permission_repository.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../datasources/remote/permission_datasource.dart';

class CreatePermissionRepositoryImpl implements CreatePermissionRepository {
  final PermissionDataSource permissionDatasource;
  final NetworkInfo networkInfo;

  CreatePermissionRepositoryImpl(this.permissionDatasource, this.networkInfo);

  @override
  Future<Either<Failure, PermissionEntity>> createPermission(
      CreatePermissionModel createPermissionModel) async {
    return SafeRepositoryCall.execute(
        call: () async {
          final response = await permissionDatasource
              .createPermission(createPermissionModel);
          return response.data!.toEntity();
        },
        networkInfo: networkInfo);
  }
}
