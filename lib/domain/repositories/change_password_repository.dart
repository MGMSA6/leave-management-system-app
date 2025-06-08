import 'package:either_dart/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/data/models/response/base_model.dart';

import '../entities/login_entity.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, BaseModel>> changePassword(
      String newPassword, String confirmPassword);
}
