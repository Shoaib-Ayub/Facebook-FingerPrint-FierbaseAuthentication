import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_fingerprint_github_authencation/Facebook_home/facebook_home.dart';
import 'package:flutter_facebook_fingerprint_github_authencation/Finger_print-Auth/fingerAuth.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _backgroundColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundColor = ColorTween(
      begin: Colors.purple.shade400,
      end: Colors.blue.shade300,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  singinWithFacebook()async{
    try{
      await FacebookAuth.instance.logOut();
      final  LoginResult result=await FacebookAuth.instance.login(loginBehavior: LoginBehavior.dialogOnly,permissions: ["email", "public_profile"]
      );
      if (result.status==LoginStatus.success){
        final AccessToken? accessToken = result.accessToken;
        if (accessToken!=null){
            final AuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);
          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          User? user = userCredential.user;
          if (user != null) {
            print("User signed in: ${user.displayName}");
             Get.to(FacebookHome(name: user.displayName??"No Name", email: user.email??"No Email"));
          } else {
            print("User sign-in failed");
            Get.snackbar("Error", "User sign-in failed",);
          }
        }
      }
    }catch (e) {
      print("Error during Facebook sign-in: $e");
      Get.snackbar("Error", "Facebook sign-in failed due to techenical reason : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _backgroundColor,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _backgroundColor.value ?? Colors.purple.shade400,
                  Colors.pinkAccent.withOpacity(0.7),
                  Colors.blueAccent.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white .withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                  'Login Page',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: (){Get.to(Fingerauth());},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400, ), 
                  child: Text("Click for fingerprint login",
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)))
                   , SizedBox(height: 10),
                  ElevatedButton(onPressed: (){singinWithFacebook();
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade400, ), 
                  child: Text("Facebook Login",
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)))
                ],)
                ),
              ),
            ),
          );
        
      },
    );
  }
}