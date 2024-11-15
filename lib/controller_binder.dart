import 'package:get/get.dart';
import 'package:task_manager_ostad/ui/controllers/auth_controller.dart';
import 'package:task_manager_ostad/ui/controllers/cancelled_task_list_controller.dart';
import 'package:task_manager_ostad/ui/controllers/complete_task_list_controller.dart';
import 'package:task_manager_ostad/ui/controllers/delete_task_controller.dart';
import 'package:task_manager_ostad/ui/controllers/forgot_password_email_controller.dart';
import 'package:task_manager_ostad/ui/controllers/forgot_password_otp_controller.dart';
import 'package:task_manager_ostad/ui/controllers/main_bottom_nav_bar_controller.dart';
import 'package:task_manager_ostad/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager_ostad/ui/controllers/profile_controller.dart';
import 'package:task_manager_ostad/ui/controllers/progress_task_list_controller.dart';
import 'package:task_manager_ostad/ui/controllers/reset_password_controller.dart';
import 'package:task_manager_ostad/ui/controllers/sign_in_controller.dart';
import 'package:task_manager_ostad/ui/controllers/sign_up_controller.dart';
import 'package:task_manager_ostad/ui/controllers/task_status_chip_controller.dart';
import 'package:task_manager_ostad/ui/screens/forgot_password_email_screen.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(CompleteTaskListController());
    Get.put(CancelledTaskListController());
    Get.put(ProgressTaskListController());
    Get.put(DeleteTaskController());
    Get.put(TaskStatusChangeController());
    Get.put(SignUpController());
    Get.put(MainBottomNavBarController());
    Get.put(ForgotPasswordEmailController());
    Get.put(ForgotPasswordOtpController());
    Get.put(ResetPasswordController());
    Get.put(ProfileController());
  }

}