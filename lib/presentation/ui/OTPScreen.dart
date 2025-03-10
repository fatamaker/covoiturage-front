import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OTPVerificationScreen extends StatefulWidget {
  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> digitControllers =
      List.generate(4, (index) => TextEditingController());

  String getCombinedOTP() {
    return digitControllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 90),
                Text(
                  'OTP Verification',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 80),
                Text(
                  'We have sent the verification code to your email address',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 90),
                // OTP Input Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        height: 60,
                        width: 50,
                        child: TextFormField(
                          controller: digitControllers[index],
                          onChanged: (value) {
                            if (value.length == 1 && index < 3) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 150),
                // Continue Button
                ElevatedButton(
                  onPressed: () async {
                    final AuthenticationController controller = Get.find();
                    String otpCode = getCombinedOTP();
                    print("Entered OTP: $otpCode");
                    await controller.verifyOTP(otpCode, context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF125B3C),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 7,
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontFamily: 'LilitaOne',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50, // Adjust the position here
            left: 10,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
