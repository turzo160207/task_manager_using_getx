import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_ostad/data/models/task_model.dart';
import 'package:task_manager_ostad/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_ostad/ui/widgets/snack_bar_message.dart';
import '../controllers/delete_task_controller.dart';
import '../controllers/task_status_chip_controller.dart';
import '../utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel, required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _deleteTaskInProgress = false;
  final DeleteTaskController _deleteTaskController = Get.find<DeleteTaskController>();
  final TaskStatusChangeController _taskStatusChangeController = Get.find<TaskStatusChangeController>();
  String _selectedStatus = '';
  bool _changeStatusInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              widget.taskModel.description ?? '',
            ),
            Text(
              'Date: ${widget.taskModel.createdDate ?? ''}',
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                Wrap(
                  children: [
                    Visibility(
                      visible: _changeStatusInProgress == false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTapEditButton,
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    GetBuilder<DeleteTaskController>(
                      builder: (context) {
                        return Visibility(
                          visible: !_deleteTaskInProgress,
                          replacement: CenteredCircularProgressIndicator(),
                          child: IconButton(
                            onPressed: _onTapDeleteButton,
                            icon: Icon(Icons.delete),
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onTapEditButton() {
    Get.dialog(
      AlertDialog(
        title: Text('Edit Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['New', 'Completed', 'Cancelled', 'Progress'].map(
                (e) {
              return ListTile(
                onTap: () {
                  _changeStatus(e);
                  Get.back();
                },
                title: Text(e),
                selected: _selectedStatus == e,
                trailing: _selectedStatus == e ? Icon(Icons.check) : null,
              );
            },
          ).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _onTapDeleteButton() async {
    final bool isSuccess = await _deleteTaskController.deleteTask(
      widget.taskModel.sId!,
      widget.onRefreshList,
    );

    if (!isSuccess) {
      showCustomSnackBar(_deleteTaskController.errorMessage ?? 'Failed to delete task', true);
    }
    else{
      Get.snackbar(
        'Success',
        'Task deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }



  Widget _buildTaskStatusChip() {
    return Chip(
      label: Text(
        widget.taskModel.status!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: BorderSide(
        color: AppColors.themeColor,
      ),
    );
  }
  void _changeStatus(String newStatus) async {
    final bool isSuccess = await _taskStatusChangeController.changeStatus(
      widget.taskModel.sId!,
      newStatus,
      widget.onRefreshList,
    );

    if (!isSuccess) {
      showCustomSnackBar(_taskStatusChangeController.errorMessage ?? 'Failed to change status', true);
    } else {
      showCustomSnackBar('Status updated successfully', false);
    }
  }
}
