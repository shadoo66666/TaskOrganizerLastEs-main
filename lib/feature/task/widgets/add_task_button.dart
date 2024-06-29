import 'package:flutter/material.dart';
import 'package:task_app/core/constants/app_colors.dart';
import 'package:task_app/feature/task/widgets/add_new_task.dart';

class AddTaskButton extends StatelessWidget {
    final String userId; // Add userId property

  const AddTaskButton({
    Key? key,
    required this.userId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 227, 169, 130),
      onPressed: () => showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        context: context,
        builder: (context) => AddNewTaskSheet(userId: userId), 
      ),
      shape: const CircleBorder(),
      child: const Text('+ Task', style: TextStyle(color: Colors.black,),
      )
    );
  }
}
