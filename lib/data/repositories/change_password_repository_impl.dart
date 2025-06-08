import 'package:either_dart/src/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';
import 'package:manam_leave_management/data/models/response/base_model.dart';
import 'package:manam_leave_management/domain/entities/login_entity.dart';
import 'package:manam_leave_management/domain/repositories/auth_repository.dart';
import 'package:manam_leave_management/domain/repositories/change_password_repository.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../datasources/remote/change_password_datasource.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordDatasource changePasswordDatasource;
  final NetworkInfo networkInfo;

  ChangePasswordRepositoryImpl(this.changePasswordDatasource, this.networkInfo);

  @override
  Future<Either<Failure, BaseModel>> changePassword(
      String newPassword, String confirmPassword) async {
    return SafeRepositoryCall.execute(
      call: () =>
          changePasswordDatasource.changePassword(newPassword, confirmPassword),
      networkInfo: networkInfo,
    );
  }
}
