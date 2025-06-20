import 'package:flutter/material.dart';
import 'package:flutter_facebook_fingerprint_github_authencation/login.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            LottieBuilder.asset('animations/new.json',
                width: 300, height: 200, fit: BoxFit.fill, repeat: false,animate: true),
            const SizedBox(height: 30),
            const Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(Login());
              },
              child: const Text('Go to back'),
            ),
          ],
        ),
      ),
    );
  }
}