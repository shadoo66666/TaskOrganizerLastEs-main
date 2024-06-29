import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> doesChatExist(String projectId) async {
    final chatSnapshot = await _db.collection('chats')
        .where('projectId', isEqualTo: projectId)
        .limit(1)
        .get();
    return chatSnapshot.docs.isNotEmpty;
  }
  
  Future<void> createChat(String projectId) async {
    await _db.collection('chats').add({'projectId': projectId, 'createdAt': Timestamp.now()});
  }
}
