import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app/core/constants/app_colors.dart';
import 'package:task_app/core/services/local_notification_service.dart';
import 'package:task_app/feature/task/model/task_model.dart';
import 'package:task_app/core/provider/date_time_provider.dart';
import 'package:task_app/core/provider/radio_provider.dart';
import 'package:task_app/core/provider/service_provider.dart';

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton({
    Key? key,
    required this.ref,
    required this.userId,
    required this.assignTo, // Update userId to assignTo

    required this.titleController,
    required this.descriptionController,
    required this.status,
    required this.priority,
    required this.tag,
    required this.reminderDateTime,
  }) : super(key: key);

  final WidgetRef ref;
    final String assignTo; // Update userId to assignTo
  final String userId;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String status;
  final String priority;
  final String tag;
  final DateTime? reminderDateTime;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () async {
          final getRadioValue = ref.read(radioProvider);
          String category = '';

          switch (getRadioValue) {
            case 1:
              category = 'Learning';
              break;
            case 2:
              category = 'Working';
              break;
            case 3:
              category = 'General';
              break;
          }

          TaskModel newTask = TaskModel(
            userId: userId,
            assignTo: assignTo,
            title: titleController.text,
            description: descriptionController.text,
            category: category,
            dueDate: ref.read(dateProvider),
            dueTime: ref.read(timeProvider),
            isDone: false,
            status: status,
            priority: priority,
            tag: tag,
          );

          await ref.read(serviceProvider).addNewTask(newTask);

          if (reminderDateTime != null) {
            await scheduleNotification(newTask, reminderDateTime!);
          }

          titleController.clear();
          descriptionController.clear();
          ref.read(radioProvider.notifier).update((state) => 0);
          Navigator.pop(context);
        },
        child: const Text(
          'Create',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Future<void> scheduleNotification(TaskModel task, DateTime reminderDateTime) async {
    await LocalNotificationService.init();

    TimeOfDay reminderTimeOfDay = TimeOfDay(
      hour: reminderDateTime.hour,
      minute: reminderDateTime.minute,
    );

    await LocalNotificationService.showScheduledNotification(
      currentDate: reminderDateTime,
      scheduledTime: reminderTimeOfDay,
      taskModel: task,
    );
  }
}
