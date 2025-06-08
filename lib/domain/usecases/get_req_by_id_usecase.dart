import 'package:either_dart/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/domain/entities/get_req_by_id_entity.dart';
import 'package:manam_leave_management/domain/repositories/get_req_repository.dart';

class GetReqByIdUseCase {
  final GetReqRepository getReqRepository;

  GetReqByIdUseCase(this.getReqRepository);

  Future<Either<Failure, GetReqByIdEntity>> call(String userId) async {
    return await getReqRepository.getReqById(userId);
  }
}
