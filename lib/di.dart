import 'package:covoiturage2/data/data-source/local_data_source/authentication_local_data_source.dart';
import 'package:covoiturage2/data/data-source/remote_data_source/remote_authentication_data_source.dart';
import 'package:covoiturage2/data/repository/user_repository_impl.dart';
import 'package:covoiturage2/domain/repository/authentication_repository.dart';
import 'package:covoiturage2/domain/usecases/userusecase/create_account_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/forget_password_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/get_user_by_id_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/login_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/reset_password_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/update_password_usercase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/update_user_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/verify_otp_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* repositories */
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  // /* data sources */
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());

  /* usecases */
  //authentication//
  sl.registerLazySingleton(() => CreateAccountUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => OTPVerificationUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetUserByIdUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePasswordUsercase(sl()));
}
