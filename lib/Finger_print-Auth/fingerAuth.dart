 import 'package:flutter/material.dart';
import 'package:flutter_facebook_fingerprint_github_authencation/Finger_print-Auth/home.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

class Fingerauth extends StatefulWidget {
  const Fingerauth({super.key});

  @override
  State<Fingerauth> createState() => _FingerauthState();
}

class _FingerauthState extends State<Fingerauth> {
  final LocalAuthentication auth=LocalAuthentication();
  checkAuth()async{
    bool isAvailable =await auth.canCheckBiometrics;
    print( isAvailable );
    if (isAvailable){
      bool result=await auth.authenticate(
        localizedReason: "Please scan your finger to access the app",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction: true
        )
      );
      if (result) {
        Get.snackbar(
              'Success', // Title
              'Item added successfully!', // Message
              snackPosition: SnackPosition.TOP, // Position (TOP ya BOTTOM)
              backgroundColor: Colors.green, // Background color
              colorText: Colors.white, // Text color
              duration: const Duration(seconds: 3)
              );
        print("Authentication successful");
        Get.to(const Home());
        // Navigate to the next screen or perform the desired action
      } else {
        print("Authentication failed");
        // Handle authentication failure
      }
    } else {
      print("Biometric authentication is not available on this device");
      // Handle the case where biometric authentication is not available
    }
    {
      
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Column(
        children: [SizedBox(height: 10,),
        Center(
          child: Text("Login",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
          ,),
          )
        ,SizedBox(height: 10,),
        Lottie.asset("animations/befor.json",width: 200,height: 200,fit: BoxFit.fill,repeat: true,reverse: true,animate: true)
        ,SizedBox(height: 30,),
        Center(
          child: Text("Fingerprint Auth",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
          ,),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 28,vertical: 5),
          child: Text("Authenticate using their fingerprint for secure access to the app."
          ,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.grey[600])
          )
          )
        ,SizedBox(height: 10,),
        ElevatedButton(onPressed: (){checkAuth();}, 
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.all(8)
          ),
        child: Text("Authenticate"
          ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white)
          )
          )
          ]
          ,),
    )
        ,);
  }
}