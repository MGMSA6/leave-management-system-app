import 'package:either_dart/src/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';
import 'package:manam_leave_management/domain/entities/get_req_by_id_entity.dart';
import 'package:manam_leave_management/domain/repositories/get_req_repository.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../datasources/remote/get_req_by_id_datasource.dart';

class GetReqByIdRepositoryImpl implements GetReqRepository {
  final GetReqByIdDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  GetReqByIdRepositoryImpl(this.remoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetReqByIdEntity>> getReqById(String userId) async {
    return SafeRepositoryCall.execute(
        call: () async {
          final response = await remoteDatasource.getReqById(userId);
          return response.data.toEntity();
        },
        networkInfo: networkInfo);
  }
}
