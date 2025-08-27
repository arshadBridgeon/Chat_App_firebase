import 'package:chat_app_firebase/combonetes/my_Drawer.dart';
import 'package:chat_app_firebase/view/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'ChatApp',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        
        
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // Build user list (excluding current user)
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(10),
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildListItem(doc))
              .toList(),
        );
      },
    );
  }

  // Build  user card 
  Widget _buildListItem(DocumentSnapshot document) {
  // Make sure document has data
  if (document.data() == null) {
    return Container(); // skip if null
  }

  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

  // Safely access email & uid
  String? email = data['email'];
  String? uid = data['uid'];

  if (email == null || uid == null) {
    return Container(); // skip invalid documents
  }

  if (_auth.currentUser!.email != email) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.green,
          child: Text(
            email.isNotEmpty ? email[0].toUpperCase() : "?",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          email,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: const Text(
          "Tap to chat",
          style: TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.chat_bubble_outline, color: Colors.green),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: email,
                receiverUseId: uid,
              ),
            ),
          );
        },
      ),
    );
  } else {
    return Container();
  }
}

}
