
import 'package:get/get.dart';
import 'package:task_manager_ostad/data/models/task_model.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';

class ResetPasswordController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> resetPassword(String email, String otp,String password) async{
    email = email;
    otp = otp;
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      'email' : email,
      "OTP": otp,
      'password' : password,
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.resetPassword, body: requestBody);
    _inProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      showCustomSnackBar(response.errorMessage, true);
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}