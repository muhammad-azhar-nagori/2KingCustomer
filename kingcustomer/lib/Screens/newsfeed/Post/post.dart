import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/newsfeed/Post/post_bottom.dart';
import 'package:kingcustomer/Screens/newsfeed/Post/post_header.dart';
import 'package:kingcustomer/Screens/newsfeed/Post/post_item.dart';
import 'package:kingcustomer/models/post_model.dart';
import 'package:provider/provider.dart';
import '../../../providers/contractor_provider.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<PostModel>(context);
    final userProvider = Provider.of<ContractorsProvider>(context);
    final user = userProvider.getUserByID(postModel.userID!);
    return Card(
      color: const Color.fromARGB(255, 255, 230, 149),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PostHeader(
              userID: user.userID!,
              title: user.name!,
              date: postModel.postedTime,
              profilePicURL: user.profileImageURL!),
          PostItem(imageURL: postModel.imageURL, caption: postModel.caption),
          PostBottom(postModel: postModel),
        ],
      ),
    );
  }
}
