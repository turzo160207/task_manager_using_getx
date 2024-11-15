import 'package:get/get.dart';

class MainBottomNavBarController extends GetxController {
  RxInt selectedIndex = 0.obs; // RxInt to manage the selected index

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
