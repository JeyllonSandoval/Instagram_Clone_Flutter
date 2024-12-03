import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone_flutter/data/firebase_servise/firebase_auth.dart';
import 'package:instagram_clone_flutter/util/exeption.dart';
import 'package:instagram_clone_flutter/util/imagepicker.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;
  const SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  final password = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  final passwordConfirme = TextEditingController();
  FocusNode passwordConfirmationFocusNode = FocusNode();
  final username = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  final bio = TextEditingController();
  FocusNode bioFocusNode = FocusNode();
  File? _imageFile;
  
  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmationFocusNode.dispose();
    usernameFocusNode.dispose();
    bioFocusNode.dispose();
    super.dispose();
    email.dispose();
    password.dispose();
    passwordConfirme.dispose();
    username.dispose();
    bio.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(width: 40.w, height: 10.h),
              Center(
                child: Image.asset('images/logo.jpg'),
              ),
              SizedBox(width: 96.w, height: 70.h),
              InkWell(
                onTap: () async {
                  File imagefilee = await ImagePickerr().uploadImage('gallery');
                  setState(() {
                    _imageFile = imagefilee;
                  });
                },
                child: CircleAvatar(
                  radius: 36.r,
                  backgroundColor: Colors.grey,
                  child: _imageFile == null
                      ? CircleAvatar(
                          radius: 34.r,
                          backgroundImage: const AssetImage('images/person.png'),
                          backgroundColor: Colors.grey.shade200,
                        )
                      : CircleAvatar(
                          radius: 34.r,
                          backgroundImage: Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          ).image,
                          backgroundColor: Colors.grey.shade200,
                        ),
                ),
              ),
              SizedBox(height: 40.h),
              textfild(email, emailFocusNode, 'Email', Icons.email),
              SizedBox(height: 15.h),
              textfild(username, usernameFocusNode, 'username', Icons.person),
              SizedBox(height: 15.h),
              textfild(bio, bioFocusNode, 'bio', Icons.abc),
              SizedBox(height: 15.h),
              textfild(password, passwordFocusNode, 'Password', Icons.lock),
              SizedBox(height: 15.h),
              textfild(passwordConfirme, passwordConfirmationFocusNode, 'PasswordConfirme',
                  Icons.lock),
              SizedBox(height: 15.h),
              signup(),
              SizedBox(height: 15.h),
              have()
            ],
          ),
        ),
      ),
    );
  }

  Widget have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don you have account?  ",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Login ",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

Widget signup() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    child: InkWell(
      onTap: () async {
        try {
          //Comprueba si se selecciono una imagen
          if (_imageFile == null) {
            throw exceptions('Please select an image');
          }
          // Llama a la función de signup y pasa la imagen
          await Authentication().Signup(
            email: email.text,
            password: password.text,
            passwordConfirme: passwordConfirme.text,
            username: username.text,
            bio: bio.text,
            profile: _imageFile ?? File(''),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } on exceptions catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 23.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}


  Padding textfild(TextEditingController controll, FocusNode focusNode,
      String typename, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: controll,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: typename,
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus ? Colors.black : Colors.grey[600],
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}