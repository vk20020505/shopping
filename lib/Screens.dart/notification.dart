import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  final orders = FirebaseDatabase.instance.ref('Orders');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders'),
      actions: [TextButton(onPressed: (){
         FirebaseAuth.instance.signOut();
      }, child: Text('LogOut'))],),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'My Orders',
                style: TextStyle(fontSize: 25, color: Colors.green),
              ),
            ),
            StreamBuilder(
                stream: orders.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    Map<dynamic, dynamic> map2 =
                        snapshot.data?.snapshot.value as dynamic;
                    print(map2);
                    // List<dynamic> list2 = [];
                    // list2.clear();
                    Map<dynamic, dynamic> Info = map2['user1'];
                    print(Info);
                    List items = Info['items'];
                    print(items);

                    // int price = 0;

                    // for(int i = 0; i<items.length; i++){
                    //   price += items[i]['price']
                    // }
                    // print(Info['items']);
                    // print(list2);
                    return Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 15),
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            items[index]['productUrl'] as String),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        items[index]['Name'] as String,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width * .5,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Price',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              '₹ ${items[index]['price']}',
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width * .5,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Quantity',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              items[index]['count'].toString(),
                                              style: const TextStyle(fontSize: 20),
                                            )
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
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical:12.0),
                             child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               const Text('Status:', style: TextStyle(fontSize: 25, color: Colors.green),),
                                               Text(Info['Status'], style: const TextStyle(fontSize: 20, ))
                                             ],
                                           ),
                           ),
                       Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Amount to pay:', style: TextStyle(fontSize: 23, color: Colors.green),),
                    Text( '₹ ${Info['Amount']}', style: TextStyle(fontSize: 20, ))
                  ],
                )
                      ],
                    );
                  }
                }),
             
                
          ],
        ),
      ),
    );
  }
}
