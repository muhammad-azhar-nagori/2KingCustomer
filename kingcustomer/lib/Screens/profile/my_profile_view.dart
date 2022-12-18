import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/newsfeed/Post/post.dart';
import 'package:kingcustomer/components/profile_header.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_provider.dart';
import '../../providers/post_provider.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    CustomerProvider userProvider = Provider.of<CustomerProvider>(context);
    final loggedInUser =
        userProvider.getUserByID(FirebaseAuth.instance.currentUser!.uid.trim());

    final postProvider = Provider.of<PostProvider>(context);
    final postsList = postProvider.getPostByID(loggedInUser.userID!);
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
              height: 800,
              child: ListView(
                children: [
                  ProfileHeader(
                    title: loggedInUser.name!,
                    email: loggedInUser.email!,
                    phoneNumber: loggedInUser.contactNumber!,
                    imageURL: loggedInUser.profileImageURL!,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(5.0)),
                    child: const Text("Available Services"),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(getProportionateScreenHeight(8)),
                  //   child: GridView.builder(
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 3,
                  //         crossAxisSpacing: getProportionateScreenWidth(0),
                  //         mainAxisSpacing: getProportionateScreenHeight(0),
                  //         mainAxisExtent: getProportionateScreenHeight(20),
                  //         childAspectRatio: 150 / 220),
                  //     itemCount: loggedInUser.services!.length,
                  //     itemBuilder: (context, index) =>
                  //         Text(loggedInUser.services!.elementAt(index)),
                  //   ),
                  // ),
                  ListView.builder(
                    itemCount: postsList.length,
                    itemBuilder: (context, int index) =>
                        ChangeNotifierProvider.value(
                      value: postsList[index],
                      child: const Post(),
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
