import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_provider.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    CustomerProvider userProvider = Provider.of<CustomerProvider>(context);
    final loggedInUser = userProvider.getCurrentUser();

    // final postsList = postProvider.getList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: (kToolbarHeight / 100) * 40,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(5.0),
              top: getProportionateScreenHeight(5.0),
              right: getProportionateScreenWidth(5.0),
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            scrollDirection: Axis.vertical,
            child: SizedBox(
                height: setHeight(100),
                width: setWidth(100),
                child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(60),
                          width: getProportionateScreenWidth(60),
                          child: CircleAvatar(
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: loggedInUser.profileImageURL!,
                                fit: BoxFit.cover,
                                height: getProportionateScreenHeight(60),
                                width: getProportionateScreenHeight(60),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenHeight(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(20),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                loggedInUser.email!,
                                style: TextStyle(
                                  fontSize: getProportionateScreenHeight(14),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                loggedInUser.contactNumber!,
                                style: TextStyle(
                                  fontSize: getProportionateScreenHeight(14),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ]),
                )),
          ),
        ),
      ),
    );
  }
}
