import '../../core/utils/session_manager.dart';
import '../entities/login_entity.dart';

class GetUserUseCase {
  LoginEntity? call() => SessionManager().user;
}
