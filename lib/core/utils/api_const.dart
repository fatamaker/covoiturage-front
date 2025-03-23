class APIConst {
  static const baseUrl = 'https://mongrel-infinite-stallion.ngrok-free.app/api';

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
}
