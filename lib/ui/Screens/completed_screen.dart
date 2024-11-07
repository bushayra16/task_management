
import 'package:flutter/material.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/model/task_list_model.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';
import '../../data/services/network_caller.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModel> _completedTaskList = [];

  bool _inProgress = false;

  @override
  void initState() {
    _getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTaskList();
        },
        child: Visibility(
          visible: !_inProgress,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
            itemCount: _completedTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                  taskModel: _completedTaskList[index],
                onRefreshList: _getCompletedTaskList,
                  );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    _completedTaskList.clear();
    _inProgress = true;
    setState(() {});
    NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.completedTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.statusData);
      _completedTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _inProgress = false;
    setState(() {});
  }
}
