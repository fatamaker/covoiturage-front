import 'package:covoiturage2/data/data-source/local_data_source/authentication_local_data_source.dart';
import 'package:covoiturage2/data/data-source/remote_data_source/remote_authentication_data_source.dart';
import 'package:covoiturage2/data/data-source/remote_data_source/ride_remote_data_source.dart';
import 'package:covoiturage2/data/data-source/remote_data_source/vehicle_remote_data_source.dart';
import 'package:covoiturage2/data/repository/ride_repository_impl.dart';
import 'package:covoiturage2/data/repository/user_repository_impl.dart';
import 'package:covoiturage2/data/repository/vehicle_repository_impl.dart';
import 'package:covoiturage2/domain/repository/RideRepository.dart';
import 'package:covoiturage2/domain/repository/VehicleRepository.dart';
import 'package:covoiturage2/domain/repository/authentication_repository.dart';
import 'package:covoiturage2/domain/usecases/rideUsecase/CreateOrUpdate_ride_usecase.dart';
import 'package:covoiturage2/domain/usecases/rideUsecase/create_ride_usecase.dart';
import 'package:covoiturage2/domain/usecases/rideUsecase/delete_ride_usecase.dart';
import 'package:covoiturage2/domain/usecases/rideUsecase/get_all_rides_usecase.dart';
import 'package:covoiturage2/domain/usecases/rideUsecase/get_ridebyId_usecase.dart';
import 'package:covoiturage2/domain/usecases/rideUsecase/update_ride_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/create_account_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/forget_password_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/get_user_by_id_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/login_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/reset_password_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/update_password_usercase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/update_user_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/verify_otp_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleUsecase/get_all_vehicles_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleusecase/create_vehicle_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleusecase/delete_vehicle_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleusecase/get_vehicleById_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleusecase/get_vehicles_bydriver_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleusecase/update_vehicle_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* repositories */
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<RideRepository>(
    () => RideRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<VehicleRepository>(
    () => VehicleRepositoryImpl(sl()),
  );

  // /* data sources */
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
  sl.registerLazySingleton<RideRemoteDataSource>(
      () => RideRemoteDataSourceImpl());
  sl.registerLazySingleton<VehicleRemoteDataSource>(
      () => VehicleRemoteDataSourceImpl());

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

  //ride//
  sl.registerLazySingleton(() => CreateRideUsecase(sl()));
  sl.registerLazySingleton(() => CreateOrUpdateRideUsecase(sl()));
  sl.registerLazySingleton(() => DeleteRideUsecase(sl()));
  sl.registerLazySingleton(() => GetAllRidesUsecase(sl()));
  sl.registerLazySingleton(() => GetRideByIdUsecase(sl()));
  sl.registerLazySingleton(() => UpdateRideUsecase(sl()));

  //vehicle//
  sl.registerLazySingleton(() => CreateVehicleUsecase(sl()));
  sl.registerLazySingleton(() => DeleteVehicleUsecase(sl()));
  sl.registerLazySingleton(() => GetAllVehiclesUsecase(sl()));
  sl.registerLazySingleton(() => GetVehiclesByDriverUsecase(sl()));
  sl.registerLazySingleton(() => GetVehicleByIdUsecase(sl()));
  sl.registerLazySingleton(() => UpdateVehicleUsecase(sl()));
}
