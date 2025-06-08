import 'package:either_dart/either.dart';
import 'package:manam_leave_management/data/models/request/create_request_model.dart';
import 'package:manam_leave_management/domain/repositories/create_request_repository.dart';

import '../../core/errors/failures.dart';
import '../entities/response_entity.dart';

class CreateRequestUseCase {
  final CreateRequestRepository createRequestRepository;

  CreateRequestUseCase(this.createRequestRepository);

  Future<Either<Failure, ResponseEntity>> call(
      CreateRequestModel createRequestModel) async {
    return await createRequestRepository.createRequest(createRequestModel);
  }
}
