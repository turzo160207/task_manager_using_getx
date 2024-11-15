import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/complete_task_list_controller.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskListInProgress = false;
  final CompleteTaskListController _completeTaskListController = Get.find<CompleteTaskListController>();

  @override
  void initState() {
    super.initState();
    getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteTaskListController>(
      builder: (context) {
        return Visibility(
          visible: !_getCompletedTaskListInProgress,
          replacement: const CenteredCircularProgressIndicator(),
          child: RefreshIndicator(
            onRefresh: () async {
              getCompletedTaskList();
            },
            child: ListView.separated(
              itemCount: _completeTaskListController.taskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: _completeTaskListController.taskList[index],
                  onRefreshList: getCompletedTaskList,
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

  Future<void> getCompletedTaskList() async {
    final result = await _completeTaskListController.getCompleteTaskList();

    if (result == false) {
      showCustomSnackBar(_completeTaskListController.errorMessage!, true);
    }
    else {

    }
  }

}
