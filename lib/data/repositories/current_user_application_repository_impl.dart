import 'package:either_dart/src/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';
import 'package:manam_leave_management/data/datasources/remote/current_user_applications_remote_datasource.dart';
import 'package:manam_leave_management/domain/entities/current_user_application_entity.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/current_user_application_repository.dart';

class CurrentUserApplicationRepositoryImpl
    implements CurrentUserApplicationRepository {
  final CurrentUserApplicationsRemoteDataSource remoteDatasource;
  final NetworkInfo networkInfo;

  CurrentUserApplicationRepositoryImpl(this.remoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, CurrentUserApplicationEntity>>
      getCurrentUserApplicationData() async {
    return SafeRepositoryCall.execute(
        call: () async {
          final response =
              await remoteDatasource.getCurrentUserApplicationData();
          return response.data!.toEntity();
        },
        networkInfo: networkInfo);
  }
}
