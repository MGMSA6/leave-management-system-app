import 'package:either_dart/src/either.dart';

import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';

import 'package:manam_leave_management/data/models/response/base_model.dart';

import '../../core/network/network_info.dart';
import '../../domain/repositories/delete_request_repository.dart';
import '../datasources/remote/delete_request_datasource.dart';

class DeleteRequestRepositoryImpl extends DeleteRequestRepository {
  final DeleteRequestDataSource remoteDatasource;
  final NetworkInfo networkInfo;

  DeleteRequestRepositoryImpl(this.remoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, BaseModel>> deleteRequest(String id) {
    return SafeRepositoryCall.execute(
        call: () async {
          final response = await remoteDatasource.deleteRequest(id);
          return response.data!;
        },
        networkInfo: networkInfo);
  }
}
