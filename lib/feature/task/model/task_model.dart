import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Importing Flutter material package to use widgets

class TaskModel {
  String? docID;
    final String assignTo; // Updated field
  final String userId;
  final String title;
  final String description;
  final String category;
  final String dueDate;
  final String dueTime;
  final bool isDone;
  final String status;
  final String priority;
  final String tag;
  final String? reminderDateTime; // New field for reminder

  TaskModel({
    this.docID,
        required this.assignTo, // assignTo is required

    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.dueDate,
    required this.dueTime,
    required this.isDone,
    required this.status,
    required this.priority,
    required this.tag,
    this.reminderDateTime, // New field for reminder
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      docID: doc.id,
      userId: data['userId'] ?? '',
            assignTo: data['assignTo'] ?? '',

      title: data['titleTask'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      dueDate: data['dueDate'] ?? '',
      dueTime: data['timeTask'] ?? '',
      status: data['status'] ?? '',
      isDone: data['isDone'] ?? false,
      priority: data['priority'] ?? '',
      tag: data['tag'] ?? '',
      reminderDateTime: data['reminderDateTime'], // New field for reminder
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docID': docID,
            'assignTo': assignTo,

      'userId': userId,
      'titleTask': title,
      'description': description,
      'category': category,
      'dueDate': dueDate,
      'timeTask': dueTime,
      'status': status,
      'isDone': isDone,
      'priority': priority,
      'tag': tag,
      'reminderDateTime': reminderDateTime, // New field for reminder
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
            assignTo: map['assignTo'] as String, // Ensure assignTo is correctly assigned

      userId: map['userId'] as String,
      title: map['titleTask'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      dueDate: map['dueDate'] as String,
      dueTime: map['timeTask'] as String,
      isDone: map['isDone'] as bool,
      status: map['status'] as String,
      priority: map['priority'] as String,
      tag: map['tag'] as String,
      reminderDateTime: map['reminderDateTime'] as String?, // New field for reminder
    );
  }

   factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      docID: json['docID'] as String?,
            assignTo: json['assignTo'] ?? '', // Ensure assignTo is correctly assigned
      userId: json['userId'] ?? '',
      title: json['titleTask'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      dueDate: json['dueDate'] ?? '',
      dueTime: json['timeTask'] ?? '',
      isDone: json['isDone'] ?? false,
      status: json['status'] ?? '',
      priority: json['priority'] ?? '',
      tag: json['tag'] ?? '',
      reminderDateTime: json['reminderDateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docID': docID,
      'assignTo': assignTo,
      'userId': userId,
      'titleTask': title,
      'description': description,
      'category': category,
      'dueDate': dueDate,
      'timeTask': dueTime,
      'status': status,
      'isDone': isDone,
      'priority': priority,
      'tag': tag,
      'reminderDateTime': reminderDateTime,
    };
  }
}
