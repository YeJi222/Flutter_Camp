import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
          backgroundColor: const Color(0xffFFF9F9),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'img/login_image.png',
                      fit: BoxFit.fitWidth,
                    )
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xfffc99a1),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // await context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                        if(FirebaseAuth.instance.currentUser?.uid != null) {
                          Navigator.popAndPushNamed(context, '/home');
                        }
                      },
                      child: const Text(
                        'Google Login',
                        style: TextStyle(
                          color: Color(0xfffc99a1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Color(0xfffc99a1),
                      border: Border.all(
                        color: Color(0xfffc99a1),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // await context.read<FirebaseAuthMethods>().signInAnonymously(context);
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Text(
                        'Anonymous Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}