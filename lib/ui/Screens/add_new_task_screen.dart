import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/widgets/app_bar.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';

import '../utils/app_colors.dart';
import 'forgot_password_otp_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}
class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

 final TextEditingController _titleController = TextEditingController();
 final TextEditingController _descriptionController = TextEditingController();
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 bool _addNewTaskInProgresss = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: const TMAppbar(),
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 85,),
                  Text('Add New Task', style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500),),
                  const SizedBox(height: 12,),
                  _buildNewTaskForm(),
                  const SizedBox(height: 45,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewTaskForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          TextFormField(
            controller: _titleController,
            validator: (String? value){
              if (value?.isEmpty ?? true){
                return 'Enter Your Task Title';
              } else{
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'Title'
            ),
          ),
          const SizedBox(height: 8,),
          TextFormField(
            controller: _descriptionController,
            validator: (String? value){
              if (value?.isEmpty ?? true){
                return 'Enter Your Task Description';
              } else{
                return null;
              }
            },
            maxLines: 6,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'Description'
            ),
          ),
          const SizedBox(height: 15,),
          Visibility(
            visible: !_addNewTaskInProgresss,
            replacement: const CircularProgressIndicator(),
            child: ElevatedButton(onPressed: _onTapSubmitButton,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),

        ],
      ),
    );
  }

  void _onTapSubmitButton() {
    if(_formKey.currentState!.validate()){
      _addNewTask();
    }
  }

  Future<void> _addNewTask () async{
    _addNewTaskInProgresss = true;
    setState(() {});
    Map<String,dynamic> requestTask = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status":"New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestTask);
    _addNewTaskInProgresss = false;
    setState(() {
    });
    if(response.isSuccess){
     _clearTextFields();
     showSnackBarMessage(context, 'New Task Added');
    }
    else{
     showSnackBarMessage(context, response.errorMessage, true );
    }
  }
  void _clearTextFields () {
    _titleController.clear();
    _descriptionController.clear();
  }
}