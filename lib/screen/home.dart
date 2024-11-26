import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone_flutter/widget/post_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: SizedBox(
          width: 105.w,
          height: 28.h,
          child: Image.asset('images/instagram.jpg'),
        ),
        leading: Image.asset('images/camera.jpg'),
        actions: [
          const Icon(
            Icons.favorite_border_outlined,
            color: Colors.black,
            size: 25,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w, left: 10.w), // Ajusta el espacio derecho.
            child: Image.asset(
              'images/messages.png',
              width: 20.w,
            ),
          ),
        ],
        backgroundColor: const Color(0xffFAFAFA),
      ),

      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PostWidget();
              },
              childCount: 6,
            ),
          )
        ],
      ),
    );
  }
}