import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/models/post_model.dart';
import 'package:provider/provider.dart';
import '../../../helper/size_configuration.dart';
import '../../../providers/customer_provider.dart';
import '../../../providers/post_provider.dart';
import 'comments.dart';
import 'like.dart';

class PostBottom extends StatelessWidget {
  const PostBottom({
    required this.postModel,
    Key? key,
  }) : super(key: key);
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CustomerProvider>(context);
    String loggedinUserID = currentUserProvider
        .getUserByID(FirebaseAuth.instance.currentUser!.uid.trim())
        .userID!;
    final postProvider = Provider.of<PostProvider>(context);
    return SizedBox(
      height: setHeight(7),
      width: setWidth(100),
      child: Column(
        children: [
          SizedBox(
              height: setHeight(2),
              width: setWidth(100),
              child: Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(8),
                    right: getProportionateScreenWidth(8)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(postModel.likes!.length.toString() + "likes"),
                      Text(postModel.comments!.length.toString() + "comments"),
                    ]),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: GestureDetector(
                    child: Like(
                      isLiked: postModel.likes!.contains(loggedinUserID),
                    ),
                    onTap: () {
                      if (!postModel.likes!.contains(loggedinUserID)) {
                        postModel.likes!.add(loggedinUserID);
                        postProvider.updateLikes(
                            likes: postModel.likes, postID: postModel.postID);
                      } else {
                        postModel.likes!.removeWhere(
                            (element) => element == loggedinUserID);
                        postProvider.updateLikes(
                            likes: postModel.likes, postID: postModel.postID);
                      }
                    }),
              ),
              Container(
                width: 1,
                height: getProportionateScreenHeight(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              Comments(postModel: postModel, postProvider: postProvider),
            ],
          ),
        ],
      ),
    );
  }
}
