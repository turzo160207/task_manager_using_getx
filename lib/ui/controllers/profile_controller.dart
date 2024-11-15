import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/network_response.dart';
import '../../data/models/user_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import 'auth_controller.dart';

class ProfileController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> updateProfile(String email, String firstName, String lastName, String password, String mobile, XFile? image) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password.isNotEmpty) {
      requestBody['password'] = password;
    }
    if (image != null) {
      File imageFile = File(image.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.updateProfile, body: requestBody);

    if (response.isSuccess){
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthController.saveUserData(userModel);
      showCustomSnackBar('Profile has been updated!');
    } else{
      showCustomSnackBar(response.errorMessage);
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}