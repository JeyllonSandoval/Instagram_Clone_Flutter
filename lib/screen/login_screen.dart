import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone_flutter/data/firebase_servise/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  const LoginScreen(this.show, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 96.w, height: 100.h),
            Center(
              child: Image.asset('images/logo.jpg'),
            ),
            SizedBox(height: 120.h),
            Textfield(email, Icons.email, 'Email', email_F),
            SizedBox(height: 15.h),
            Textfield(password, Icons.lock, 'Password', password_F, obscure: true),
            SizedBox(height: 10.h),
            Forgot(),
            SizedBox(height: 10.h),
            login(),
            SizedBox(height: 10.h),
            Have()
          ],
        ),
      )
    );
  }

  Widget Have() {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('dont have an account? ', style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
                GestureDetector(
            onTap: widget.show,
            child: Text(
              "Sign up ",
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

Widget login() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () async {
          // Validación: Verifica si los campos no están vacíos
          if (email.text.isEmpty || password.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter both email and password'), backgroundColor: Colors.redAccent),
            );
            return; // Sale de la función si los campos están vacíos
          }

          // Validación adicional (opcional): Verifica el formato del correo electrónico
          String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
          RegExp regExp = RegExp(emailPattern);
          if (!regExp.hasMatch(email.text)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter a valid email address'), backgroundColor: Colors.redAccent),
            );
            return; // Sale de la función si el correo no tiene el formato adecuado
          }

          // Intentamos realizar el inicio de sesión
          try {
            await Authentication().Login(
              email: email.text, 
              password: password.text,
            );
            
            // Si la autenticación es exitosa
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful'), backgroundColor: Color.fromARGB(255, 0, 109, 56)),
            );
            // Redirigir a otra pantalla, por ejemplo:
            // Navigator.pushReplacementNamed(context, '/home');
          } catch (e) {
            // Si ocurre un error, muestra un mensaje
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email or Password is incorrect'), backgroundColor: Colors.redAccent),
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
            'Login',
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


  Widget Forgot() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text('Forgot Password?', style: TextStyle(fontSize: 13.sp, color: Colors.blue, fontWeight: FontWeight.bold)),
    );
  }

  Widget Textfield(TextEditingController controller, IconData icon, String type, FocusNode focusNode, {bool obscure = false}) {
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
          controller: controller,
          focusNode: focusNode,
          obscureText: obscure,  // Aquí agregamos la propiedad obscureText
          decoration: InputDecoration(
            hintText: type,
            prefixIcon: Icon(icon, color: focusNode.hasFocus ? Colors.black : Colors.grey),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 2.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.black, width: 2.w),
            ),
          ),
        ),
      ),
    );
  }
}