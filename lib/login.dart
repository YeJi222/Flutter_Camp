import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  googleCreate() async {
    final document = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if(document.exists == false) { // 처음 등록때만
      FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(<String, dynamic>{
        'email': FirebaseAuth.instance.currentUser!.email,
        'name': FirebaseAuth.instance.currentUser!.displayName,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('img/background.webp'), // 배경 이미지
          ),
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 200,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: SizedBox(
                      width: 300,
                      child: Image.asset(
                        'img/logo.png',
                        fit: BoxFit.fitWidth,
                      )
                  ),
                ),
                const SizedBox(height: 430,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 320,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xfffc99a1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextButton(
                        // onPressed: signInWithGoogle,
                        onPressed: () async {
                          final userCredential = await signInWithGoogle();
                          if(userCredential != null){
                            googleCreate();
                            Navigator.pushNamed(context, '/home');
                          } else{
                            print("Google auth hasn't been enabled for this project.");
                          }

                          // await context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                          // if(FirebaseAuth.instance.currentUser?.uid != null) {
                          //   Navigator.popAndPushNamed(context, '/home');
                          // }
                        },
                        child: const Text(
                          'Google Login',
                          style: TextStyle(
                            color: Color(0xfffc99a1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
}