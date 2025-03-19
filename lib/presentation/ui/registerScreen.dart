import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:covoiturage2/presentation/ui/LoginScreen.dart';
import 'package:intl/intl.dart'; // For date formatting

class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController selectedGovernorate = TextEditingController();

  DateTime? _selectedBirthdate;
  final DateFormat format = DateFormat("yyyy-MM-dd");

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

  void _pickBirthdate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthdate ?? DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    final AuthenticationController controller = Get.find();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Attach the form key
            child: GetBuilder<AuthenticationController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text("Create an account",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text.rich(
                      TextSpan(
                        text: "Enter your account details below or ",
                        style: TextStyle(fontSize: 15),
                        children: [
                          TextSpan(
                            text: "log in",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => LoginScreen()),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),

                    // Input Fields with Validation
                    _buildTextField("First name", firstNameController, (value) {
                      if (value == null || value.isEmpty)
                        return "First name is required";
                      return null;
                    }),
                    _buildTextField("Last name", lastNameController, (value) {
                      if (value == null || value.isEmpty)
                        return "Last name is required";
                      return null;
                    }),

                    _buildDatePickerField(
                        context, "Date of Birth", dobController),

                    _buildTextField("Email", emailController, (value) {
                      if (value == null || value.isEmpty)
                        return "Email is required";
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    }, keyboardType: TextInputType.emailAddress),

                    _buildTextField("Phone Number", phoneController, (value) {
                      if (value == null || value.isEmpty)
                        return "Phone number is required";
                      if (!RegExp(r"^[0-9]{8,}$").hasMatch(value)) {
                        return "Enter a valid phone number (min. 8 digits)";
                      }
                      return null;
                    }, keyboardType: TextInputType.phone),

                    // Governorate Dropdown
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
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Governorate is required";
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    // Password Field
                    _buildTextField("Password", passwordController, (value) {
                      if (value == null || value.isEmpty)
                        return "Password is required";
                      if (value.length < 6)
                        return "Password must be at least 6 characters";
                      return null;
                    }, isPassword: true),

                    // Sign Up Button
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
                          if (_formKey.currentState!.validate()) {
                            controller.createAccount(
                              email: emailController,
                              firstName: firstNameController,
                              governorate: selectedGovernorate,
                              lastName: lastNameController,
                              password: passwordController,
                              phone: phoneController,
                              birthDate: dobController,
                              context: context,
                            );
                          }
                        },
                        child: Text("Sign Up",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      String? Function(String?) validator,
      {TextInputType keyboardType = TextInputType.text,
      bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 17)),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword,
          validator: validator,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildDatePickerField(
      BuildContext context, String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 17)),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () => _pickBirthdate(context),
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Birthdate is required";
                return null;
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
