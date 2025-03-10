import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:covoiturage2/presentation/ui/LoginScreen.dart';
import 'package:intl/intl.dart'; // Add this import for DateFormat

class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedRole = "";
  final TextEditingController selectedGovernorate = TextEditingController();

  DateTime? _selectedBirthdate;

  final DateFormat format = DateFormat("yyyy-MM-dd");

  void _pickBirthdate(BuildContext context) async {
    DateTime initialDate = _selectedBirthdate ?? DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthdate = pickedDate;
        dobController.text = format.format(_selectedBirthdate!);
      });
    }
  }

  final List<String> governorates = [
    "Ariana",
    "Beja",
    "Ben Arous",
    "Bizerte",
    "Gabes",
    "Gafsa",
    "Jendouba",
    "Kairouan",
    "Kasserine",
    "Kebili",
    "Kef",
    "Mahdia",
    "Manouba",
    "Medenine",
    "Monastir",
    "Nabeul",
    "Sfax",
    "Sidi Bouzid",
    "Siliana",
    "Sousse",
    "Tataouine",
    "Tozeur",
    "Tunis",
    "Zaghouan"
  ];

  @override
  Widget build(BuildContext context) {
    final AuthenticationController controller = Get.find();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: GetBuilder<AuthenticationController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text("Create an account",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      text: "Enter your account details below or ",
                      style: TextStyle(fontSize: 15),
                      children: [
                        TextSpan(
                          text: "log in",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => LoginScreen()),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  /// Input Fields
                  _buildTextField("First name", firstNameController),
                  _buildTextField("Last name", lastNameController),

                  _buildDatePickerField(
                    context: context,
                    label: "Date of Birth",
                    controller: dobController, // Pass the controller directly
                  ),
                  _buildTextField("Email", emailController,
                      keyboardType: TextInputType.emailAddress),
                  _buildTextField("Phone Number", phoneController,
                      keyboardType: TextInputType.phone),

                  /// Governorate Dropdown
                  Text("Governorate", style: TextStyle(fontSize: 17)),
                  SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedGovernorate.text.isNotEmpty
                        ? selectedGovernorate.text
                        : null,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    items: governorates.map((String governorate) {
                      return DropdownMenuItem<String>(
                          value: governorate, child: Text(governorate));
                    }).toList(),
                    onChanged: (value) {
                      selectedGovernorate.text = value!;
                    },
                  ),
                  SizedBox(height: 15),

                  /// Password Field
                  Text("Password", style: TextStyle(fontSize: 17)),
                  SizedBox(height: 5),
                  TextField(
                    controller: passwordController,
                    obscureText: !controller.isPasswordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                            controller.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  /// Role Selection
                  Text("Role", style: TextStyle(fontSize: 17)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildRadioOption("Passager"),
                      _buildRadioOption("Conducteur"),
                    ],
                  ),
                  SizedBox(height: 40),

                  /// Sign Up Button
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFFBFD834), Color(0xFF133A1B)]),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextButton(
                      onPressed: () {
                        controller.createAccount(
                          email: emailController,
                          firstName: firstNameController,
                          governorate: selectedGovernorate,
                          lastName: lastNameController,
                          password: passwordController,
                          phone: phoneController,
                          role: selectedRole,
                          birthDate: dobController,
                          context: context,
                        );
                      },
                      child: Text("Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 17)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  // Custom Date Picker Widget
  Widget _buildDatePickerField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 17)),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () => _pickBirthdate(context), // Trigger the date picker
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildRadioOption(String role) {
    return Row(
      children: [
        Radio<String>(
          value: role,
          groupValue: selectedRole, // Use selectedRole directly
          onChanged: (String? value) {
            setState(() {
              selectedRole =
                  value!; // Update selectedRole when a radio option is selected
            });
          },
        ),
        Text(role, style: TextStyle(fontSize: 17)),
      ],
    );
  }
}
