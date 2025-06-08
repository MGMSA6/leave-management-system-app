import 'package:either_dart/either.dart';

import '../../core/errors/failures.dart';
import '../entities/login_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, LoginEntity>> call(String loginId, String password) {
    return repository.login(loginId, password);
  }
}
