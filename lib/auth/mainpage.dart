import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/auth/auth_screen.dart';
import 'package:instagram_clone_flutter/widget/navigation.dart';



class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Navigations_Screen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}