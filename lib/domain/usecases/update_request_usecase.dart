import 'package:either_dart/either.dart';
import 'package:manam_leave_management/data/models/request/create_request_model.dart';
import 'package:manam_leave_management/domain/repositories/create_request_repository.dart';
import 'package:manam_leave_management/domain/repositories/update_request_repository.dart';

import '../../core/errors/failures.dart';
import '../entities/response_entity.dart';

class UpdateRequestUseCase {
  final UpdateRequestRepository updateRequestRepository;

  UpdateRequestUseCase(this.updateRequestRepository);

  Future<Either<Failure, ResponseEntity>> call(
      String id, CreateRequestModel createRequestModel) async {
    return await updateRequestRepository.updateRequest(id, createRequestModel);
  }
}
