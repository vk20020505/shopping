import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shopping/Screens.dart/categories.dart';
import 'package:shopping/Screens.dart/fruits.dart';
import 'package:shopping/Screens.dart/model.dart';
import 'package:shopping/Screens.dart/otp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final category = FirebaseDatabase.instance.ref('Category');
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
   
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 1,
          title: const Text('Ecommerce App'),
        
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 25),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Categories();
                        }));
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green.shade300,
                        ),
                      ))
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                height: 130,
                width: double.maxFinite,
                // color: Colors.amber,
                child: StreamBuilder(
                    stream: category.onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        Map<dynamic, dynamic> map =
                            snapshot.data?.snapshot.value as dynamic;
                        // print(map);
                        List<dynamic> list = [];
                        list.clear();
                        list = map.values.toList();
                        // print(list);
                        return ListView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: list.length,
                            itemBuilder: (context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Fruits(
                                      category: list[index]['Name'],
                                    );
                                  }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            // color: Colors.amber,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  list[index]['productUrl']),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        list[index]['Name'] as String,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
              const Text(
                'Products',
                style: TextStyle(fontSize: 25),
              ),

              //
              StreamBuilder(
                  stream: databaseRef.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      Map<dynamic, dynamic> map2 =
                          snapshot.data?.snapshot.value as dynamic;
                      // print(map2);
                      List<dynamic> list2 = [];
                      list2.clear();
                      list2 = map2.values.toList();
                      // print(list2);
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .75,
                          // crossAxisSpacing: 50,
                          crossAxisCount: 2,
                        ),
                        itemCount: list2.length,
                        // itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 110,
                                      width: 130,
                                      margin: const EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              list2[index]['productUrl']),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    Text(
                                      list2[index]['Name'] as String,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () {
                                    if (ShoppingCartItems.isEmpty) {
                                      ShoppingCartItems.add(list2[index]);

                                      setState(() {});
                                    } else {
                                      if (checkItemAvailability(
                                          list2[index]['id'])) {
                                        setState(() {});
                                      } else {
                                        print("object false");
                                        ShoppingCartItems.add(list2[index]);
                                        setState(() {});
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Add to cart',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  )),
                            ],
                          );
                        },
                      );
                    }
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
