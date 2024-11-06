import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/model/task_list_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/Screens/add_new_task_screen.dart';
import 'package:task_management/ui/widgets/circular_indicator.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';
import 'package:task_management/data/model/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getNewTaskListInProgress = false;
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTaskSummaryCard(),
          Expanded(child: Visibility(
            visible: !getNewTaskListInProgress,
            replacement: const CenterCircularIndicator(),
            child: ListView.separated(
              itemCount: _newTaskList.length,
              itemBuilder: (context, index) {
                return const TaskCard();
              },
              separatorBuilder: (context, builder) {
                return const SizedBox(height: 5,);
              },
            ),
          ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildTaskSummaryCard() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TaskSummaryCard(
              title: 'Canceled',
              count: 19,
            ),
            TaskSummaryCard(
              title: 'Completed',
              count: 19,
            ),
            TaskSummaryCard(
              title: 'Progress',
              count: 19,
            ),
            TaskSummaryCard(
              title: 'New Task',
              count: 19,
            )
          ],
        ),
      ),
    );
  }
  void _onTapButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));}

  Future<void> _getNewTaskList() async{
    _newTaskList.clear();
    getNewTaskListInProgress = true;
    setState(() {
    });
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getNewTaskList);
    if(response.isSuccess){
      final TaskListModel taskListModel = TaskListModel.fromJson(response.statusData);
      _newTaskList = taskListModel.taskList ?? [];
    }else{
      showSnackBarMessage(context, response.errorMessage, true);
    }
    getNewTaskListInProgress = false;
    setState(() {
    });
  }
}






