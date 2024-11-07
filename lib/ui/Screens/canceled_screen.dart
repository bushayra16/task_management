
import 'package:flutter/material.dart';
import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_msg.dart';
import '../widgets/task_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  List<TaskModel> _canceledTaskList = [];
  bool _inProgress = false;

  @override
  void initState() {
    _getCanceledList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCanceledList();
        },
        child: Visibility(
          visible: !_inProgress,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
            itemCount: _canceledTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                  taskModel: _canceledTaskList[index],
                  onRefreshList: _getCanceledList,
                  );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCanceledList() async {
    _canceledTaskList.clear();
    _inProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.canceledTaskList,
    );
    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.statusData);
      _canceledTaskList = taskListModel.taskList ?? [];
    } else{
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _inProgress = false;
    setState(() {});
  }
}