// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/loginSignup/verify_email.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kingcustomer/providers/customer_provider.dart';
import 'package:provider/provider.dart';
import 'package:kingcustomer/Screens/loginSignup/mytextfield.dart';
import '../../helper/size_configuration.dart';
import '../../providers/agreement_provider.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/current_user_provider.dart';
import '../../providers/service_log_provider.dart';
import '../../providers/message_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/worker_provider.dart';
import '../../widgets/mycontainer.dart';

class UserForm extends StatefulWidget {
  final String email;
  final String password;
  const UserForm({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController cnicController = TextEditingController();

  final TextEditingController contactController = TextEditingController();

  String dropdownvalue = 'Select';
  List<String> items = <String>[
    'Male',
    'Female',
  ];
  String _imagePath = "";
  File? _selectedImageFile;
  String genderText = "";

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

  loadcurrentUser() async {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    await ordersProvider.fetch();
    try {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      await chatProvider.fetch();
    } catch (e) {
      print(e);
    }

    try {
      final messageProvider =
          Provider.of<MessageProvider>(context, listen: false);

      messageProvider.fetch();
    } catch (e) {
      print(e);
    }
    try {
      final aggrementProvider =
          Provider.of<AgreementProvider>(context, listen: false);

      aggrementProvider.fetch();
    } catch (e) {
      print(e);
    }
    try {
      Provider.of<ServiceLogsProvider>(context, listen: false);
    } catch (e) {
      print(e);
    }
  }

  createAccountandLogin() async {
    await context
        .read<AuthenticationService>()
        .signUp(email: widget.email.trim(), password: widget.password.trim());

    await context
        .read<AuthenticationService>()
        .signIn(email: widget.email.trim(), password: widget.password.trim());
  }

  uploadUserData(
      {String? cnic,
      String? contactNumber,
      String? email,
      bool? gender,
      String? name,
      String? userID}) async {
    final userProvider = Provider.of<CustomerProvider>(context, listen: false);

    try {
      DateTime date = DateTime.now();
      String imageURL = await userProvider.uploadUserImageToStorage(
          imagePath: _imagePath, userID: userID);
      userProvider.uploadUserDataToFireStore(
        userID: userID,
        cnic: cnic,
        contactNumber: contactNumber,
        email: email,
        gender: gender,
        name: name,
        status: true,
        createdDate: date,
        profileImageURL: imageURL,
      );
      userProvider.fetch();
    } on FirebaseException catch (e) {
      print(e.message);
      print(e.code);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: getProportionateScreenWidth(40),
          leading: Image.asset(
            "assets/images/logo-black-half.png",
            fit: BoxFit.contain,
          ),
          title: const Text(
            "Signup",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: setHeight(100),
              child: Column(children: [
                Container(
                  height: setHeight(40),
                  width: setWidth(95),
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(getProportionateScreenWidth(20)),
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
                        Center(
                          heightFactor: 1.1,
                          child: SizedBox(
                            height: setHeight(30),
                            width: setWidth(80),
                            child: _selectedImageFile != null
                                ? Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                        MyContainer(
                                            width: setWidth(100),
                                            height: setHeight(40),
                                            child:
                                                Image.file(_selectedImageFile!))
                                      ])
                                : MyContainer(
                                    height: setHeight(40),
                                    child: InkWell(
                                        child: const Icon(Icons.add_a_photo),
                                        onTap: () {
                                          pickImage();
                                        }),
                                    width: setWidth(100),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MyTextField(
                  color: const Color.fromARGB(255, 255, 239, 63),
                  width: setWidth(95),
                  radius: 20,
                  hintText: "Full Name",
                  controller: nameController,
                ),
                Row(
                  children: [
                    InkWell(
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
                      child: MyContainer(
                        color: const Color.fromARGB(255, 255, 239, 63),
                        height: getProportionateScreenHeight(60),
                        width: setWidth(45),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 10),
                          child: Text(
                            genderText == "" ? "Select Gender" : genderText,
                            style: TextStyle(
                                fontSize: 18,
                                color: genderText != ""
                                    ? Colors.black
                                    : Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    MyTextField(
                      color: const Color.fromARGB(255, 255, 239, 63),
                      width: setWidth(45),
                      radius: 20,
                      hintText: "Contact",
                      controller: contactController,
                    ),
                  ],
                ),
                MyTextField(
                  color: const Color.fromARGB(255, 255, 239, 63),
                  width: setWidth(45),
                  radius: 20,
                  hintText: "CNIC",
                  controller: cnicController,
                ),
                SizedBox(
                  height: setHeight(2),
                ),
                Center(
                  child: SizedBox(
                    width: 150,
                    child: Visibility(
                      visible: nameController.text.isNotEmpty &&
                          cnicController.text.isNotEmpty &&
                          genderText.isNotEmpty &&
                          contactController.text.isNotEmpty,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1,
                          ),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(20),
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: ((context) => const Center(
                                child: CircularProgressIndicator())),
                          );
                          await createAccountandLogin();
                          final loggedInUser =
                              FirebaseAuth.instance.currentUser;
                          await uploadUserData(
                              cnic: cnicController.text,
                              contactNumber: contactController.text,
                              email: loggedInUser!.email!,
                              gender: genderText == "Male" ? true : false,
                              name: nameController.text,
                              userID: loggedInUser.uid);
                          await loadcurrentUser();

                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifyEmail(),
                              ));
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
