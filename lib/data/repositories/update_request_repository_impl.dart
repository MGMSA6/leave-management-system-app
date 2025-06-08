import 'package:either_dart/src/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';
import 'package:manam_leave_management/data/datasources/remote/create_request_datasource.dart';
import 'package:manam_leave_management/data/datasources/remote/update_request_datasource.dart';
import 'package:manam_leave_management/data/models/request/create_request_model.dart';
import 'package:manam_leave_management/domain/entities/response_entity.dart';
import 'package:manam_leave_management/domain/repositories/create_request_repository.dart';
import 'package:manam_leave_management/domain/repositories/update_request_repository.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';

class UpdateRequestRepositoryImpl implements UpdateRequestRepository {
  final UpdateRequestDatasource updateRequestDatasource;
  final NetworkInfo networkInfo;

  UpdateRequestRepositoryImpl(this.updateRequestDatasource, this.networkInfo);

  @override
  Future<Either<Failure, ResponseEntity>> updateRequest(
      String id, CreateRequestModel createRequestModel) async {
    return SafeRepositoryCall.execute<ResponseEntity>(
        call: () async {
          final response = await updateRequestDatasource.updateRequest(
              id, createRequestModel);
          return response.data!.totoEntity();
        },
        networkInfo: networkInfo);
  }
}
