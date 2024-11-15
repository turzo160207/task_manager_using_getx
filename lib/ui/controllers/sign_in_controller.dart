import 'package:get/get.dart';

import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{
  RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress.value = true;

    Map<String, dynamic> requestBody = {
      'email' : email,
      'password' : password,
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.login, body: requestBody);

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      _errorMessage.value = response.errorMessage ?? 'An error occurred';
    }

    _inProgress.value = false;
    return isSuccess;
  }
}