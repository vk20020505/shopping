import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopping/Screens.dart/home.dart';
import 'package:shopping/Screens.dart/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
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
          child: const Center(
            child: Image(
              height: 300,
              width: 300,
              image: AssetImage('assets/images/logo.png')),
          ),
        ),
        
      ),
    );
  }
}