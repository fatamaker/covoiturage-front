import 'package:covoiturage2/domain/entities/vehicle.dart';

class APIConst {
  static const baseUrl = 'http://192.168.177.24:5000/api';

  //user
  static const register = '$baseUrl/register';
  static const login = '$baseUrl/login';
  static const userProfile = '$baseUrl/profile';
  static const updateProfile = '$baseUrl/profile/update';
  static const updatePassword = '$baseUrl/update-password';
  static const forgetPassword = '$baseUrl/forgetPassword';
  static const resetPassword = '$baseUrl/Resetpassword';
  static const verfifCode = '$baseUrl/VerifCode';
  static const updateUserImage = '$baseUrl/updateImage';

  //ride
  static const rides = '$baseUrl/rides';
  static const createOrUpdateRide = '$baseUrl/rides/createOrUpdateRide';
  static const updateRide = '$baseUrl/rides/update';
  static const deleteRide = '$baseUrl/rides/delete';

  //vehicle
  static const Vehicle = '$baseUrl/vehicles';

  //reservations
  static const reservations = '$baseUrl/reservations';
}
