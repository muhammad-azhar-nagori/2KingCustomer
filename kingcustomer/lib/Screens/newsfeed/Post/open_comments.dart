import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/loginSignup/mytextfield.dart';
import 'package:kingcustomer/helper/size_configuration.dart';

// ignore: must_be_immutable
class OpenComments extends StatelessWidget {
  OpenComments({super.key});
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            Container(
              color: Colors.amber,
              height: setHeight(88),
              child: ListView(
                shrinkWrap: true,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              height: setHeight(7.5),
              child: MyTextField(
                  width: setWidth(
                    99,
                  ),
                  hintText: "Comment your view",
                  leading:const  Icon(Icons.send_sharp),
                  radius: getProportionateScreenWidth(20),
                  controller: commentController),
            ),
          ],
        ),
      )),
    );
  }
}
