import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping/Screens.dart/login.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>  FirebaseAuth.instance.currentUser == null?
      LoginPage():Home(),));
     });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.green.shade100,
          height: double.infinity,
          width: double.infinity,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 300,
                width: 300,
                image: AssetImage('assets/images/logo.png')),
                Center(child: CircularProgressIndicator(
                  color: Colors.black,
                ))
            ],
          ),
        ),
        
      ),
    );
  }
}