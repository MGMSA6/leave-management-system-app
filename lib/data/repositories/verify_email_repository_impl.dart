import 'package:either_dart/src/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';
import 'package:manam_leave_management/domain/entities/login_entity.dart';
import 'package:manam_leave_management/domain/entities/verify_email_entity.dart';
import 'package:manam_leave_management/domain/repositories/auth_repository.dart';
import 'package:manam_leave_management/domain/repositories/verify_email_repository.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../datasources/remote/verify_email_datasource.dart';

class VerifyEmailRepositoryImpl implements VerifyEmailRepository {
  final VerifyEmailDataSource verifyEmailDataSource;
  final NetworkInfo networkInfo;

  VerifyEmailRepositoryImpl(this.verifyEmailDataSource, this.networkInfo);

  @override
  Future<Either<Failure, VerifyEmailEntity>> emailVerification(String email) {
    return SafeRepositoryCall.execute(
      call: () async {
        final response = await verifyEmailDataSource.verifyEmail(email);
        return response.data!.toEntity();
      },
      networkInfo: networkInfo,
    );
  }
}
