import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../Screens/loginSignup/mytextfield.dart';
import '../../../helper/size_configuration.dart';
import '../../../models/comments_model.dart';
import '../../../providers/comments_provider.dart';
import '../../../providers/customer_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/post_model.dart';
import '../../../providers/post_provider.dart';

// ignore: must_be_immutable
class OpenComments extends StatelessWidget {
  OpenComments(
      {super.key,
      required this.postModel,
      required this.postProvider,
      required this.commentsProvider});
  TextEditingController commentController = TextEditingController();

  final PostModel postModel;
  final PostProvider postProvider;
  final CommentsProvider commentsProvider;

  @override
  Widget build(BuildContext context) {
    final commentsList = commentsProvider.getList;

    return SingleChildScrollView(
      child: SizedBox(
        height: setHeight(60),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 230, 149),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              height: setHeight(52),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                scrollDirection: Axis.vertical,
                itemCount: commentsList.length,
                itemBuilder: (context, int index) {
                  return ChangeNotifierProvider.value(
                      value: commentsList[index],
                      child: CommentTile(commentsModel: commentsList[index]));
                },
                physics: const BouncingScrollPhysics(),
              ),
            ),
            SizedBox(
              height: setHeight(7),
              child: MyTextField(
                  width: setWidth(
                    99,
                  ),
                  hintText: "Comment your view",
                  leading: const Icon(Icons.send_sharp),
                  radius: getProportionateScreenWidth(20),
                  controller: commentController),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  const CommentTile({
    Key? key,
    required this.commentsModel,
  }) : super(key: key);

  final CommentsModel commentsModel;

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    final user = customerProvider.getUserByID(commentsModel.userID!);
    return ListTile(
      leading: ClipOval(
        child: CachedNetworkImage(
          imageUrl: user.profileImageURL!,
        ),
      ),
      title: Text(user.name!),
      subtitle: Text(commentsModel.text!),
    );
  }
}
