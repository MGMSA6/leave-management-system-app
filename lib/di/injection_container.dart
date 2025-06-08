import 'package:get_it/get_it.dart';
import 'package:manam_leave_management/core/utils/common_service.dart';
import 'package:manam_leave_management/data/datasources/remote/create_request_datasource.dart';
import 'package:manam_leave_management/data/datasources/remote/current_user_applications_remote_datasource.dart';
import 'package:manam_leave_management/data/datasources/remote/get_req_by_id_datasource.dart';
import 'package:manam_leave_management/data/datasources/remote/holiday_remote_datasource.dart';
import 'package:manam_leave_management/data/datasources/remote/permission_datasource.dart';
import 'package:manam_leave_management/data/datasources/remote/update_request_datasource.dart';
import 'package:manam_leave_management/data/datasources/remote/verify_email_datasource.dart';
import 'package:manam_leave_management/data/repositories/get_req_by_id_repository_impl.dart';
import 'package:manam_leave_management/data/repositories/verify_email_repository_impl.dart';
import 'package:manam_leave_management/domain/repositories/change_password_repository.dart';
import 'package:manam_leave_management/domain/repositories/create_permission_repository.dart';
import 'package:manam_leave_management/domain/repositories/create_request_repository.dart';
import 'package:manam_leave_management/domain/repositories/current_user_application_repository.dart';
import 'package:manam_leave_management/domain/repositories/get_req_repository.dart';
import 'package:manam_leave_management/domain/repositories/update_request_repository.dart';
import 'package:manam_leave_management/domain/repositories/verify_email_repository.dart';
import 'package:manam_leave_management/domain/usecases/create_permission_usecase.dart';
import 'package:manam_leave_management/domain/usecases/current_user_application_usecase.dart';
import 'package:manam_leave_management/domain/usecases/get_req_by_id_usecase.dart';
import 'package:manam_leave_management/domain/usecases/holiday_usecase.dart';
import 'package:manam_leave_management/domain/usecases/update_request_usecase.dart';
import 'package:manam_leave_management/presentation/bloc/CurrentUserApplication/current_user_application_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/holiday/holiday_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/login/login_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/permission/new_permission_bloc.dart';
import 'package:manam_leave_management/presentation/bloc/verify/verify_email_bloc.dart';

import '../core/network/api_client.dart';
import '../core/network/network_info.dart';
import '../core/utils/session_manager.dart';
import '../data/datasources/remote/auth_remote_datasource.dart';
import '../data/datasources/remote/change_password_datasource.dart';
import '../data/datasources/remote/delete_request_datasource.dart';
import '../data/repositories/CreatePermissionRepositoryImpl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/change_password_repository_impl.dart';
import '../data/repositories/create_request_repository_impl.dart';
import '../data/repositories/current_user_application_repository_impl.dart';
import '../data/repositories/delete_request_repository_impl.dart';
import '../data/repositories/holiday_repository_impl.dart';
import '../data/repositories/update_request_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/delete_request_repository.dart';
import '../domain/repositories/holiday_repository.dart';
import '../domain/usecases/change_password_usecase.dart';
import '../domain/usecases/create_request_usecase.dart';
import '../domain/usecases/delete_request_usecase.dart';
import '../domain/usecases/get_user_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/verify_email_usecase.dart';
import '../presentation/bloc/profile/profile_bloc.dart';
import '../presentation/bloc/request/new_request_bloc.dart';
import '../presentation/bloc/session/session_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // External
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(
      () => sl<ApiClient>().instance); // This gives you Dio

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<GetReqRepository>(
      () => GetReqByIdRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<CurrentUserApplicationRepository>(
      () => CurrentUserApplicationRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<CreateRequestRepository>(
      () => CreateRequestRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<HolidayRepository>(
      () => HolidayRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<CreatePermissionRepository>(
      () => CreatePermissionRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<UpdateRequestRepository>(
      () => UpdateRequestRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<DeleteRequestRepository>(
      () => DeleteRequestRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<VerifyEmailRepository>(
      () => VerifyEmailRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(sl(), sl()));

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<GetReqByIdDatasource>(
      () => GetReqByIdDatasourceImpl(sl()));

  sl.registerLazySingleton<CurrentUserApplicationsRemoteDataSource>(
      () => CurrentUserApplicationsRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<CreateRequestDatasource>(
      () => CreateRequestDatasourceImpl(sl()));

  sl.registerLazySingleton<UpdateRequestDatasource>(
      () => UpdateRequestDatasourceImpl(sl()));

  sl.registerLazySingleton<HolidayRemoteDatasource>(
      () => HolidayRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<PermissionDataSource>(
      () => PermissionDataSourceImpl(sl()));

  sl.registerLazySingleton<DeleteRequestDataSource>(
      () => DeleteRequestDataSourceImpl(sl()));

  sl.registerLazySingleton<VerifyEmailDataSource>(
      () => VerifyEmailDataSourceImpl(sl()));

  sl.registerLazySingleton<ChangePasswordDatasource>(
      () => ChangePasswordDatasourceImpl(sl()));

  // Use Case
  sl.registerLazySingleton(() => GetUserUseCase());
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetReqByIdUseCase(sl()));
  sl.registerLazySingleton(() => CurrentUserApplicationUseCase(sl()));
  sl.registerLazySingleton(() => CreateRequestUseCase(sl()));
  sl.registerLazySingleton(() => UpdateRequestUseCase(sl()));
  sl.registerLazySingleton(() => HolidayUseCase(sl()));
  sl.registerLazySingleton(() => CreatePermissionUseCase(sl()));
  sl.registerLazySingleton(() => DeleteRequestUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));

  // Register SessionManager
  sl.registerLazySingleton(() => SessionManager());

  // Bloc
  sl.registerFactory(() => SessionBloc());
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => ProfileBloc(sl()));
  sl.registerFactory(() => CurrentUserApplicationBloc(sl()));
  sl.registerLazySingleton(() => NewRequestBloc(sl(), sl(), sl()));
  sl.registerFactory(() => HolidayBloc(sl()));
  sl.registerFactory(() => NewPermissionBloc(sl()));
  sl.registerFactory(() => VerifyEmailBloc(sl()));

  // Common
  sl.registerLazySingleton(() => CommonService());
}
