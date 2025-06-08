import 'package:either_dart/either.dart';
import 'package:manam_leave_management/domain/repositories/verify_email_repository.dart';

import '../../core/errors/failures.dart';
import '../entities/login_entity.dart';
import '../entities/verify_email_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyEmailUseCase {
  final VerifyEmailRepository verifyEmailRepository;

  VerifyEmailUseCase(this.verifyEmailRepository);

  Future<Either<Failure, VerifyEmailEntity>> call(String email) {
    return verifyEmailRepository.emailVerification(email);
  }
}
