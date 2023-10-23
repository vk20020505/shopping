import 'dart:developer';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/Admin/viewProduct.dart';

// import '../Screens.dart/fruits.dart';
// import 'package:shopping/screens/viewProducts.dart';

// import 'add_Category.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const String id = "dashboardScreen";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File? productImage;
  List<dynamic> ll = [];

  _selectedFront(bool imageForm) async {
    // var cameraPermission = await Permissions.Camera;
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      File convertedFile = File(selectedImage.path);
      setState(() {
        productImage = convertedFile;
      });
      log("Image selected");
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: AlertDialog(
                icon: Icon(
                  Icons.done_outline_rounded,
                  size: 40,
                  color: Colors.green,
                ),
                content: Text(
                  "Image  selected Successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          });
    } else {
      log("Image not selected!!");
    }
  }

  bool loading = false;
  String productUrl = "";

  Future<void> upload() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('products')
        .child('images')
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(productImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    productUrl = await taskSnapshot.ref.getDownloadURL();
    print(productUrl);
  }

  final databaseRef = FirebaseDatabase.instance.ref('Post');

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //List<String> items =  async fetchItems();
  String _dropDownValue = '';
  String? selectedValue;

  final fetchData = FirebaseDatabase.instance.ref('Category');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),

              //  width: double.infinity,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => const Add_Category()));
                  //   },
                  //   child: const Text(
                  //     "Add Category",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       decorationThickness: 2,
                  //       decoration: TextDecoration.underline,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w900,
                  //       color: Colors.green,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Add Products",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 70, 69, 69),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                           border: Border.all(color: Color.fromARGB(255, 119, 119, 119), width: 1),
                          image: DecorationImage(
                            image: NetworkImage('$productUrl'),
                            fit: BoxFit.fill,
                          ),

                          color:  Colors.white,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _selectedFront(true);
                            },
                            child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      "products",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loading = false;
                            });
                            upload();
                          },
                          child: const Text("upload")),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
// start streaming builder

                  StreamBuilder(
                      stream: fetchData.onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
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
                          ll.clear();
                          list.forEach((value) {
                            ll.add(value['Name']);
                          });
                          print(ll);
                          return CircleAvatar(
                            radius: 10,
                          );
                        }
                      }),

// Stream builder topic code
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        //  focusColor: Colors.grey,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        hint: _dropDownValue == ''
                            ? const Text("Select category")
                            : Text(
                                _dropDownValue,
                                style: const TextStyle(color: Colors.black),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: const TextStyle(color: Colors.black),
                        items: ll.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValue = val!;
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Eg Potato/Tomato',
                        suffixIcon: Icon(
                          Icons.drive_file_rename_outline,
                          color: Colors.green,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: priceController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                        hintText: 'Eg 100',
                        suffixIcon: Icon(
                          Icons.currency_bitcoin,
                          color: Colors.green,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: descriptionController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                        hintText: 'Eg Description',
                        suffixIcon: Icon(
                          Icons.description,
                          color: Colors.green,
                        )),
                  ),

                  if (loading) const Center(child: CircularProgressIndicator()),
                ],
                //  SizedBox(height: 20);
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         loading = false;
            //       });

            //       Navigator.of(context).push(
            //           MaterialPageRoute(builder: (context) => const Fruit2()));
            //     },
            //     child: const Text("View Products")),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: TextButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        databaseRef.child(id).set({
                          "id": id,
                          "productUrl": productUrl.toString(),
                          "Category": _dropDownValue.toString(),
                          "Name": nameController.text.toString(),
                          "price": priceController.text.toString(),
                          "count": 1,
                          "desc": descriptionController.text.toString()
                        }).then((value) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: AlertDialog(
                                    icon: Icon(
                                      Icons.done_outline_rounded,
                                      size: 40,
                                      color: Colors.green,
                                    ),
                                    content: Text(
                                      " Uploaded Successfully",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              });

                          setState(() {
                            loading = false;
                          });
                        }).onError((error, stackTrace) {
                          log(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });
                      },
                      child: const Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          // fontStyle: FontStyle.italic,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }}