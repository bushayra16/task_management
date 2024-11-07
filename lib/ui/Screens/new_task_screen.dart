import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_management/data/model/count_dart.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/model/task_list_count.dart';
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
  bool _getNewTaskListInProgress = false;
  bool _newTaskCountInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<Count> _newTaskCount = [];


  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTaskSummaryCard(),
          Expanded(child: Visibility(
            visible: !_getNewTaskListInProgress,
            replacement: const CenterCircularIndicator(),
            child: ListView.separated(
              itemCount: _newTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: _newTaskList[index],
                  onRefreshList: _getNewTaskList,

                );
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
    return RefreshIndicator(
      onRefresh: () async{
        _getNewTaskList();
        _getTaskStatusCount();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),

          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getTaskSummaryCardList()
              //   ..._newTaskCount.map((e){
              //   return TaskSummaryCard(title: e.sId ?? '' , count: e.sum ?? 0);
              // })

            ,
          ),
        ),
      ),
    );
  }

  List<TaskSummaryCard> _getTaskSummaryCardList() {
    List<TaskSummaryCard> taskSummaryCardList = [];
    for (Count t in _newTaskCount) {
      taskSummaryCardList.add(TaskSummaryCard(title: t.sId!, count: t.sum ?? 0));
    }

    return taskSummaryCardList;
  }

  void _onTapButton() async {
    final bool? shouldRefresh = await
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
    if(shouldRefresh == true){
      _getNewTaskList();
    }
    }

  Future<void> _getNewTaskList() async{
    _newTaskList.clear();
    _getNewTaskListInProgress = true;
    setState(() {
    });
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getNewTaskList);
    if(response.isSuccess){
      final TaskListModel taskListModel = TaskListModel.fromJson(response.statusData);
      _newTaskList = taskListModel.taskList ?? [];
    }else{
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTaskListInProgress = false;
    setState(() {
    });
  }
  Future<void> _getTaskStatusCount() async{
   _newTaskCount.clear();
   _newTaskCountInProgress = true;
   setState(() {

   });
   final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getTaskCount());
   if(response.isSuccess){
     final TaskListCountModel taskListCountModel = TaskListCountModel.fromJson(response.statusData);
     _newTaskCount = taskListCountModel.countList ?? [];
   } else{
     showSnackBarMessage(context, response.errorMessage, true);
   }
   _newTaskCountInProgress = false;
   setState(() {

   });
  }
}






