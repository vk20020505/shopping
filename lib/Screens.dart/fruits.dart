import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:shopping/Models.dart/fruitsModel.dart';
import 'package:shopping/Screens.dart/shoppingCart.dart';

// import '../Models.dart/categoriesModel.dart';
import 'model.dart';

class Fruits extends StatefulWidget {
  const Fruits({super.key, required this.category});
  final String category;

  @override
  State<Fruits> createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text('Fruits'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20),
              child: Badge(
                // padding: EdgeInsets.only(top: 5),
                textStyle: TextStyle(fontSize: 12),
                // smallSize: 8,
                offset: Offset(1, 0),
                label: Text(ShoppingCartItems.length.toString()),
                // alignment: const AlignmentDirectional(25, -7),
                // alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ShoppingCart();
                      }));
                    },
                    icon: Icon(Icons.shopping_cart)),
              ),
            ),
            // SizedBox(width: 10,)
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: StreamBuilder(
              stream: databaseRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  Map<dynamic, dynamic> map3 =
                      snapshot.data?.snapshot.value as dynamic;
                  // print(map3);
                  List<dynamic> list3 = [];
                  list3.clear();
                  list3 = map3.values.toList();

                  List<dynamic> list4 = [];

                  bool checkCategory(String item) {
                    bool itemfind = false;
                    for (int i = 0; i < list3.length; i++) {
                      if (list3[i]['Category'] == item) {
                       
                        list4.add(list3[i]);
                        // print(list3[i]['price']);
                         itemfind = true;
                        // ShoppingCartItems[i]['count']++;
                      }
                    }
                    return itemfind;
                  }
                  if(checkCategory(widget.category)){

                  
                  return ListView.builder(
                    itemCount: list4.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(list3[index]['productUrl']),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .53,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(list4[index]['Name'],
                                          style: const TextStyle(fontSize: 18)),
                                      Text(
                                        '₹ ${list4[index]['price']}',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              padding: const EdgeInsets.all(5)),
                                          onPressed: () {
                                            if (ShoppingCartItems.isEmpty) {
                                              ShoppingCartItems.add(
                                                  list4[index]);
                                              // productName
                                              //     .add(list3[index]['Name']);
                                              setState(() {});
                                            } else {
                                              // print(list3[index]['Name']);
                                              if (checkItemAvailability(
                                                  list4[index]['id'])) {
                                                setState(() {});
                                              } else {
                                                print("object false");
                                                ShoppingCartItems.add(
                                                    list4[index]);
                                                setState(() {});
                                              }
                                            }
                                          },
                                          child: const Text(
                                            'Add to cart',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0,),
                                        child: const Text('* per Kg',
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  // 
                }else{
                  return Center(child: Text('Currently has no items', style: TextStyle(fontSize: 20, color: Colors.green),));
                }

                  // 
                }
              }),
          // child: FirebaseAnimatedList(
          //     defaultChild: const Center(child: CircularProgressIndicator()),
          //     query: databaseRef,
          //     itemBuilder: (context, snapshot, animation, index) {
          //       return Container(
          //         margin: const EdgeInsets.only(bottom: 10),
          //         padding: const EdgeInsets.all(15),
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.grey, width: 1),
          //           borderRadius: BorderRadius.circular(5),
          //         ),
          //         child: Row(
          //           // mainAxisSize: MainAxisSize.max,
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Container(
          //               height: 100,
          //               width: 100,
          //               decoration: BoxDecoration(
          //                 color: Colors.amber,
          //                 image: DecorationImage(
          //                   fit: BoxFit.cover,
          //                   image: NetworkImage(
          //                       snapshot.child('productUrl').value.toString()),
          //                 ),
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //             ),
          //             Container(
          //               width: MediaQuery.sizeOf(context).width * .45,
          //               child: Column(
          //                 children: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                     children: [
          //                       Text(snapshot.child('Name').value.toString(),
          //                           style: const TextStyle(fontSize: 18)),
          //                       Text(
          //                         '₹${snapshot.child('price').value.toString()}',
          //                         style: const TextStyle(
          //                             fontSize: 20, color: Colors.green),
          //                       ),
          //                     ],
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                     children: [
          //                       ElevatedButton(
          //                           style: ElevatedButton.styleFrom(
          //                               backgroundColor: Colors.green,
          //                               padding: const EdgeInsets.all(5)),
          //                           onPressed: () {
          //                             if(ShoppingCartItems.isEmpty){
          //                                ShoppingCartItems.add(snapshot.value);
          //                             }
          //                             else{
          //                               // ShoppingCartItems.any((element) => element)
          //                             }
          //                             // ShoppingCartItems.any((element) => )
          //                             // ShoppingCartItems.add(snapshot.value);
          //                             setState(() {});
          //                           },
          //                           child: const Text(
          //                             'Add to cart',
          //                             style: TextStyle(
          //                                 fontSize: 15, color: Colors.white),
          //                           )),
          //                       const Text('* per Kg',
          //                           style: TextStyle(fontSize: 12)),
          //                     ],
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     }),
        ),
      ),
    );
  }
}


      // body: GridView.builder(
      //         padding: const EdgeInsets.all(15),
      //         gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
      //           childAspectRatio: .6,
      //           crossAxisCount: 2,
      //           crossAxisSpacing: 10,
      //           mainAxisSpacing: 20
      //         ),
      //         itemCount: fruitList.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           fruit fruits = fruitList[index];
      //           return Card(
      //             margin: const EdgeInsets.only(bottom: 10),
      //             child: Container(
      //               // height: 100,
      //               // width: 90,
      //               padding: const EdgeInsets.only(top:15),
      //               decoration: BoxDecoration(
      //                 border: Border.all(color: Colors.grey,width: 2),
      //                 borderRadius: BorderRadius.circular(5),
      //                 // color: Colors.green.shade100,
      //                 // image: DecorationImage(image: AssetImage(items.imgURL as String)
      //                 ),
      //                 child: Column(
      //                   children: [
      //                     Image(
      //                  height: 120,
      //                       image: AssetImage(fruits.imgURL as String)),
      //                       Text('₹${fruits.price}', style: const TextStyle(fontSize: 20, color: Colors.green),),
      //                       Text(fruits.title as String, style: const TextStyle(fontSize: 22)),
      //                       const Text('* per Kg', style: TextStyle(fontSize: 18)),
      //                       const Divider(thickness: 2,color: Colors.grey,),
      //                       TextButton(onPressed: (){
      //                         ShoppingCartItems.add(fruits);
      //                       },

      //                        child: const Text('Add to cart', style: TextStyle(fontSize: 18, color: Colors.green),))
      //                   ],
      //                 ),
      //               ),

      //           );
      //         },
      //       ),
