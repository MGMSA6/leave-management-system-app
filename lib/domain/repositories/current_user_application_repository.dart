import 'package:either_dart/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/domain/entities/current_user_application_entity.dart';
import 'package:manam_leave_management/domain/entities/get_req_by_id_entity.dart';

import '../entities/login_entity.dart';

abstract class CurrentUserApplicationRepository {
  Future<Either<Failure, CurrentUserApplicationEntity>>
      getCurrentUserApplicationData();
}
