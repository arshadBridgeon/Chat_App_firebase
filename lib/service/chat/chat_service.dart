import 'package:chat_app_firebase/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SEND MSG

  Future<void> sendMessag(String receiverId, String message) async {
    // send current user info

    final String curretuserId = _firebaseAuth.currentUser!.uid;
    final String currentuserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new mwssage

    Message newMessage = Message(
      senderId: curretuserId,
      senderEmail: currentuserEmail,
      receiverId: receiverId,
      timestamp: timestamp,
      message: message,
    );

    // constract chat room id from current user id and receiver id (alphebetically sort 2 ides)
// 
    List<String> ids = [curretuserId, receiverId];
    ids.sort(); // sort the ids

    String chatRoomId = ids.join('_'); 

    // add new message to database

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // GET MSG

  Stream<QuerySnapshot> getMessages(String userid, String otherUserid) {
    List<String> ids = [userid, otherUserid];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
