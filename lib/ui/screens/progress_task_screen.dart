import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_ostad/ui/controllers/progress_task_list_controller.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getInProgressTaskListInProgress = false;
  final ProgressTaskListController _progressTaskListController = Get.find<ProgressTaskListController>();
  List<TaskModel> _inProgressTaskList = [];

  @override
  void initState() {
    super.initState();
    getProgressTaskScreen();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskListController>(
      builder: (context) {
        return Visibility(
          visible: !_getInProgressTaskListInProgress,
          replacement: const CenteredCircularProgressIndicator(),
          child: RefreshIndicator(
            onRefresh: () async {
              getProgressTaskScreen();
            },
            child: ListView.separated(
              itemCount: _progressTaskListController.taskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: _progressTaskListController.taskList[index],
                  onRefreshList: getProgressTaskScreen,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
        );
      }
    );
  }

  Future<void> getProgressTaskScreen() async {
    final result = await _progressTaskListController.getProgressTaskList();

    if (result == false) {
      showCustomSnackBar(_progressTaskListController.errorMessage!, true);
    }
    else {

    }
  }
}
