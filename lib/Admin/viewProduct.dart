import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:shopping/screens/updateProducts.dart';

class Fruit2 extends StatefulWidget {
  const Fruit2({super.key});

  @override
  State<Fruit2> createState() => _Fruit2State();
}

class _Fruit2State extends State<Fruit2> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: FirebaseAnimatedList(
              defaultChild: Center(child: CircularProgressIndicator()),
              query: databaseRef,
              itemBuilder: (context, snapshot, animation, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
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
                            image: NetworkImage(
                                snapshot.child('productUrl').value.toString()),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * .52,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(snapshot.child('Name').value.toString(),
                                    style: const TextStyle(fontSize: 18)),
                                Text(
                                  '₹${snapshot.child('price').value.toString()}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.green),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        padding: EdgeInsets.all(5)),
                                    onPressed: () {
                                      // ShoppingCartItems.add(snapshot.value);
                                    },
                                    child: InkWell(
                                      onTap: (){
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //     builder: (context) => const Update_Products()));
                                      },
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        padding: EdgeInsets.all(5)),
                                    onPressed: () {

                                      databaseRef.child(snapshot.child('id').value.toString()).remove();
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}