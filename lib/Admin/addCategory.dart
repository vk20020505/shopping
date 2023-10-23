import 'dart:developer';

import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/Admin/viewCategory.dart';
// import 'package:shopping/screens/viewCategory.dart';

class Add_Category extends StatefulWidget {
  const Add_Category({super.key});

  @override
  State<Add_Category> createState() => _Add_CategoryState();
}

class _Add_CategoryState extends State<Add_Category> {
  File? categoryImage;
  _selectedFront(bool imageForm) async {
    // var cameraPermission = await Permissions.Camera;
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      File convertedFile = File(selectedImage.path);
      setState(() {
        categoryImage = convertedFile;
      });
      log("Icon selected");
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
                  "Icon  selected Successfully",
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
      log("Icon not selected!!");
    }
  }

  bool loading = false;
  String categoryUrl = "";

  Future<void> upload() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('category')
        .child('images')
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(categoryImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    categoryUrl = await taskSnapshot.ref.getDownloadURL();
    print(categoryUrl);
  }

  final databaseRef = FirebaseDatabase.instance.ref('Category');

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.purple,
        title: const Text("Add Category"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Add Category",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 70, 69, 69),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10),
                       border: Border.all(
                          color:  const Color.fromARGB(255, 119, 119, 119), width: 1),
                      image: DecorationImage(
                        image: NetworkImage('$categoryUrl'),
                        fit: BoxFit.fill,
                      ),

                      color: Colors.white,
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
                                  "Categories",
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
              const Text(
                "Complete the form",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 70, 69, 69),
                ),
              ),
              const SizedBox(
                height: 15,
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
                    hintText: 'close/updater',
                    suffixIcon: Icon(
                      Icons.drive_file_rename_outline,
                      color: Colors.green,
                    )),
              ),

              if (loading) const Center(child: CircularProgressIndicator()),

              //  SizedBox(height: 20);

              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
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
                            "productUrl": categoryUrl.toString(),
                            "Name": nameController.text.toString(),
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
      ),
    );
  }
}