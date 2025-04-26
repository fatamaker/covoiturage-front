import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:covoiturage2/presentation/ui/ChangeProfileImageDialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedGovernorate;
  DateTime? _selectedBirthdate;
  final _dateFormat = DateFormat("yyyy-MM-dd");
  String? _birthDate;
  bool _isLoading = false;

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
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    final authController = Get.find<AuthenticationController>();
    final user = authController.currentUser;

    _firstNameController.text = user.firstName ?? '';
    _lastNameController.text = user.lastName ?? '';
    _phoneController.text = user.phone ?? '';
    _selectedGovernorate = user.governorate;

    if (user.birthDate != null) {
      _selectedBirthdate = user.birthDate;
      _birthDate = _dateFormat.format(user.birthDate!);
    }
  }

  Future<void> _pickBirthdate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthdate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthdate = pickedDate;
        _birthDate = _dateFormat.format(pickedDate);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;

    if (_selectedGovernorate == null) {
      Get.snackbar('Error', 'Please select your governorate');
      return;
    }

    setState(() => _isLoading = true);
    final authController = Get.find<AuthenticationController>();

    try {
      await authController.updateProfile(
        firstName: _firstNameController,
        lastName: _lastNameController,
        phone: _phoneController,
        id: authController.currentUser.id!,
        governorate: _selectedGovernorate!,
        birthDate: _selectedBirthdate!.toUtc().toIso8601String(),
      );

      await authController.getCurrentUser(authController.currentUser.id!);

      if (authController.currentUser.governorate != _selectedGovernorate) {
        throw Exception('Governorate update not reflected');
      }

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      Future.delayed(const Duration(seconds: 2), Get.back);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _isLoading ? null : Get.back,
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildProfileHeader(size),
                const SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFormFields(),
                        const SizedBox(height: 25),
                        _buildSaveButton(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const ModalBarrier(
              dismissible: false,
              color: Colors.black54,
            ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Size size) {
    final authController = Get.find<AuthenticationController>();
    return Container(
      height: size.height * 0.2,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white, // Changed to white to match the image
        // borderRadius: BorderRadius.vertical(
        //   bottom: Radius.circular(30.0),
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 55,
                backgroundImage: authController.currentUser.imageUrl == null ||
                        authController.currentUser.imageUrl!.isEmpty
                    ? const AssetImage('assets/images/person.png')
                        as ImageProvider
                    : NetworkImage(authController.currentUser.imageUrl!)
                        as ImageProvider,
              ),
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.edit, size: 16),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          await showDialog(
                            context: context,
                            builder: (_) => const ProfileImageDialog(),
                          );
                        },
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Changed to black to match the image
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name *',
            border: UnderlineInputBorder(),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? "Please enter your first name" : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name *',
            border: UnderlineInputBorder(),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? "Please enter your last name" : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number *',
            border: UnderlineInputBorder(),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? "Please enter your phone" : null,
        ),
        const SizedBox(height: 16),
        InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Governorate',
            border: UnderlineInputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGovernorate,
              isExpanded: true,
              hint: const Text("Select Governorate"),
              items: governorates.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: _isLoading
                  ? null
                  : (String? newValue) {
                      setState(() {
                        _selectedGovernorate = newValue;
                      });
                    },
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _isLoading ? null : () => _pickBirthdate(context),
          child: AbsorbPointer(
            child: TextFormField(
              controller: TextEditingController(text: _birthDate),
              decoration: const InputDecoration(
                labelText: "Birthdate",
                border: UnderlineInputBorder(),
              ),
              validator: (value) => _selectedBirthdate == null
                  ? "Please select your birthdate"
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () {
                _saveProfile();
                Navigator.of(context).pop(true);
              },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent, // Also remove the shadow
          elevation: 0, // Ensure no default elevation
          foregroundColor: Colors.white,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFBFD834), Color(0xFF133A1B)],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            constraints: BoxConstraints(minWidth: 88.0, minHeight: 36.0),
            alignment: Alignment.center,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
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
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
