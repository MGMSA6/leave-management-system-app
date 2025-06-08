import 'package:either_dart/src/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';
import 'package:manam_leave_management/domain/entities/login_entity.dart';
import 'package:manam_leave_management/domain/repositories/auth_repository.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDatasource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.remoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, LoginEntity>> login(
      String loginId, String password) async {
    return SafeRepositoryCall.execute(
        call: () async {
          final response = await remoteDatasource.login(loginId, password);
          return response.data!.toEntity();
        },
        networkInfo: networkInfo);
  }
}
