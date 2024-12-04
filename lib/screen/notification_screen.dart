import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/auth/mainpage.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context); // Regresa a la vista anterior si existe
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()), // Redirige al Home
                );
              }
            },
          ),
          title: const Text("Notification"),
        ),
      body: Center(
        child: const Text('Notification Screen. Empty for now.'),
      ),
    );
  }
}

