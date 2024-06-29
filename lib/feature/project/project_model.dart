import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String? projectId;
  String? adminId;
  String? deadline;
  String? description;
  String? name;
  List<String>? projectTasks;
  List<String>? teamMembers;

  Project({
    this.projectId,
    this.adminId,
    this.deadline,
    this.description,
    this.name,
    this.projectTasks,
    this.teamMembers,
  });

  // Factory method to create a Project from Firestore document
  factory Project.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Project(
      projectId: data['projectId'] as String?,
      adminId: data['adminId'] as String?,
      deadline: data['deadline'] as String?,
      description: data['description'] as String?,
      name: data['name'] as String?,
      projectTasks: List<String>.from(data['projectTasks'] ?? []),
      teamMembers: List<String>.from(data['teamMembers'] ?? []),
    );
  }

  // Method to convert a Project to a map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'projectId': projectId,
      'adminId': adminId,
      'deadline': deadline,
      'description': description,
      'name': name,
      'projectTasks': projectTasks,
      'teamMembers': teamMembers,
    };
  }
}
