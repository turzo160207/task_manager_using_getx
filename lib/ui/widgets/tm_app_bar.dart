import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_ostad/ui/controllers/auth_controller.dart';
import 'package:task_manager_ostad/ui/screens/profile_screen.dart';
import 'package:task_manager_ostad/ui/screens/sign_in_screen.dart';
import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return GestureDetector(
      onTap: () {
        if (!isProfileScreenOpen) {
          Get.to(() => ProfileScreen());  // Corrected navigation
        }
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Obx(() {
          return Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                backgroundImage: authController.profileImage.value != null
                    ? FileImage(File(authController.profileImage.value!.path))
                    : null,
                child: authController.profileImage.value == null
                    ? Icon(Icons.person, color: Colors.grey)
                    : null,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AuthController.userData?.fullName ?? '',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      AuthController.userData?.email ?? '',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  await AuthController.clearUserData();
                  Get.offAll(() => const SignInScreen());
                },
                icon: Icon(Icons.logout),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
