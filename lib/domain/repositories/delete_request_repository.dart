import 'package:either_dart/either.dart';
import 'package:manam_leave_management/data/models/response/base_model.dart';

import '../../core/errors/failures.dart';

abstract class DeleteRequestRepository {
  Future<Either<Failure, BaseModel>> deleteRequest(String id);
}
