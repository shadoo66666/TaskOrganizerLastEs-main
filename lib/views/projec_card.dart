import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/feature/project/project_model.dart';
import 'package:task_app/feature/project/widgets/project_deteils.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  ProjectCard({required this.project});

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  List<String> memberImages = [];
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchMemberImages();
    _calculateProgress();
  }

  Future<void> _fetchMemberImages() async {
    List<String> images = [];
    for (String memberId in widget.project.teamMembers ?? []) {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('users').doc(memberId).get();
      if (userDoc.exists && userDoc.data() != null) {
        images.add(userDoc.data()!['profileImage'] ?? 'assets/images/avatar/avatar-1.png');
      }
    }
    if (mounted) {
      setState(() {
        memberImages = images;
      });
    }
  }

  Future<void> _calculateProgress() async {
    if (widget.project.projectTasks == null || widget.project.projectTasks!.isEmpty) {
      if (mounted) {
        setState(() {
          progress = 0.0;
        });
      }
      return;
    }

    int completedTasks = 0;
    int totalTasks = widget.project.projectTasks!.length;

    for (String taskId in widget.project.projectTasks!) {
      DocumentSnapshot<Map<String, dynamic>> taskDoc =
          await FirebaseFirestore.instance.collection('tasks').doc(taskId).get();
      if (taskDoc.exists && taskDoc.data() != null && taskDoc.data()!['status'] == 'done') {
        completedTasks++;
      }
    }

    if (mounted) {
      setState(() {
        progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailsPage(projectId: widget.project.projectId!),
          ),
        );
      },
      child: Container(
        width: 260,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.project.name ?? 'Unnamed Project',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: memberImages.map((imageUrl) {
                      return CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage(imageUrl),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
            ),
          ],
        ),
      ),
    );
  }
}
