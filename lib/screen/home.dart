import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone_flutter/screen/messeger_screen.dart';
import 'package:instagram_clone_flutter/screen/notification_screen.dart';
import 'package:instagram_clone_flutter/widget/post_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: SizedBox(
          width: 125.w,
          height: 48.h,
          child: Image.asset('images/instagram.jpg'),
        ),
        leading: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('WARNING', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), //poner en negritas
                  content: const Text('This functionality is not available by android emulation method'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra la ventana
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
          child: Image.asset(
            'images/camera02.png'),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()), // Cambia a tu pantalla de favoritos
              );
            },
            child: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessengerScreen()), // Cambia a la pantalla de Messenger
                );
              },
              child: Image.asset('images/messages.png', width: 22, height: 22),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder(
            stream: _firebaseFirestore
                .collection('posts')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return PostWidget(snapshot.data!.docs[index].data());
                  },
                  childCount:
                      snapshot.data == null ? 0 : snapshot.data!.docs.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}