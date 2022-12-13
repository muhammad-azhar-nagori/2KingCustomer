import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/newsfeed/Post/post.dart';
import 'package:kingcustomer/components/profile_header.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:provider/provider.dart';
import '../../providers/post_provider.dart';
import '../../providers/contractor_provider.dart';
import '../../widgets/chat_call_bottom_bar.dart';
import '../Dashboard/dashboard.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userID});
  final String? userID;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ContractorsProvider>(context);
    final user = userProvider.getUserByID(userID!);
    final postProvider = Provider.of<PostProvider>(context);
    final postsList = postProvider.getPostByID(user.userID!);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ));
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(5.0)),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: 800,
              child: ListView(
                children: [
                  ProfileHeader(
                    title: user.name!,
                    email: user.email!,
                    phoneNumber: user.contactNumber!,
                    imageURL: user.profileImageURL!,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(5.0)),
                    child: const Text("Services"),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Container(
                    padding: EdgeInsets.all(getProportionateScreenHeight(8)),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: getProportionateScreenWidth(0),
                          mainAxisSpacing: getProportionateScreenHeight(0),
                          mainAxisExtent: getProportionateScreenHeight(20),
                          childAspectRatio: 150 / 220),
                      itemCount: user.services!.length,
                      itemBuilder: (context, index) =>
                          Text(user.services!.elementAt(index)),
                    ),
                  ),
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
                  const SizedBox(
                    height: 65,
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomCallChat(user: user),
      ),
    );
  }
}
