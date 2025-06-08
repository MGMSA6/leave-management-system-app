import 'package:either_dart/src/either.dart';
import 'package:manam_leave_management/core/errors/failures.dart';
import 'package:manam_leave_management/core/utils/safe_repository_call.dart';
import 'package:manam_leave_management/domain/entities/holiday_entity.dart';
import 'package:manam_leave_management/domain/repositories/holiday_repository.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../datasources/remote/holiday_remote_datasource.dart';

class HolidayRepositoryImpl extends HolidayRepository {
  final HolidayRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  HolidayRepositoryImpl(this.remoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, List<HolidayEntity>>> getAllHoliday() async {
    return SafeRepositoryCall.execute(
        call: () async {
          final response = await remoteDatasource.getAllHoliday();
          final models = response.data!;
          return models.map((m) => m.toEntity()).toList();
        },
        networkInfo: networkInfo);
  }
}
