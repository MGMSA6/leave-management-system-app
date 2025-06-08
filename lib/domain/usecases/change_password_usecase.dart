import 'package:either_dart/either.dart';
import 'package:manam_leave_management/data/models/response/base_model.dart';

import '../../core/errors/failures.dart';
import '../repositories/change_password_repository.dart';

class ChangePasswordUseCase {
  final ChangePasswordRepository changePasswordRepository;

  ChangePasswordUseCase(this.changePasswordRepository);

  Future<Either<Failure, BaseModel>> call(
      String newPassword, String confirmPassword) {
    return changePasswordRepository.changePassword(
        newPassword, confirmPassword);
  }
}
