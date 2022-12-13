// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/Dashboard/dashboard.dart';
import 'package:kingcustomer/Screens/loginSignup/login.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:kingcustomer/widgets/mycontainer.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication_provider.dart';
import '../../providers/current_user_provider.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

bool _isVerified(BuildContext context) {
  if (FirebaseAuth.instance.currentUser!.emailVerified) {
    final currentUserProvider =
        Provider.of<CurrentUserProvider>(context, listen: false);

    currentUserProvider.fetch(FirebaseAuth.instance.currentUser!.uid.trim());
    return true;
  } else {
    return false;
  }
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    print("email verification sent");
    // 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leadingWidth: getProportionateScreenWidth(40),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Verify Email",
          style: TextStyle(
            color: Colors.black,
            fontSize: (kToolbarHeight / 100) * 40,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: setHeight(5),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    side: const BorderSide(
                      width: 0,
                    ),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    setState(() {
                      FirebaseAuth.instance.currentUser!.reload();
                      if (_isVerified(context)) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ));
                      } else {
                        //FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => MyContainer(
                              height: setHeight(15),
                              width: setWidth(90),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                      "Email not verified kindly check your mail and verify email"),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(200, 50),
                                        side: const BorderSide(
                                          width: 0,
                                        ),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                      onPressed: () {
                                        // FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                        print("Email sent Successfully");
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Resend Email"))
                                ],
                              ))),
                        );
                      }
                    });
                  },
                  child: const Text("Verified")),
              SizedBox(
                height: setHeight(5),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    side: const BorderSide(
                      width: 0,
                    ),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                    final currentUserProvider =
                        Provider.of<CurrentUserProvider>(context,
                            listen: false);

                    currentUserProvider.clearList();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ));
                  },
                  child: const Text("sign out"))
            ]),
      ),
    ));
  }
}
