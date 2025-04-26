import 'package:covoiturage2/core/utils/string_const.dart';
import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfileImageDialog extends StatefulWidget {
  const ProfileImageDialog({super.key});

  @override
  State<ProfileImageDialog> createState() => _ProfileImageDialogState();
}

class _ProfileImageDialogState extends State<ProfileImageDialog> {
  @override
  void initState() {
    final controller = Get.find<AuthenticationController>();
    controller.setuserImage(controller.currentUser.imageUrl ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      id: ControllerID.UPDATE_USER_IMAGE,
      builder: (controller) {
        return AlertDialog(
          title: const Text("Update Profile Picture"),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: SizedBox(
            height: 150,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await controller.pickImage();
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: _getProfileImage(controller),
                  ),
                ),
                if (controller.currentUser.imageUrl != null &&
                    controller.currentUser.imageUrl!.isNotEmpty)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.setuserImage('');
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                await controller.updateImage(context);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF790303),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  ImageProvider _getProfileImage(AuthenticationController controller) {
    if (controller.f != null) {
      return FileImage(controller.f!);
    } else if (controller.userImage.isNotEmpty) {
      return NetworkImage(controller.userImage);
    }
    return const AssetImage('assets/images/userImage.jpeg');
  }
}
