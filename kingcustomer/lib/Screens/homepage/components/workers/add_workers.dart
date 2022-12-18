// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:kingcustomer/providers/worker_provider.dart';
import 'package:kingcustomer/widgets/mycontainer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../providers/current_user_provider.dart';
import '../../../../providers/customer_provider.dart';
import '../../../../widgets/bottom_modal_sheet.dart';

class AddWorker extends StatefulWidget {
  const AddWorker({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  State<AddWorker> createState() => _AddWorkerState();
}

class _AddWorkerState extends State<AddWorker> {
  String _imagePath = "";
  File? _selectedImageFile;

  TextEditingController nameController = TextEditingController();
  String genderText = "";
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController cnicController = TextEditingController();

  uploadWokerData() async {
    final userProvider = Provider.of<CustomerProvider>(context, listen: false);
    final loggedInUser =
        userProvider.getUserByID(FirebaseAuth.instance.currentUser!.uid.trim());
    final workerProvider = Provider.of<WorkerProvider>(context, listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) => const Center(child: CircularProgressIndicator())),
    );
    try {
      String imageURL = await workerProvider.uploadWorkerImageToStorage(
        imagePath: _imagePath,
        userID: loggedInUser.userID,
      );
      await workerProvider.uploadWorkerDataToFireStore(
        cnic: cnicController.text,
        email: emailController.text,
        experience: experienceController.text,
        gender: genderText == "male" ? true : false,
        name: nameController.text,
        profileImg: imageURL,
        userID: loggedInUser.userID,
        status: true,
        number: contactController.text,
        service: widget.title,
      );
      await workerProvider.fetch();
      Navigator.pop(context);
      Navigator.pop(context);

      // Future.delayed(const Duration(milliseconds: 0)).then((value) async {
      //   await postProvider.fetch();
      // });
    } on FirebaseException catch (e) {
      print(e.message);
      print(e.code);
    } catch (e) {
      print(e.toString());
    }
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image?.path != null) {
      setState(() {
        _selectedImageFile = File(_image!.path);
        _imagePath = _image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.yellow,
          centerTitle: true,
          title: Text(
            "Add " + widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: (kToolbarHeight / 100) * 40,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _selectedImageFile != null
                ? Stack(
                    children: [
                      MyContainer(
                        width: setWidth(90),
                        height: setHeight(30),
                        child: Image.file(_selectedImageFile!),
                      ),
                      FloatingActionButton(
                          onPressed: () {
                            _selectedImageFile = null;
                            setState(() {});
                          },
                          child: const Icon(Icons.cancel),
                          mini: true),
                    ],
                  )
                : MyContainer(
                    height: setHeight(30),
                    child: InkWell(
                        child: const Icon(Icons.add_a_photo),
                        onTap: () {
                          pickImage();
                        }),
                    width: setWidth(90),
                  ),
            ListTile(
                leading: Text(
                  "Name:     ",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      fontWeight: FontWeight.bold),
                ),
                title: Text(
                  nameController.text,
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                  ),
                ),
                trailing: Icon(
                  Icons.edit,
                  size: getProportionateScreenHeight(20),
                ),
                onTap: () {
                  customBottomModalSheet(
                    button: IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                    context: context,
                    hight: getProportionateScreenHeight(400),
                    controller: nameController,
                    title: "Change Name",
                    hintText: "Name",
                  );
                }),
            Divider(
              thickness: getProportionateScreenHeight(0.2),
              color: Colors.black,
            ),
            ListTile(
              leading: Text(
                "Experience:",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                    fontWeight: FontWeight.bold),
              ),
              title: Text(
                experienceController.text,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),
              trailing: Icon(
                Icons.edit,
                size: getProportionateScreenHeight(20),
              ),
              onTap: () => customBottomModalSheet(
                button: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: () {
                    setState(() {
                      nameController.text;
                    });
                    Navigator.pop(context);
                  },
                ),
                context: context,
                hight: getProportionateScreenHeight(356),
                controller: experienceController,
                title: "Enter Experience ",
                hintText: "Enter Experience ",
              ),
            ),
            Divider(
              thickness: getProportionateScreenHeight(0.2),
              color: Colors.black,
            ),
            ListTile(
              leading: Text(
                "Gender:  ",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                    fontWeight: FontWeight.bold),
              ),
              title: Text(
                genderText,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),
              trailing: Icon(
                Icons.edit,
                size: getProportionateScreenHeight(20),
              ),
              onTap: () => showCupertinoModalPopup(
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: MyContainer(
                    color: Colors.yellow,
                    height: setHeight(10),
                    width: setWidth(90),
                    child: Column(
                      children: [
                        SizedBox(height: setHeight(1)),
                        InkWell(
                          onTap: () {
                            genderText = "Male";
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Male",
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(20),
                            ),
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            genderText = "Famale";
                            setState(() {});

                            Navigator.pop(context);
                          },
                          child: Text(
                            "Female",
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: getProportionateScreenHeight(0.2),
              color: Colors.black,
            ),
            ListTile(
              leading: Text(
                "Contact:",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                    fontWeight: FontWeight.bold),
              ),
              title: Text(
                contactController.text,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),
              trailing: Icon(
                Icons.edit,
                size: getProportionateScreenHeight(20),
              ),
              onTap: () => customBottomModalSheet(
                button: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: () {
                    setState(() {
                      nameController.text;
                    });
                    Navigator.pop(context);
                  },
                ),
                context: context,
                hight: getProportionateScreenHeight(356),
                controller: contactController,
                title: "Change Contact",
                hintText: "Contact ",
              ),
            ),
            Divider(
              thickness: getProportionateScreenHeight(0.2),
              color: Colors.black,
            ),
            ListTile(
              leading: Text(
                "Email:   ",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                    fontWeight: FontWeight.bold),
              ),
              title: Text(
                emailController.text,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),
              trailing: Icon(
                Icons.edit,
                size: getProportionateScreenHeight(20),
              ),
              onTap: () => customBottomModalSheet(
                button: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: () {
                    setState(() {
                      nameController.text;
                    });
                    Navigator.pop(context);
                  },
                ),
                context: context,
                hight: 356,
                controller: emailController,
                title: "Change Email",
                hintText: "example@gmail.com",
              ),
            ),
            Divider(
              thickness: getProportionateScreenHeight(0.2),
              color: Colors.black,
            ),
            ListTile(
              leading: Text(
                "CNIC:   ",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                    fontWeight: FontWeight.bold),
              ),
              title: Text(
                cnicController.text,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),
              trailing: Icon(
                Icons.edit,
                size: getProportionateScreenHeight(20),
              ),
              onTap: () => customBottomModalSheet(
                button: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
                context: context,
                hight: 356,
                controller: cnicController,
                title: "Change CNIC",
                hintText: "425014865186487",
              ),
            ),
            Divider(
              thickness: getProportionateScreenHeight(0.2),
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 18, 18, 18),
                    ),
                    fixedSize: MaterialStateProperty.all(
                      Size(setWidth(30), setHeight(6)),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Discard",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 255, 210, 32),
                      )),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 255, 210, 32),
                    ),
                    fixedSize: MaterialStateProperty.all(
                      Size(setWidth(30), setHeight(6)),
                    ),
                  ),
                  onPressed: () {
                    // var imageURL = workerProvider.uploadWorkerImageToStorage(
                    //     imagePath: _imagePath, userID: loggedInUser.userID);
                    // print(imageURL);

                    // workerProvider.uploadWorkerImageToStorage(
                    //     userID: loggedInUser.userID,
                    //     imagePath: imageURL.toString());
                    // Navigator.pop(context);
                    // Future.delayed(const Duration(milliseconds: 0))
                    //     .then((value) async {
                    //   await workerProvider.fetch();

                    // }
                    //   );
                    uploadWokerData();
                  },
                  child: const Text("Save",
                      style: TextStyle(fontSize: 18, color: Colors.black87)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
class AddWorker extends StatelessWidget {
  const AddWorker({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Add worker",
            style: TextStyle(
              color: Colors.black,
              fontSize: (kToolbarHeight / 100) * 40,
            ),
          ),
        ),


        // body: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: ListView.builder(
        //     itemCount: 4,
        //     itemExtent: 60,
        //     itemBuilder: (context, index) => Row(
        //       children: [
        //         Text("Name: "),
        //         MyTextField(
        //           width: setWidth(50),
        //           radius: 20,
        //           height: setHeight(5),
        //         ),
                
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
*/