import 'package:either_dart/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/domain/entities/verify_email_entity.dart';

import '../entities/login_entity.dart';

abstract class VerifyEmailRepository {
  Future<Either<Failure, VerifyEmailEntity>> emailVerification(String email);
}
