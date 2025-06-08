import 'package:either_dart/either.dart';

import '../../core/errors/failures.dart';
import '../entities/holiday_entity.dart';

abstract class HolidayRepository {
  Future<Either<Failure,List<HolidayEntity>>> getAllHoliday();
}
