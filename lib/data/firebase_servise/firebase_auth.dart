import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter/util/exeption.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> SignUp({
    required String email,
    required String password,
    required String passwordConfirme,
    required String username,
    required String bio,
    required File profile,
  })async {
    try {
      if(email.isNotEmpty && password.isNotEmpty && passwordConfirme.isNotEmpty && username.isNotEmpty && bio.isNotEmpty){
        if(password == passwordConfirme){
          _auth.createUserWithEmailAndPassword(email: email, password: password);
        } else {
          throw exception('Password and confirm password must be the same');
        }
      } else {
        throw exception('Please fill all the fields');
      }
    } on FirebaseAuthException catch (e) {
      throw exception(e.message.toString());
    } 
  }
}