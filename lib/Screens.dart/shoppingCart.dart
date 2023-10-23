import 'package:flutter/material.dart';
// import 'package:shopping/Models.dart/fruitsModel.dart';
import 'package:shopping/Screens.dart/payment.dart';

import 'model.dart';
class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
 int shippingCharge = 50;
   subtotal(){
     num subtotal = 0;
    for(int i =0;i< ShoppingCartItems.length; i++){
       subtotal = subtotal + (ShoppingCartItems[i]['count']  * int.parse(ShoppingCartItems[i]['price']) );
    }
    return subtotal;
   }
  int total(){
    int total = subtotal() + shippingCharge;
    return total;

   }
   @override
  void initState() {
    subtotal();
    total();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      // body: Center(
      // child:  ElevatedButton(child: Text('cart'),
      //   onPressed: () {
      //     print(ShoppingCartItems);
      //   },)
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom:10),
                itemCount: ShoppingCartItems.length,
                itemBuilder: (BuildContext context, int index) {
                    int rate = int.parse(ShoppingCartItems[index]['price']);
                    int num = ShoppingCartItems[index]['count'];

                  return 
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        
                           Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              // borderRadius:BorderRadius.circular(10),
                              color: Colors.amber,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  ShoppingCartItems[index]['productUrl'] as String
                                    // snapshot.child('productUrl').value.toString()
                                    ),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        //  Padding(
                        //   padding: EdgeInsets.only(right: 10),
                        //   child: Image(image: AssetImage(ShoppingCartItems[index]['productUrl'] as String ),
                        //   //  AssetImage('assets/images/apple.png'),
                        //   height: 100,
                        //   width: 100,
                        //   ),
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SizedBox(
                              width: MediaQuery.sizeOf(context).width*.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('₹ ${rate} *${num}' , style: TextStyle(fontSize: 20),),
                                  Text('₹ ${(rate * num)}' , style: TextStyle(fontSize: 20),),
                                ],
                              ),
                            ),
                             Text(ShoppingCartItems[index]['Name'] as String, style: TextStyle(fontSize: 20),),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width*.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 30,
                                    // width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 2)
                                    ),
                                    child:  Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            
                                            setState(() {
                                               ShoppingCartItems[index]['count']++;
                                            });
                                            
                                          },
                                          child: Icon(Icons.add)),
                                        VerticalDivider(thickness: 2,),
                                        Text(ShoppingCartItems[index]['count'].toString(), style: TextStyle(fontSize: 17),),
                                        VerticalDivider(thickness: 2,),
                                        InkWell(
                                          onTap: (){
                                            if( ShoppingCartItems[index]['count']>0){
                                            setState(() {
                                              ShoppingCartItems[index]['count']-- ;
                                              
                                            });
                                            }
                                           
                                          },
                                          child: Icon(Icons.remove))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: ElevatedButton(onPressed: (){
                                      setState(() {
                                        
                                      });
                                      ShoppingCartItems.remove(ShoppingCartItems[index]);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(color: Colors.green.shade300,width: 2),
                                      padding: const EdgeInsets.all(0),
                                      // shape: RoundedRectangleBorder(),
                                      backgroundColor: Colors.green.shade200,
                                      //  fixedSize: Size(40, 20)
                                    ),
                                     child: const Icon(Icons.close, size: 30,)),
                                  )
                                  // IconButton(onPressed:  IconButton(onPressed: (){}, icon: Icon(Icons.close)), icon: Icon(Icons.close))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SubTotal' , style: TextStyle(fontSize: 18),),
                      Text('₹ ${subtotal().toString()}', style: TextStyle(fontSize: 18),),
                    ],
                  ),
                   const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping', style: TextStyle(fontSize: 18),),
                      Text('₹ 50', style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  const Divider(thickness: 2,color: Colors.grey,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: TextStyle(fontSize: 18),),
                      Text('₹ ${total().toString()}', style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Payment();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      
                      fixedSize: const Size(double.maxFinite, 50),
                      backgroundColor: Colors.green, foregroundColor: Colors.white),
                     child: const Text('CHECKOUT', style: TextStyle(fontSize: 18),)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}