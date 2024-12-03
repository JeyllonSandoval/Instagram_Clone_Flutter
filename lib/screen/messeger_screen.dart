import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/auth/mainpage.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({super.key});
  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
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
          title: const Text("Messenger"),
        ),
      body: Center(
        child: const Text('Messenger Screen'),
      ),
    );
  }
}

