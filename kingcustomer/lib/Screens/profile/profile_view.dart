import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                  Container(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(60),
                            width: getProportionateScreenWidth(60),
                            child: CircleAvatar(
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: user.profileImageURL!,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name!,
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(20),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  user.email!,
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(14),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  user.contactNumber!,
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(14),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RatingBar.builder(
                                initialRating: (user.rating!.length) / 5,
                                direction: Axis.horizontal,
                                minRating: 0,
                                maxRating: 5,
                                itemBuilder: ((context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.lightBlueAccent,
                                    )),
                                ignoreGestures: true,
                                onRatingUpdate: (newRatingValue) { 
                                  
                                },
                                updateOnDrag: true,
                                
                                allowHalfRating: true,
                                glow: false,
                                itemCount: 5,
                                itemSize: getProportionateScreenHeight(15),
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                ((user.rating!.length) / 5).toString(),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ]),
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
