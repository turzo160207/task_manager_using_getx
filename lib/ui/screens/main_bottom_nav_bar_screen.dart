import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_ostad/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager_ostad/ui/screens/completed_task_screen.dart';
import 'package:task_manager_ostad/ui/screens/new_task_screen.dart';
import 'package:task_manager_ostad/ui/screens/progress_task_screen.dart';

import '../controllers/main_bottom_nav_bar_controller.dart';
import '../widgets/tm_app_bar.dart'; // import your controller

class MainBottomNavBarScreen extends StatelessWidget {
  static const String name = '/home';

  const MainBottomNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainBottomNavBarController navController = Get.find<MainBottomNavBarController>();

    final List<Widget> _screens = const [
      NewTaskScreen(),
      CompletedTaskScreen(),
      CancelledTaskScreen(),
      InProgressTaskScreen(),
    ];

    return Scaffold(
      appBar: TMAppBar(),
      body: Obx(() => _screens[navController.selectedIndex.value]),  // Use Obx to observe changes to selectedIndex
      bottomNavigationBar: Obx(() => NavigationBar(
        selectedIndex: navController.selectedIndex.value, // Bind the selected index to the controller's reactive value
        onDestinationSelected: (int index) {
          navController.changeIndex(index);  // Update the index using the controller
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(icon: Icon(Icons.check_box), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
          NavigationDestination(icon: Icon(Icons.access_time_outlined), label: 'InProgress'),
        ],
      )),
    );
  }
}
