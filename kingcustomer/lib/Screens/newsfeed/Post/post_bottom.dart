import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/providers/customer_provider.dart';
import '../../../models/post_model.dart';
import 'package:provider/provider.dart';
import '../../../helper/size_configuration.dart';
import '../../../providers/post_provider.dart';
import 'comments.dart';
import 'like.dart';

class PostBottom extends StatefulWidget {
  const PostBottom({
    required this.postModel,
    Key? key,
  }) : super(key: key);
  final PostModel postModel;
  @override
  State<PostBottom> createState() => _PostBottomState();
}

class _PostBottomState extends State<PostBottom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CustomerProvider>(context);
    String loggedinUserID = currentUserProvider.getCurrentUser().userID!;
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
                      Text(
                          widget.postModel.likes!.length.toString() + " Likes"),
                    ]),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: GestureDetector(
                    child: Like(
                      isLiked: widget.postModel.likes!.contains(loggedinUserID),
                    ),
                    onTap: () {
                      if (!widget.postModel.likes!.contains(loggedinUserID)) {
                        widget.postModel.likes!.add(loggedinUserID);
                        postProvider.updateLikes(
                            likes: widget.postModel.likes,
                            postID: widget.postModel.postID);
                      } else {
                        widget.postModel.likes!.removeWhere(
                            (element) => element == loggedinUserID);
                        postProvider.updateLikes(
                            likes: widget.postModel.likes,
                            postID: widget.postModel.postID);
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
              Comments(
                postModel: widget.postModel,
                postProvider: postProvider,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
