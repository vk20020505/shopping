import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:shopping/Models.dart/fruitsModel.dart';
import 'package:shopping/Screens.dart/shoppingCart.dart';

import 'model.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

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

    final databaseRef = FirebaseDatabase.instance.ref('Post2');
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: loading? CircularProgressIndicator():null,),
            ElevatedButton(onPressed: (){
              setState(() {
                loading = true;
              });
              // print(uploadOrder); 
              databaseRef.child('user1').set(ShoppingCartItems)
                                                        .then((value) {
                                                          print('upload');
                                                          setState(() {
                                                            loading = false;
                                                          });
                                                        } )
                                                        .onError((error, stackTrace) {
                                                          print('error');
                                                        });
              // print(send);                            .
            },
            style: ElevatedButton.styleFrom( 
              backgroundColor: Colors.green
            ),
             child: Text('Payment')),
          ],
        ),
      ),
    );
  }
}