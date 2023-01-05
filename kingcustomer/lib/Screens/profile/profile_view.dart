import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kingcustomer/Screens/newsfeed/Post/post.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_provider.dart';
import '../../providers/post_provider.dart';
import '../../providers/contractor_provider.dart';
import '../../widgets/chat_call_bottom_bar.dart';
import '../Dashboard/dashboard.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.userID});
  final String? userID;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  double ratingg(List rating) {
    double length = rating.length.toDouble() - 1;
    double total = 0;
    for (var r in rating) {
      total += double.parse(r.split(" ")[1]);
    }
    return total / length;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ContractorsProvider>(context);
    final user = userProvider.getUserByID(widget.userID!);
    final postProvider = Provider.of<PostProvider>(context);
    final postsList = postProvider.getPostByID(user.userID!);
    final currentUserProvider = Provider.of<CustomerProvider>(context);
    String loggedinUserID = currentUserProvider.getCurrentUser().userID!;

    final double starRating = ratingg(user.rating!);

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
                                initialRating:
                                    starRating.toStringAsFixed(1) == "Infinity"
                                        ? 0
                                        : starRating,
                                minRating: 0,
                                maxRating: 5,
                                itemBuilder: ((context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.lightBlueAccent,
                                    )),
                                ignoreGestures: false,
                                onRatingUpdate: (newRatingValue) {
                                  List _newlist = user.rating!;
                                  for (int i = 0;
                                      i < user.rating!.length;
                                      i++) {
                                    if (user.rating![i].split(" ")[0] ==
                                        loggedinUserID) {
                                      user.rating!.removeAt(i);
                                    }
                                  }
                                  _newlist
                                      .add(loggedinUserID + " $newRatingValue");
                                  userProvider.updateRating(
                                      userID: user.userID,
                                      rating: user.rating!);
                                },
                                updateOnDrag: false,
                                allowHalfRating: false,
                                glow: false,
                                itemCount: 5,
                                itemSize: getProportionateScreenHeight(15),
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                starRating.toStringAsFixed(1) == "Infinity"
                                    ? ""
                                    : starRating.toStringAsFixed(1),
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
