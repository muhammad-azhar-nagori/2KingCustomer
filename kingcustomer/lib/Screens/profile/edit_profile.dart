import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../helper/size_configuration.dart';
import '../../providers/current_user_provider.dart';
import '../../providers/customer_provider.dart';
import 'my_profile_fields.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _imagePath = "";

  File? _selectedImageFile;

  List list = [];

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

  void openCam() async {
    final ImagePicker _picker = ImagePicker();
    final _image = await _picker.pickImage(source: ImageSource.camera);
    if (_image?.path != null) {
      setState(() {
        _selectedImageFile = File(_image!.path);
        _imagePath = _image.path;
      });
    }
  }

  Widget changeProfileImageBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(getProportionateScreenWidth(20)),
          topLeft: Radius.circular(getProportionateScreenWidth(20)),
        ),
      ),
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: getProportionateScreenHeight(20),
        ),
        child: Wrap(
          runSpacing: getProportionateScreenWidth(10),
          children: [
            Text(
              "Choose Profile Photo",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenWidth(30),
              ),
            ),
            Row(
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.camera,
                    color: Colors.black,
                    size: getProportionateScreenHeight(30),
                  ),
                  onPressed: () {
                    //pickImage(imageSource: ImageSource.camera);
                    openCam();
                  },
                  label: Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(25),
                    ),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  icon: Icon(
                    Icons.photo,
                    color: Colors.black,
                    size: getProportionateScreenHeight(30),
                  ),
                  onPressed: () {
                    pickImage();

                    Navigator.pop(context);
                  },
                  label: Text(
                    "Gallery",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(25),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<CustomerProvider>(context);
    final loggedInUser =
        userProvider.getUserByID(FirebaseAuth.instance.currentUser!.uid.trim());
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(20),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Center(
              heightFactor: 1.1,
              child: SizedBox(
                height: getProportionateScreenHeight(200),
                width: getProportionateScreenWidth(200),
                child: _selectedImageFile != null
                    ? CircleAvatar(
                        backgroundColor: Colors.white10,
                        backgroundImage: FileImage(_selectedImageFile!),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 210, 32),
                                  context: context,
                                  builder: (context) =>
                                      changeProfileImageBottomSheet(),
                                );
                              },
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          getProportionateScreenWidth(100),
                                        ),
                                      ),
                                    ),
                                    color:
                                        const Color.fromARGB(255, 255, 210, 32),
                                    child: SizedBox(
                                      height: getProportionateScreenHeight(50),
                                      width: getProportionateScreenWidth(50),
                                      child: Icon(
                                        Icons.edit,
                                        size: getProportionateScreenWidth(40),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.white10,
                        backgroundImage:
                            NetworkImage(loggedInUser.profileImageURL!),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 210, 32),
                                  context: context,
                                  builder: (context) =>
                                      changeProfileImageBottomSheet(),
                                );
                              },
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          getProportionateScreenWidth(100),
                                        ),
                                      ),
                                    ),
                                    color:
                                        const Color.fromARGB(255, 255, 210, 32),
                                    child: SizedBox(
                                      height: getProportionateScreenHeight(50),
                                      width: getProportionateScreenWidth(50),
                                      child: Icon(
                                        Icons.edit,
                                        size: getProportionateScreenWidth(40),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(390),
              width: getProportionateScreenWidth(400),
              child: Card(
                color: const Color.fromARGB(255, 255, 210, 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      getProportionateScreenWidth(20),
                    ),
                  ),
                ),
                child: MyProfileFields(
                  contact: loggedInUser.contactNumber!,
                  email: loggedInUser.email!,
                  gender: loggedInUser.gender.toString(),
                  name: loggedInUser.name!,
                  password: "***********",
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: ((context) =>
                          const Center(child: CircularProgressIndicator())),
                    );
                    final userProvider =
                        Provider.of<CustomerProvider>(context, listen: false);
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc("Y1DImckjzK5z2khAEi7o")
                        .collection("contractors")
                        .doc(FirebaseAuth.instance.currentUser!.uid.trim())
                        .update({"profileImageURL": _imagePath});

                    await userProvider.fetch();
                    Navigator.pop(context);
                    Navigator.pop(context);
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
