import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_ostad/ui/controllers/cancelled_task_list_controller.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskListInProgress = false;
  final CancelledTaskListController _cancelledTaskListController = Get.find<CancelledTaskListController>();
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelledTaskListController>(
      builder: (context) {
        return Visibility(

          visible: !_getCancelledTaskListInProgress,
          replacement: const CenteredCircularProgressIndicator(),
          child: RefreshIndicator(
            onRefresh: () async {
              getCancelledTaskList();
            },
            child: ListView.separated(
              itemCount: _cancelledTaskListController.taskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: _cancelledTaskListController.taskList[index],
                  onRefreshList: getCancelledTaskList,
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

  Future<void> getCancelledTaskList() async {
    final result = await _cancelledTaskListController.getCancelledTaskList();

    if (result == false) {
      showCustomSnackBar(_cancelledTaskListController.errorMessage!, true);
    }
    else {

    }
  }
}
