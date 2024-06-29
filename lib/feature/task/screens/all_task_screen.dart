import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_app/core/constants/app_colors.dart';
import 'package:task_app/feature/task/model/task_model.dart';
import 'package:task_app/feature/task/widgets/card_todo_list_widget.dart';
import 'package:task_app/feature/task/widgets/FilterDialog.dart';
import 'package:task_app/core/provider/service_provider.dart';

class AllTaskScreen extends ConsumerStatefulWidget {
  const AllTaskScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends ConsumerState<AllTaskScreen> {
  Map<String, dynamic> _filters = {};

  @override
  Widget build(BuildContext context) {
    // Fetch tasks for the logged-in user
    AsyncValue<List<TaskModel>> todoData = ref.watch(userTasksProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('All Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 13),
            Container(
              width: double.infinity, // Adjust width as needed
              decoration: BoxDecoration(
                color: AppColors.orange, // Replace with your desired background color
                borderRadius: BorderRadius.circular(8.0), // Optional: adds rounded corners
              ),
              child: ElevatedButton(
                onPressed: () {
                  _showFilterDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding as needed
                  backgroundColor: Colors.transparent, // Make button transparent to see Container's background
                  elevation: 0, // Optional: removes shadow
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(FontAwesomeIcons.filter, color: AppColors.primary),
                    const SizedBox(width: 8), // Added space between icon and text
                    Text(
                      'Filters',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: todoData.when(
                data: (tasks) {
                  // Apply filters to the tasks
                  final filteredTasks = tasks.where((task) {
                    // Check if task matches each filter condition
                    bool matchesStatus = _filters['status'] == null || _filters['status'].contains(task.status);
                    bool matchesCategories =
                        _filters['categories'] == null || _filters['categories'].contains(task.category);
                    bool matchesPriorities =
                        _filters['priorities'] == null || _filters['priorities'].contains(task.priority);
                    bool matchesDueDate = _filters['dueDate'] == null || task.dueDate == _filters['dueDate'];
                    bool matchesTags = _filters['tags'] == null || task.tag.contains(_filters['tags']);

                    // Combine all filter conditions using &&
                    return matchesStatus && matchesCategories && matchesPriorities && matchesDueDate && matchesTags;
                  }).toList();

                  if (filteredTasks.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/onBoarding/1.png',
                            height: 150,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "You don't have any tasks yet!",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) => CardTodoListWidget(task: filteredTasks[index]),
                    );
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterDialog(
          onApplyFilters: (filters) {
            setState(() {
              _filters = filters;
              print(_filters); // Add this line to check if filters are applied correctly
            });
          },
        );
      },
    );
  }
}
