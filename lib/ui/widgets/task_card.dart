import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text('Title', style: Theme.of(context).textTheme.titleSmall?.copyWith(),),
            const  Text('Description',),
            const  Text('Date: 12/12/12',),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTaskStatusChip(),
                Wrap(
                  children: [
                    IconButton(onPressed: _onTapEditButton, icon: const Icon(Icons.edit)) ,
                    IconButton(onPressed: _onTapDeleteButton, icon: const Icon(Icons.delete,color: Colors.red,))

                  ],
                )


              ],
            )

          ],
        ),
      ),
    );
  }

  Widget buildTaskStatusChip() {
    return Chip(
                label: const Text('New', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.themeColor)
                ),
              );
  }

  void _onTapEditButton() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Edit Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['New','Completed','Cancelled','Progress'].map((value){
            return ListTile(
              onTap: (){},
              title: Text(value),
            );
          }).toList(),
        ),
        actions: [
          TextButton(onPressed: (){}, child: const Text('Okay')),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Cancel')),

        ],
      );
    });
  }
  void _onTapDeleteButton(){}
  }
