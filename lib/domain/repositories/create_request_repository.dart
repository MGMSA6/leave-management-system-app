import 'package:either_dart/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/data/models/request/create_request_model.dart';
import 'package:manam_leave_management/domain/entities/response_entity.dart';


abstract class CreateRequestRepository {
  Future<Either<Failure, ResponseEntity>> createRequest(
      CreateRequestModel createRequestModel);
}
