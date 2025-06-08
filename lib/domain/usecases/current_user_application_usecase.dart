import 'package:either_dart/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/domain/entities/current_user_application_entity.dart';
import 'package:manam_leave_management/domain/repositories/current_user_application_repository.dart';

class CurrentUserApplicationUseCase {
  final CurrentUserApplicationRepository currentUserApplicationRepository;

  CurrentUserApplicationUseCase(this.currentUserApplicationRepository);

  Future<Either<Failure, CurrentUserApplicationEntity>> call() async {
    return await currentUserApplicationRepository
        .getCurrentUserApplicationData();
  }
}
