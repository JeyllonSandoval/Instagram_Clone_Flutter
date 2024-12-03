import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/auth/mainpage.dart';
import 'package:instagram_clone_flutter/widget/post_widget.dart';

class PostScreen extends StatelessWidget {
  final snapshot;
  const PostScreen(this.snapshot, {super.key});

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
          title: const Text("Post"),
        ),
      backgroundColor: Colors.white,
      body: SafeArea(child: PostWidget(snapshot)),
    );
  }
}