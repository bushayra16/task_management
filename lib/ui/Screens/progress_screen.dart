import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  List<TaskModel> _progressTaskList = [];

  bool _inProgress = false;

  @override
  void initState() {
    _getProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: RefreshIndicator(
        onRefresh: () async {
          _getProgressTaskList();
        },
        child: Visibility(
          visible: !_inProgress,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
            itemCount: _progressTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                  taskModel: _progressTaskList[index],
                  onRefreshList: _getProgressTaskList,

              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    _progressTaskList.clear();
    _inProgress = true;
    setState(() {});
    NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.progressTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.statusData);
      _progressTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _inProgress = false;
    setState(() {});
  }

}
