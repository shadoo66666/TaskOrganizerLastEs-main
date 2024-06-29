import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/core/constants/app_colors.dart';

class ChatRoomView extends StatefulWidget {
  final String projectId;

  ChatRoomView({required this.projectId});

  @override
  _ChatRoomViewState createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  final TextEditingController _controller = TextEditingController();
  DocumentReference? chatDocument;
  String projectName = '';

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    try {
      // Fetch project details to get the project name
      var projectSnapshot = await FirebaseFirestore.instance.collection('projects').doc(widget.projectId).get();
      setState(() {
        projectName = projectSnapshot.data()?['name'] ?? 'Project';
      });

      // Check if a chat exists for the given project
      var chatQuery = await FirebaseFirestore.instance
          .collection('GroupChats')
          .where('ProjectID', isEqualTo: widget.projectId)
          .get();

      if (chatQuery.docs.isEmpty) {
        // If no chat exists, create a new one
        chatDocument = FirebaseFirestore.instance.collection('GroupChats').doc();
        await chatDocument!.set({
          'ProjectID': widget.projectId,
          'CreatedAt': Timestamp.now(),
        });
      } else {
        // Use the existing chat
        chatDocument = chatQuery.docs.first.reference;
      }
      setState(() {});
    } catch (error) {
      print('Error initializing chat: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$projectName Project Chat',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: chatDocument == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: chatDocument!.collection('Messages').orderBy('SentAt').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      var messages = snapshot.data!.docs;
                      List<Widget> messageWidgets = messages.map((message) {
                        var data = message.data() as Map<String, dynamic>;
                        return _buildMessage(
                          isMe: data['UserID'] == FirebaseAuth.instance.currentUser!.uid,
                          username: data['Username'],
                          color: Color(data['Color']),
                          imageUrl: data['ImageUrl'], // Use imageUrl from message data
                          message: data['MessageText'],
                        );
                      }).toList();

                      return ListView(
                        padding: EdgeInsets.all(16.0),
                        children: messageWidgets,
                      );
                    },
                  ),
                ),
                _buildInputField(),
              ],
            ),
    );
  }

  Future<String> _getUserImageUrl(String userId) async {
    try {
      var userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      var userData = userSnapshot.data();
      return userData?['profileImage'] ?? 'assets/images/avatar/avatar-1.png'; // Default image if none is found
    } catch (e) {
      print('Error fetching user image URL: $e');
      return 'assets/images/avatar/avatar-1.png'; // Default image in case of error
    }
  }

  Widget _buildMessage({
    required bool isMe,
    required String username,
    required Color color,
    required String imageUrl,
    required String message,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            FutureBuilder<String>(
              future: _getUserImageUrl(FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200], // Default background color
                  );
                } else if (snapshot.hasData) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(snapshot.data!),
                    backgroundColor: Colors.grey[200], // Default background color
                  );
                } else {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/avatar/avatar-1.png'), // Default image
                    backgroundColor: Colors.grey[200], // Default background color
                  );
                }
              },
            ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isMe ? const Color.fromARGB(255, 130, 231, 93) : const Color.fromARGB(255, 158, 158, 158).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isMe)
            FutureBuilder<String>(
              future: _getUserImageUrl(FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200], // Default background color
                  );
                } else if (snapshot.hasData) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(snapshot.data!),
                    backgroundColor: Colors.grey[200], // Default background color
                  );
                } else {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage:AssetImage(snapshot.data!), // Default image
                    backgroundColor: Colors.grey[200], // Default background color
                  );
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Send Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.primary),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var imageUrl = await _getUserImageUrl(user.uid);

      var messageDoc = chatDocument!.collection('Messages').doc();
      await messageDoc.set({
        'UserID': user.uid,
        'Username': user.displayName ?? 'Anonymous',
        'MessageText': _controller.text,
        'SentAt': Timestamp.now(),
        'Color': Colors.green.value,
        'ImageUrl': imageUrl, // Use imageUrl from the user's document
      });

      _controller.clear();
    }
  }
}
