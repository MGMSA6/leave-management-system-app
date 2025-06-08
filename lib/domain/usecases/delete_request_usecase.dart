import 'package:either_dart/either.dart';

import '../../core/errors/failures.dart';
import '../../data/models/response/base_model.dart';
import '../repositories/delete_request_repository.dart';

class DeleteRequestUseCase {
  final DeleteRequestRepository deleteRequestRepository;

  DeleteRequestUseCase(this.deleteRequestRepository);

  Future<Either<Failure, BaseModel>> call(String id) async {
    return await deleteRequestRepository.deleteRequest(id);
  }
}
