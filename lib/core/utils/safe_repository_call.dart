import 'package:either_dart/either.dart';

import '../errors/exceptions.dart';
import '../errors/failures.dart';
import '../network/network_info.dart';

class SafeRepositoryCall {
  static Future<Either<Failure, T>> execute<T>({
    required Future<T> Function() call,
    required NetworkInfo networkInfo,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await call();
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on UnexpectedException catch (e) {
        return Left(UnexpectedFailure(e.message));
      } catch (e) {
        return Left(UnexpectedFailure("Unexpected error: ${e.toString()}"));
      }
    } else {
      return Left(NetworkFailure("No internet connection"));
    }
  }
}
