import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/core/constants/app_colors.dart';
import 'chat_room_view.dart';  // Assuming ChatRoomView is in this file

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  Future<List<Map<String, dynamic>>> _fetchUserChats() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    // Fetch projects the user is part of
    var projectQuery = await FirebaseFirestore.instance
        .collection('projects')
        .where('teamMembers', arrayContains: user.uid)
        .get();

    var projects = projectQuery.docs.map((doc) => doc.data()).toList();
    var projectIds = projectQuery.docs.map((doc) => doc.id).toList();

    // Fetch group chats related to these projects
    var chatQuery = await FirebaseFirestore.instance
        .collection('GroupChats')
        .where('ProjectID', whereIn: projectIds)
        .get();

    List<Map<String, dynamic>> chats = [];
    for (var chatDoc in chatQuery.docs) {
      var chatData = chatDoc.data();
      var projectSnapshot = await FirebaseFirestore.instance.collection('projects').doc(chatData['ProjectID']).get();
      var projectData = projectSnapshot.data();
      var lastMessageQuery = await chatDoc.reference.collection('Messages').orderBy('SentAt', descending: true).limit(1).get();

      chats.add({
        'chatId': chatDoc.id,
        'projectName': projectData?['name'] ?? 'Unknown Project',
        'projectId': chatData['ProjectID'],
        'lastMessage': lastMessageQuery.docs.isNotEmpty ? lastMessageQuery.docs.first.data() : null,
        'lastMessageTime': lastMessageQuery.docs.isNotEmpty ? lastMessageQuery.docs.first.data()['SentAt'] : null,
      });
    }

    return chats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats', style: TextStyle(fontSize: 24)), // Increased font size for the title
        backgroundColor: AppColors.primary,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchUserChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching chats'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No chats available'));
          }

          var chats = snapshot.data!;
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              var chat = chats[index];
              var lastMessage = chat['lastMessage'];
              var lastMessageTime = chat['lastMessageTime'] != null
                  ? (chat['lastMessageTime'] as Timestamp).toDate()
                  : null;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0), // Reduced spacing between items
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Reduced padding inside ListTile
                  leading: CircleAvatar(
                    radius: 24, // Slightly smaller avatar
                    backgroundColor: AppColors.primary,
                    child: Text(
                      chat['projectName'][0],
                      style: TextStyle(color: Colors.white, fontSize: 16), // Adjusted font size in avatar
                    ),
                  ),
                  title: Text(
                    chat['projectName'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Increased font size for title
                  ),
                  subtitle: Text(
                    lastMessage != null ? lastMessage['MessageText'] : 'No messages yet',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16), // Adjusted font size for subtitle
                  ),
                  trailing: lastMessageTime != null
                      ? Text(
                          "${lastMessageTime.hour}:${lastMessageTime.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(color: Colors.grey, fontSize: 14), // Adjusted font size for timestamp
                        )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatRoomView(projectId: chat['projectId']),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
