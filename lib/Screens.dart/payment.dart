import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping/Screens.dart/notification.dart';
// import 'package:shopping/Models.dart/fruitsModel.dart';
import 'package:shopping/Screens.dart/shoppingCart.dart';

import 'model.dart';

class Payment extends StatefulWidget {
   Payment({super.key, this.amount});
  String? amount;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<Map> uploadOrder = [];
  bool loading = false;

  // object(){
  //   for(int i = 0; i< ShoppingCartItems.length; i++){
  //      fruitItems = ShoppingCartItems[i];

  //       uploadOrder.add({ 
  //          'title' : fruitItems.title, 'imgURL': fruitItems.imgURL, 'price': fruitItems.price, 'count': fruitItems.count

  //         });
  //   }
    
  // }
  @override
  void initState() {
    // object();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
   TextEditingController name = TextEditingController();
   TextEditingController address = TextEditingController();
   TextEditingController phoneNo = TextEditingController();
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
 final formkey = GlobalKey<FormState>();

    final databaseRef = FirebaseDatabase.instance.ref('Orders');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Contact Details')),
        body:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 40,top: 20),
                  child: Text('Fill The Details', style: TextStyle(fontSize: 25,color: Colors.green),)),
                 TextFormField(
                  controller: name,
                  cursorColor:Colors.green ,
                        validator: (value) {
                                // RegExp regExp = RegExp(pattern);
                                if (value!.isEmpty) {
                                  // showError('*Please enter mobile number');
                                  return 'Please enter your name';
                                } 
                                return null;
                              },
                  decoration:  InputDecoration(
                    
                    labelText: 'Name',
                      labelStyle: const TextStyle(color: Colors.green),
                    // hintText: 'Name',
                    // border: ,
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                       focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green))
                  ),
                 
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                     inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                    controller: phoneNo,
                    cursorColor:Colors.green,
                    decoration:  InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: const TextStyle(color: Colors.green),
                      // hintText: 'Phone Number',
                           border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                      // border: InputBorder(borderSide: BorderSide())
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green))
                      // InputBorder(borderSide: BorderSide(color: Colors.green))
                    ),
                     validator: (value) {
                                RegExp regExp = RegExp(pattern);
                                if (value!.isEmpty) {
                                
                                  return 'Please enter mobile number';
                                } else if (!regExp.hasMatch(value)) {
                                
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                  ),
                ),
                 TextFormField(
                  controller: address,
                  cursorColor:Colors.green,
                      validator: (value) {
                               
                                if (value!.isEmpty) {
                                  
                                  return 'Please enter your address';
                                } 
                                return null;
                              },
                  decoration:  InputDecoration(
                    labelText: 'Delivered Address',
                      labelStyle: const TextStyle(color: Colors.green),
                  
                         border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green))
                  ),
                     
                ),
          
                Padding(
                  padding: const EdgeInsets.only(top:25.0),
                  child: Center(
                    child: ElevatedButton(onPressed: (){
                          if (formkey.currentState!.validate()) {

                                databaseRef.child('user1').set({'items':ShoppingCartItems,
                                'Name':name.text,
                                'PhoneNumber': phoneNo.text,
                                'Address': address.text,
                                'Amount': widget.amount,
                                'Status':'Pending'
                                })
                                                            .then((value) {
                                                              print('upload');
                                                              setState(() {
                                                                loading = false;
                                                              });
                                                            } )
                                                            .onError((error, stackTrace) {
                                                              print('error');
                                                            });
                            // print(phoneNo.text);
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return  const MyOrderPage();
                              }));
                            // formkey.currentState!.save();
                                // setState(() {
                                //   isValid = !isValid;
                                // });
                              }

                    }, 
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 50),
                      backgroundColor: Colors.green
                    ),
                    child: const Text('Placed Order', style: TextStyle(fontSize: 18),)),
                  ),
                )
              
              
                  
                // Center(child: loading? CircularProgressIndicator():null,),
                // ElevatedButton(onPressed: (){
                //   setState(() {
                //     loading = true;
                //   });
                //   // print(uploadOrder); 
                //   databaseRef.child('user1').set(ShoppingCartItems)
                //                                             .then((value) {
                //                                               print('upload');
                //                                               setState(() {
                //                                                 loading = false;
                //                                               });
                //                                             } )
                //                                             .onError((error, stackTrace) {
                //                                               print('error');
                //                                             });
                //   // print(send);                            .
                // },
                // style: ElevatedButton.styleFrom( 
                //   backgroundColor: Colors.green
                // ),
                //  child: Text('Payment')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}