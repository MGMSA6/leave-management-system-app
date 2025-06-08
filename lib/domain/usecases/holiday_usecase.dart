import 'package:either_dart/either.dart';

import '../../core/errors/failures.dart';
import '../entities/holiday_entity.dart';
import '../repositories/holiday_repository.dart';

class HolidayUseCase {
  final HolidayRepository repository;

  HolidayUseCase(this.repository);

  Future<Either<Failure, List<HolidayEntity>>> call() {
    return repository.getAllHoliday();
  }
}
