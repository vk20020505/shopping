import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:shopping/Models.dart/categoriesModel.dart';
import 'package:shopping/Screens.dart/fruits.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final category = FirebaseDatabase.instance.ref('Category');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          // centerTitle: true,
          title: const Text('Categories'),
        ),
        body: Column(children: [
          Expanded(
              child: StreamBuilder(
                  stream: category.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      Map<dynamic, dynamic> map =
                          snapshot.data?.snapshot.value as dynamic;
                      print(map);
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();
                      print(list);
                      return GridView.builder(
                        padding: const EdgeInsets.all(15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .75,
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (BuildContext context, int index) {
                          // category items = categoryList[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return const Fruits();
                              }));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 160,
                                  width: 160,
                                     margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                     child:                    Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                 list[index]['productUrl']
                                ),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                                ),
                                Text(list[index]['Name'] as String, style: const TextStyle(fontSize: 20),)
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
                  
                  )
        ]),
   
      ),
    );
  }
}
