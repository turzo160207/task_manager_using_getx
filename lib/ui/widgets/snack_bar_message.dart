
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, [bool isError = true]) {
  Get.snackbar(
    '',
    message,
    backgroundColor: isError ? Colors.red : Colors.green,
    snackPosition: SnackPosition.BOTTOM,
  );
}
