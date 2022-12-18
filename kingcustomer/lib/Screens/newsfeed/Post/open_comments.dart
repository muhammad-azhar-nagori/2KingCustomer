import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/loginSignup/mytextfield.dart';
import 'package:kingcustomer/helper/size_configuration.dart';

// ignore: must_be_immutable
class OpenComments extends StatelessWidget {
  OpenComments({super.key});
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: setHeight(51.5),
            child: ListView(
              shrinkWrap: true,
            ),
          ),
          MyTextField(
              width: setWidth(
                99,
              ),
              hintText: "Comment your view",
              leading: const Icon(Icons.send_sharp),
              radius: 20,
              controller: commentController),
        ],
      ),
    );
  }
}
