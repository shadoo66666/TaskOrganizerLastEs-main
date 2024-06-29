import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/feature/chat/chat_room_view.dart';
import 'package:task_app/feature/project/Firebase/firebase_service.dart';
import 'package:task_app/core/constants/app_colors.dart';


const Color primary = Color(0xff3889C9);
const Color orange = Color(0xffE29C6E);

class ProjectDetailsPage extends StatefulWidget {
  final String projectId;

  const ProjectDetailsPage({Key? key, required this.projectId}) : super(key: key);

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  List<Map<String, dynamic>> tasks = [];
  String projectName = '';
  String projectOwner = '';
  String projectDescription = '';
  List<String> teamMembers = [];
  List<String> teamMemberNames = [];
  List<String> teamMemberImages = [];
  int taskCount = 0;
  int completedTaskCount = 0;

  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchProjectData();
    _fetchTasks();
  }

  Future<void> _loadUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_user!.uid).get();
      setState(() {
        _userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }
Future<void> _fetchProjectData() async {
  try {
    DocumentSnapshot projectSnapshot = await FirebaseService().getProjectById(widget.projectId);
    if (projectSnapshot.exists) {
      setState(() {
        projectName = projectSnapshot['name'];
        projectDescription = projectSnapshot['description'];
      });

      // Log project details
      print('Project Name: $projectName');
      print('Project Description: $projectDescription');

      String adminName = await FirebaseService().getAdminNameById(projectSnapshot['adminId']);
      setState(() {
        projectOwner = adminName;
      });

      // Log project owner details
      print('Project Owner: $projectOwner');

      List<dynamic> memberIds = projectSnapshot['teamMembers'];
      List<String> usernames = [];
      List<String> images = [];

      for (String userId in memberIds) {
        print('Fetching data for userId: $userId'); // Log userId

        Map<String, dynamic>? userData = await FirebaseService().getUserById(userId);
        if (userData != null) {
          String username = userData['username'] ?? 'Unknown';
          String profileImage = userData['profileImage'] ?? 'assets/images/avatar/default.png';

          // Log userData
          print('User Data for $userId: $userData');

          usernames.add(username);
          images.add(profileImage);
        } else {
          // Log if userData is null
          print('No data found for userId: $userId');
        }
      }

      setState(() {
        teamMembers = List<String>.from(memberIds);
        teamMemberNames = usernames;
        teamMemberImages = images;
      });

      // Log final state
      print('Team Members: $teamMembers');
      print('Team Member Names: $teamMemberNames');
      print('Team Member Images: $teamMemberImages');
    }
  } catch (e) {
    print('Error fetching project data: $e');
  }
}


  void _fetchTasks() async {
    try {
      QuerySnapshot taskSnapshot = await FirebaseService().getTasksByProjectId(widget.projectId);
      List<Map<String, dynamic>> loadedTasks = taskSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      setState(() {
        tasks = loadedTasks;
        taskCount = tasks.length;
        completedTaskCount = tasks.where((task) => task['status'] == 'completed').length;
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> _initializeChatAndNavigate() async {
    // Check if a chat exists for the given project
    var chatQuery = await FirebaseFirestore.instance
        .collection('GroupChats')
        .where('ProjectID', isEqualTo: widget.projectId)
        .get();

    DocumentReference chatDocument;

    if (chatQuery.docs.isEmpty) {
      // If no chat exists, create a new one
      chatDocument = FirebaseFirestore.instance.collection('GroupChats').doc();
      await chatDocument.set({
        'ProjectID': widget.projectId,
        'CreatedAt': Timestamp.now(),
      });
    } else {
      // Use the existing chat
      chatDocument = chatQuery.docs.first.reference;
    }

    // Navigate to the chat room
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomView(
          projectId: widget.projectId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          projectName,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularPercentIndicator(
                            radius: 100,
                            lineWidth: 10,
                            percent: taskCount == 0 ? 0 : completedTaskCount / taskCount,
                            center: Text(
                              '${(taskCount == 0 ? 0 : (completedTaskCount / taskCount) * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            progressColor: orange,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Project Progress',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          projectDescription,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: primary,
                  ),
                  title: Text(
                    'Team Members',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: teamMemberNames.asMap().entries.map((entry) {
                    int index = entry.key;
                    String member = entry.value;
                    String imagePath = teamMemberImages[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(imagePath),
                        radius: 20,
                      ),
                      title: Text(
                        member,
                        style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tasks',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primary),
                    ),
                    const SizedBox(height: 8),
                    tasks.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'No tasks available.',
                              style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.5)),
                            ),
                          )
                        : Column(
                            children: tasks.map((task) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task['title'] ?? 'Untitled',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            task['member'] ?? 'Unassigned',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        task['status'] == 'completed' ? Icons.check_circle : Icons.circle,
                                        color: task['status'] == 'completed'
                                            ? Color.fromARGB(255, 80, 83, 80)
                                            : Color.fromARGB(255, 91, 89, 89),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewTaskSheet(userId: widget.projectId),
                            ),
                          ).then((_) {
                            _fetchTasks();
                          });
                        },
                        child: const Text('Add New Task'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: _initializeChatAndNavigate,
                        child: const Text('Open Chat'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class AddNewTaskSheet extends StatefulWidget {
  final String userId;

  const AddNewTaskSheet({Key? key, required this.userId}) : super(key: key);

  @override
  _AddNewTaskSheetState createState() => _AddNewTaskSheetState();
}

class _AddNewTaskSheetState extends State<AddNewTaskSheet> {
  String taskTitle = '';
  TextEditingController assignToController = TextEditingController();

  @override
  void dispose() {
    assignToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        backgroundColor: Color(0xff3889C9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) => taskTitle = value,
              decoration: InputDecoration(
                hintText: 'Enter task title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Assign To',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: assignToController,
              decoration: InputDecoration(
                hintText: 'Enter member name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String selectedMember = assignToController.text.trim();
                if (taskTitle.isNotEmpty && selectedMember.isNotEmpty) {
                  FirebaseService().addTaskToProject(widget.userId, taskTitle, selectedMember);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Task'),
              style: ElevatedButton.styleFrom(
                iconColor: Color(0xff3889C9),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}