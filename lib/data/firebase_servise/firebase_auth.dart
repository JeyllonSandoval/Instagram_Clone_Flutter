import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter/data/firebase_servise/firestor.dart';
import 'package:instagram_clone_flutter/data/firebase_servise/storage.dart';
import 'package:instagram_clone_flutter/util/exeption.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> Login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseException catch (e) {
      throw exceptions(e.message.toString());
    }
  }

  Future<void> Signup({
    required String email,
    required String password,
    required String passwordConfirme,
    required String username,
    required String bio,
    required File profile,
  }) async {
    String URL;
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        if (password == passwordConfirme) {
          // create user with email and password
          try {
            await _auth.createUserWithEmailAndPassword(
              email: email.trim(),
              password: password.trim(),
            );
            print("User created successfully");
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('Password is too weak.');
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
            } else if (e.code == 'invalid-email') {
              print('The email address is badly formatted.');
            } else {
              print('Error undefine: ${e.message}');
            }
          } catch (e) {
            print('Critic error undefine: $e');
          }
          // upload profile image on storage

          if (profile != File('')) {
            URL =
                await StorageMethod().uploadImageToStorage('Profile', profile);
          } else {
            URL = '';
          }

          // get information with firestor

          await Firebase_Firestor().CreateUser(
            email: email,
            username: username,
            bio: bio,
            profile: URL == ''
                ? 'https://firebasestorage.googleapis.com/v0/b/instagramclone-74a5e.firebasestorage.app/o/person.png?alt=media&token=ef8909a8-e0d2-4818-a97b-729ea14d165c'
                : URL,
          );
        } else {
          throw exceptions('password and confirm password should be same');
        }
      } else {
        throw exceptions('enter all the fields');
      }
    } on FirebaseException catch (e) {
      throw exceptions(e.message.toString());
    }
  }
}