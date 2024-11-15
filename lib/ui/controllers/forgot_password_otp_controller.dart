import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';

class ForgotPasswordOtpController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> verifyOtp(String email, String otp) async {
    email = email;
    otp = otp;
    bool isSuccess = false;
    _inProgress = true;
    update();

    String urlWithOtp = '${Urls.verifyOTP}/$email/$otp';

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: urlWithOtp,
    );

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
