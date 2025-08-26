import 'package:chat_app_firebase/view/homepage.dart';
import 'package:chat_app_firebase/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Homepage();
        }else{
          return LoginPage();
        }
      },),
    );
  }
}