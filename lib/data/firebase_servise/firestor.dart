import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter/data/model/usermodel.dart';
import 'package:instagram_clone_flutter/util/exeption.dart';

class Firebase_Firestor {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser({
    required String email,
    required String username,
    required String bio,
    required String profile,
  }) async {
    await _firebaseFirestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set({
      'email': email,
      'username': username,
      'bio': bio,
      'profile': profile,
      'followers': [],
      'following': [],
    });
    return true;
  }

  Future<Usermodel> getUser({String? UID}) async {
    try {
      final user = await _firebaseFirestore
          .collection('users')
          .doc(UID != null ? UID : _auth.currentUser!.uid)
          .get();
      final snapuser = user.data()!;
      return Usermodel(
          snapuser['bio'],
          snapuser['email'],
          snapuser['followers'],
          snapuser['following'],
          snapuser['profile'],
          snapuser['username']);
    } on FirebaseException catch (e) {
      throw exceptions(e.message.toString());
    }
  }

  Future<bool> CreatePost({
    required String postImage,
    required String caption,
    required String location,
  }) async {
    await _firebaseFirestore.collection('posts').add({
      'postImage': postImage,
      'caption': caption,
      'location': location,
      'username': _auth.currentUser!.displayName,
      'profile': _auth.currentUser!.photoURL,
      'uid': _auth.currentUser!.uid,
      'likes': [],
      'comments': [],
      'time': DateTime.now(),
    });
    return true;
  }
}
