import 'package:flutter/material.dart';
import 'package:flutter_facebook_fingerprint_github_authencation/login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class FacebookHome extends StatefulWidget {

  final String name;
  final String email;
  const FacebookHome({super.key, required this.name, required this.email});

  @override
  State<FacebookHome> createState() => _FacebookHomeState();
}

class _FacebookHomeState extends State<FacebookHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Welcome ${widget.name}"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              'animations/openBox.json',
              repeat: false,
              
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
            Text(
              'Welcome to Home',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${widget.name}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${widget.email}',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(onPressed: (){Get.to(Login());},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent.shade400,
              ),
             child: Text("Go Back", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
          ],
        ),
      ),
    );
  }
}