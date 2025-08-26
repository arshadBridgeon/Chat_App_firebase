import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; 

    return Scaffold(
      appBar: AppBar(
        title: const Text("M E"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Text(
                user?.email?[0].toUpperCase() ?? "?",
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

         
          Text(
            user?.email ?? "No Email Found",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          
          Text(
            "UID: ${user?.uid ?? "No id"}",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
