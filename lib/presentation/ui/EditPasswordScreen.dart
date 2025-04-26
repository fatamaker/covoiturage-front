import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPassword extends StatefulWidget {
  EditPassword({super.key});

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 10.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(),
                  ),
                ),
                SizedBox(height: size.height * 0.001),
                Center(
                  child: Text(
                    'Update Password',
                    style: TextStyle(
                      fontSize: size.width * 0.09,
                      fontFamily: 'Yesteryear',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.001),
                Center(
                  child: Image.asset(
                    'assets/images/lock.png',
                    height: size.height * 0.35,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _oldpasswordController,
                        obscureText: _obscureOldPassword,
                        decoration: InputDecoration(
                          labelText: 'Old Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureOldPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureOldPassword = !_obscureOldPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your old password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        controller: _newpasswordController,
                        obscureText: _obscureNewPassword,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          prefixIcon: Icon(Icons.lock_reset),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureNewPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureNewPassword = !_obscureNewPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.05),
                      GetBuilder<AuthenticationController>(
                        builder: (controller) {
                          return SizedBox(
                            width: double.infinity,
                            height: 90,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.updatePassword(
                                    _oldpasswordController,
                                    _newpasswordController,
                                    context,
                                  );
                                }
                                Navigator.of(context).pop(true);
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                foregroundColor: Colors.white,
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFBFD834),
                                      Color(0xFF133A1B)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 88.0, minHeight: 36.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Save Changes",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
