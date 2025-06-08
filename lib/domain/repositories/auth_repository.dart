import 'package:either_dart/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';

import '../entities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(String loginId, String password);
}
