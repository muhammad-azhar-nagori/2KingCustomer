import 'package:flutter/material.dart';
import '../../helper/size_configuration.dart';
import '../../widgets/bottom_modal_sheet.dart';

class MyProfileFields extends StatefulWidget {
  const MyProfileFields({
    Key? key,
    required this.contact,
    required this.email,
    required this.gender,
    required this.name,
    required this.password,
  }) : super(key: key);
  final String name, gender, password, contact, email;

  @override
  State<MyProfileFields> createState() => _MyProfileFieldsState();
}

class _MyProfileFieldsState extends State<MyProfileFields> {
  TextEditingController nameController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController contactController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
            nameController.text.isEmpty ? widget.name : nameController.text,
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
            widget.gender == "true" ? "Male" : "Female",
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
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_forward_rounded)),
            context: context,
            hight: 356,
            controller: genderController,
            title: "Change Gender",
            hintText: "male/female",
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
                ? widget.contact
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
            "Email:   ",
            style: TextStyle(
                fontSize: getProportionateScreenHeight(20),
                fontWeight: FontWeight.bold),
          ),
          title: Text(
            emailController.text.isEmpty ? widget.email : emailController.text,
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
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_forward_rounded)),
            context: context,
            hight: 356,
            controller: emailController,
            title: "Change Email",
            hintText: "example@xyz.com",
          ),
        ),
        Divider(
          thickness: getProportionateScreenHeight(0.2),
          color: Colors.black,
        ),
        ListTile(
          leading: Text(
            "Password:",
            style: TextStyle(
                fontSize: getProportionateScreenHeight(20),
                fontWeight: FontWeight.bold),
          ),
          title: Text(
            passwordController.text.isEmpty
                ? widget.password
                : passwordController.text,
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
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_forward_rounded)),
            context: context,
            hight: getProportionateScreenHeight(356),
            controller: passwordController,
            title: "Change Password",
            hintText: "New Password",
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(5),
        )
      ],
    );
  }
}
