import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/core/constants/app_colors.dart';
import 'package:task_app/feature/task/model/task_model.dart';
import 'package:task_app/feature/task/widgets/card_todo_list_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  Stream<QuerySnapshot>? _tasksStream;
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void _searchTasks(String query) {
    //String currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (query.isNotEmpty) {
      setState(() {
        _tasksStream = FirebaseFirestore.instance
            .collection('tasks')
            //.where('userId', isEqualTo: currentUserUid)
            .where('titleTask', isGreaterThanOrEqualTo: query)
            .where('titleTask', isLessThanOrEqualTo: query + '\uf8ff')
            .snapshots();
      });
    } else {
      setState(() {
        _tasksStream = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search My Workspace',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: AppColors.primary,),
                      onPressed: () {
                        setState(() {
                          _showResults = true;
                        });
                        _searchTasks(_searchController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (!_showResults) // Display image when showResults is false
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/onBoarding/search.png', // Replace with your image path
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
            if (_showResults)
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          _buildFilterChip('Tasks'),
                          const SizedBox(width: 8.0),
                          _buildFilterChip('Projects'),
                          const SizedBox(width: 8.0),
                          _buildFilterChip('People'),
                          const SizedBox(width: 8.0),
                          _buildFilterChip('Teams'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    StreamBuilder<QuerySnapshot>(
                      stream: _tasksStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No results found', style:TextStyle(fontSize: 20),));
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tasks',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var taskData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                                TaskModel task = TaskModel.fromMap(taskData);
                                return CardTodoListWidget(task: task);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
  return FilterChip(
    label: Text(
      label,
      style: TextStyle(color: Colors.black), // Text color
    ),
    backgroundColor: AppColors.orange, // Background color
    selectedColor: AppColors.orange, // Selected background color
    checkmarkColor: AppColors.orange, // Color of the checkmark when selected
    shape: RoundedRectangleBorder(
      side: BorderSide(color:AppColors.orange,), // Border color
      borderRadius: BorderRadius.circular(30), // Adjust border radius as needed
    ),
    onSelected: (selected) {
      // Handle filter selection
    },
  );
}

  }

