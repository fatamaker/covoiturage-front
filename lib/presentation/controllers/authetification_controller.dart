import 'dart:io';

import 'package:covoiturage2/core/utils/string_const.dart';
import 'package:covoiturage2/di.dart';
import 'package:covoiturage2/domain/entities/token.dart';
import 'package:covoiturage2/domain/entities/user.dart';
import 'package:covoiturage2/domain/usecases/userusecase/clear_user_image_usercase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/create_account_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/forget_password_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/get_user_by_id_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/login_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/logout_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/reset_password_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/update_image_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/update_password_usercase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/update_user_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/verify_otp_usecase.dart';
import 'package:covoiturage2/presentation/ui/HomePage.dart';
import 'package:covoiturage2/presentation/ui/LoginScreen.dart';
import 'package:covoiturage2/presentation/ui/OTPScreen.dart';
import 'package:covoiturage2/presentation/ui/ResetPassword.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  late Token token;
  late String myemail; //Stores the user's email during password recovery.
  bool termsAccepted =
      false; //Tracks whether terms and conditions are accepted.
  bool isLoading =
      false; //Indicates whether an asynchronous operation is in progress.
  late User currentUser; //Represents the logged-in user's data.
  String userImage = '';
  XFile? img;
  File? f; // Converts the XFile into a File object for further processing.
  String? role;
  String? birthDate;
  final ImagePicker _picker = ImagePicker();

  bool isPasswordVisible = false;

  bool get missingData =>
      currentUser.phone == null ||
      currentUser.governorate == null ||
      currentUser.birthDate == null;

  void setBirthDate(DateTime date) {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    birthDate = '$year-$month-$day';
    update();
  }

  void aceptTerms(bool v) {
    termsAccepted = v;
    update(['terms']);
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  // Future<void> pickImage() async {
  //   try {
  //     final img = await _picker.pickImage(source: ImageSource.gallery);
  //     if (img != null) {
  //       final f = File(img.path);
  //       setuserImage(basename(f.path));
  //     } else {
  //       // ignore: avoid_print
  //       print("No image selected");
  //     }
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print("Error while picking image: $e");
  //   }
  // }

  Future<void> pickImage() async {
    try {
      img = await _picker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        f = File(img!.path);
        setuserImage(basename(f!.path));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void setuserImage(String image) {
    userImage = image;
    update([ControllerID.UPDATE_USER_IMAGE]);
    update();
  }

  Future<String> createAccount({
    required TextEditingController email,
    required TextEditingController firstName,
    required TextEditingController governorate,
    required TextEditingController lastName,
    required TextEditingController password,
    required TextEditingController phone,
    required TextEditingController birthDate,
    required BuildContext context,
  }) async {
    String userid = "";

    // Validate birth date
    DateTime? parsedBirthDate;
    try {
      parsedBirthDate = DateTime.parse(birthDate.text);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Invalid birth date format. Please enter a valid date.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return userid;
    }

    // Call the backend API directly
    final res = await CreateAccountUsecase(sl()).call(
      email: email.text,
      password: password.text,
      governorate: governorate.text,
      phone: phone.text,
      firstName: firstName.text,
      lastName: lastName.text,
      imageUrl: '',
      birthDate: parsedBirthDate,
    );

    res.fold((l) {
      String errorMessage = l.message ?? "An error occurred";

      if (errorMessage.contains("User already exists")) {
        errorMessage =
            "Phone number already in use. Please use a different number.";
      }

      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }, (r) async {
      print("Response from create account: $r");

      email.clear();
      password.clear();
      firstName.clear();
      lastName.clear();
      phone.clear();
      governorate.clear();
      birthDate.clear();

      update();

      Fluttertoast.showToast(
        msg: "Registration successful! Redirecting to login...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFF1B6A3D),
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    });

    return userid;
  }

  Future<void> login(
      {required TextEditingController phone,
      required TextEditingController password,
      required BuildContext context}) async {
    isLoading = true;
    update();
    final res =
        await LoginUsecase(sl())(phone: phone.text, password: password.text);

    res.fold(
        (l) => Fluttertoast.showToast(
            msg: l.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0), (r) async {
      token = r;
      phone.clear();
      password.clear();
      // ignore: unused_local_variable
      final userRes = await getCurrentUser(r.userId);

      // final CartController cartController = Get.find();
      //await cartController.getCartByUserId(currentUser.id!);
      //final WishlistController wishListController = Get.find();

      //await wishListController.getWishlistByUserId(currentUser.id!);
      // ignore: use_build_context_synchronously
      //  await getOneUser(r.userId).then((value) async {

      //
      //   // final CategoryController categorControlller = Get.find();
      //   final AuthenticationController authController = Get.find();

      // });
      return Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    });
    isLoading = false;
    update();
  }

  Future<void> logout(BuildContext context) async {
    isLoading = false;
    update();
    await LogoutUsecase(sl())();
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  Future<void> sendFrogetPasswordRequest(TextEditingController useremail,
      String destionation, BuildContext context) async {
    String message = '';
    final res = await ForgetPasswordUsecase(sl())(
        email: useremail.text, destination: destionation);
    res.fold((l) => message = l.message!, (r) {
      myemail = useremail.text;
      useremail.clear();
      message = "email sent";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => OTPVerificationScreen()));
    });

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> verifyOTP(String otp, BuildContext context) async {
    if (otp.length == 4 && isNumeric(otp)) {
      final res = await OTPVerificationUsecase(sl())(
          email: myemail, otp: int.parse(otp));
      res.fold(
          (l) => Fluttertoast.showToast(
              msg: l.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0), (r) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Resetpassword()));
      });
    }
  }

  Future<void> resetPassword(TextEditingController password,
      TextEditingController cpassword, BuildContext context) async {
    String message = '';
    final res = await ResetPasswordUsecase(sl())(
        password: password.text, email: myemail);
    res.fold((l) => message = l.message!, (r) {
      password.clear();
      cpassword.clear();
      message = "password_reset";
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool isNumeric(String number) {
    for (int i = 0; i < number.length; i++) {
      if (!'0123456789'.contains(number[i])) {
        return false;
      }
    }
    return true;
  }

  Future<void> updateProfile(
      {required TextEditingController firstName,
      required TextEditingController lastName,
      required String address,
      required TextEditingController phone,
      required id,
      required String gender,
      required String birthDate,
      required BuildContext context}) async {
    String message = '';
    final res = await UpdateUserUsecase(sl())(
        firstName: firstName.text,
        lastName: lastName.text,
        adresse: address,
        phone: phone.text,
        id: id,
        gender: gender,
        birthDate: DateTime.parse(birthDate));
    res.fold((l) => message = l.message!, (r) async {
      message = "profile_updated";
      await getCurrentUser(currentUser.id!);
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> getCurrentUser(String userId) async {
    final res = await GetUserByIdUsecase(sl())(userId: userId);
    res.fold(
        (l) => Fluttertoast.showToast(
            msg: l.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0), (r) {
      currentUser = r;

      birthDate = currentUser.birthDate.toString();
    });
    update();
  }

  Future<void> updateImage(BuildContext context) async {
    try {
      if (f == null) {
        Fluttertoast.showToast(
          msg: "No image selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }

      if (userImage == '') {
        await ClearUserImageUsecase(sl())(currentUser.id!);
      } else {
        await UpdateImageUsecase(sl())(image: f!, userId: currentUser.id!);
      }

      await getCurrentUser(currentUser.id!).then((value) =>
          Fluttertoast.showToast(
              msg: "Profile picture updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0));
    } catch (e) {
      print('Error updating image: $e');
      Fluttertoast.showToast(
        msg: "Error updating image: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> updatePassword(TextEditingController currentPassword,
      TextEditingController password, BuildContext context) async {
    // Ensure currentUser is initialized first
    // ignore: unnecessary_null_comparison
    if (currentUser == null) {
      await getCurrentUser(currentUser.id!); // Fetch current user if null
    }

    // Check if currentUser is still null after fetching
    // ignore: unnecessary_null_comparison
    if (currentUser == null) {
      Fluttertoast.showToast(
          msg: "User data is not available. Please log in again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    String message = 'error';
    final res = await UpdatePasswordUsercase(sl())(
      userId: currentUser.id!,
      newPassword: password.text,
      oldPassword: currentPassword.text,
    );
    res.fold((l) => message = l.message!, (r) async {
      message = "profile_updated";
      password.clear();
      currentPassword.clear();
      await getCurrentUser(currentUser.id!);
    });

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
