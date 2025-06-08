import 'package:either_dart/src/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';
import 'package:manam_leave_management/data/datasources/remote/create_request_datasource.dart';
import 'package:manam_leave_management/data/models/request/create_request_model.dart';
import 'package:manam_leave_management/domain/entities/response_entity.dart';
import 'package:manam_leave_management/domain/repositories/create_request_repository.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';

class CreateRequestRepositoryImpl implements CreateRequestRepository {
  final CreateRequestDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  CreateRequestRepositoryImpl(this.remoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, ResponseEntity>> createRequest(
      CreateRequestModel createRequestModel) async {
    return SafeRepositoryCall.execute<ResponseEntity>(
        call: () async {
          final response =
              await remoteDatasource.createRequest(createRequestModel);
          return response.data!.totoEntity();
        },
        networkInfo: networkInfo);
  }
}
