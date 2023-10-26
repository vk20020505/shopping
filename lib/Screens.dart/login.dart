import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping/Screens.dart/otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final _formkey = GlobalKey<FormState>();
  bool isValid = false;



  String? phoneNo;

  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

    sendOTP() async {
    String number = '+91$phoneNo';
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OtpPage(
                number: number,
              id: verificationId,
            );
          }));
        },
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          log(error.code.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 30));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.shade100,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:10, vertical: 15),
          child: Column(
            children: [
               const Image(
                  height: 300,
                  width: 300,
                  image: AssetImage('assets/images/logo.png')),
            
                    
                      Form(
                        key: _formkey,
                        child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10)
                      ],
                      autofocus: true,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        RegExp regExp = RegExp(pattern);
                        if (value!.isEmpty) {
                          // showError('*Please enter mobile number');
                          return '*Please enter mobile number';
                        } else if (!regExp.hasMatch(value)) {
                          // showError('*Please enter valid mobile number')
                          return '*Please enter valid mobile number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            isValid = !isValid;
                          });
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          phoneNo = value!;
                        });
                        print(phoneNo);
                      },
                      cursorColor: Colors.black,
                      decoration:  InputDecoration(
                              labelText: 'Phone Number',
                      labelStyle: const TextStyle(color: Colors.green),
                          contentPadding: EdgeInsets.symmetric(horizontal:10),
                          // border: InputBorder.none,
                               border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Colors.green)),
                          focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Colors.green)),
                          hintText: "Enter phone number",
                          hintStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                          )),
                          
                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.only(top:58.0),
                          child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  isValid ? Colors.black : Colors.black26,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              fixedSize: const Size(double.maxFinite, 50),
                              backgroundColor:
                                  isValid ? Colors.green : Colors.grey.shade300),
                          onPressed: isValid?() {
                            _formkey.currentState?.save();
                            sendOTP();
                          }: null,
                          child: const Text(
                            "Proceed",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
            ],
            
          ),
        ),
    
      ),
    );
  }
}