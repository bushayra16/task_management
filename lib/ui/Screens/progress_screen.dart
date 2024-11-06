import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const TaskCard();
        },
        separatorBuilder: (context, builder) {
          return const SizedBox(height: 5);
        });
  }
}
