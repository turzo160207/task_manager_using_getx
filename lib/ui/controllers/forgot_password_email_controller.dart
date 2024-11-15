import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';

class ForgotPasswordEmailController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> verifyEmail(String email) async {
    email = email;
    bool isSuccess = false;
    _inProgress = true;
    update();

    String urlWithEmail = '${Urls.verifyEmail}/$email';

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: urlWithEmail,
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
