import 'package:either_dart/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/domain/entities/get_req_by_id_entity.dart';

import '../entities/login_entity.dart';

abstract class GetReqRepository {
  Future<Either<Failure, GetReqByIdEntity>> getReqById(String userId);
}
