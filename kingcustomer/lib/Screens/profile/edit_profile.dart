import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kingcustomer/providers/customer_provider.dart';
import 'package:provider/provider.dart';
import '../../helper/size_configuration.dart';
import '../../providers/contractor_provider.dart';
import '../../widgets/bottom_modal_sheet.dart';
import '../../widgets/mycontainer.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _imagePath = "";

  File? _selectedImageFile;

  List list = [];
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController contactController = TextEditingController();

  TextEditingController cnicController = TextEditingController();
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
    Navigator.pop(context);
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

  String genderText = "";
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<CustomerProvider>(context);
    final loggedInUser = userProvider.getCurrentUser();

    // nameController.text = loggedInUser.name!;
    // genderController.text =
    //     loggedInUser.gender.toString() == "true" ? "Male" : "Female";
    // passwordController.text = "********";
    // emailController.text = loggedInUser.cnic!;
    // contactController.text = loggedInUser.contactNumber!;
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
                        backgroundImage: CachedNetworkImageProvider(
                          loggedInUser.profileImageURL!,
                        ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    ListTile(
                      leading: Text(
                        "Name:     ",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        nameController.text.isEmpty
                            ? loggedInUser.name!
                            : nameController.text,
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
                            onPressed: () {
                              setState(() {});
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_forward_rounded)),
                        context: context,
                        hight: getProportionateScreenHeight(400),
                        controller: nameController,
                        title: "Change Name",
                        hintText: "Name",
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
                        genderText.isEmpty
                            ? loggedInUser.gender! == true
                                ? "Male"
                                : "Female"
                            : genderText,
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
                                      fontSize:
                                          getProportionateScreenHeight(20),
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
                                      fontSize:
                                          getProportionateScreenHeight(20),
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
                        contactController.text.isEmpty
                            ? loggedInUser.contactNumber!
                            : contactController.text,
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
                            onPressed: () {
                              setState(() {});
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_forward_rounded)),
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
                        "Cnic:   ",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        cnicController.text.isEmpty
                            ? loggedInUser.cnic!
                            : cnicController.text,
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
                            onPressed: () {
                              setState(() {});
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_forward_rounded)),
                        context: context,
                        hight: 356,
                        controller: cnicController,
                        title: "Change Cnic",
                        hintText: "XXXXX-XXXXXXXXX-X",
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    )
                  ],
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
                      builder: ((context) => WillPopScope(
                            onWillPop: () async => true,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )),
                    );

                    // await userProvider.deleteUserImagefromStorage(
                    //     imageURL: loggedInUser.profileImageURL,
                    //     userID: loggedInUser.userID);
                    if (_imagePath.isNotEmpty) {
                      final imgURl =
                          await userProvider.uploadUserImageToStorage(
                              imagePath: _imagePath,
                              userID: loggedInUser.userID);

                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc("Y1DImckjzK5z2khAEi7o")
                          .collection("contractors")
                          .doc(FirebaseAuth.instance.currentUser!.uid.trim())
                          .update({"profileImageURL": imgURl});
                    }
                    if (cnicController.text.isNotEmpty) {
                      await userProvider.updateUserCNIC(
                          cnic: cnicController.text,
                          userID: loggedInUser.userID);
                    }
                    if (nameController.text.isNotEmpty) {
                      await userProvider.updateUserName(
                          name: nameController.text,
                          userID: loggedInUser.userID);
                    }
                    if (genderText.isNotEmpty) {
                      await userProvider.updateUserGender(
                          gender: genderText == "Male" ? true : false,
                          userID: loggedInUser.userID);
                    }
                    if (contactController.text.isNotEmpty) {
                      await userProvider.updateUserContact(
                          contactNumber: contactController.text,
                          userID: loggedInUser.userID);
                    }
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
