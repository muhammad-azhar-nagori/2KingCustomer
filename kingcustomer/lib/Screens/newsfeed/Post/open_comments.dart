import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../helper/size_configuration.dart';
import '../../../models/comments_model.dart';
import '../../../providers/comments_provider.dart';
import '../../../providers/customer_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/post_model.dart';
import '../../../providers/post_provider.dart';
import '../../loginSignup/mytextfield.dart';

// ignore: must_be_immutable
class OpenComments extends StatefulWidget {
  const OpenComments({
    super.key,
    required this.postModel,
    required this.postProvider,
    required this.commentsProvider,
  });
  final PostModel postModel;
  final PostProvider postProvider;
  final CommentsProvider commentsProvider;

  @override
  State<OpenComments> createState() => _OpenCommentsState();
}

class _OpenCommentsState extends State<OpenComments> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.commentsProvider.fetch();
    final commentsList =
        widget.commentsProvider.getCommentByPostID(widget.postModel.postID!);
    final customerProvider = Provider.of<CustomerProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: setHeight(50),
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,

            scrollDirection: Axis.vertical,
            itemCount: commentsList.length,
            itemBuilder: (context, int index) => ChangeNotifierProvider.value(
                value: commentsList[index],
                child: ListTile(
                  minLeadingWidth: 50,
                  leading: SizedBox(
                    height: setHeight(10),
                    width: setWidth(10),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: customerProvider
                            .getUserByID(commentsList[index].userID!)
                            .profileImageURL!,
                      ),
                    ),
                  ),
                  title: Text(customerProvider
                      .getUserByID(commentsList[index].userID!)
                      .name!),
                  subtitle: Text(commentsList[index].text!),
                )),

            physics: const BouncingScrollPhysics(),

            // SizedBox(
            //   height: setHeight(7),
            //   child: MyTextField(
            //       width: setWidth(
            //         99,
            //       ),
            //       hintText: "Comment your view",
            //       leading: const Icon(Icons.send_sharp),
            //       radius: getProportionateScreenWidth(20),
            //       controller: commentController),
            // ),
          ),
        ),
        bottomSheet: SizedBox(
          height: setHeight(7),
          child: MyTextField(
              width: setWidth(
                99,
              ),
              hintText: "Comment your view",
              leading: GestureDetector(
                  onTap: commentController.text.isNotEmpty
                      ? () async {
                          print("s");
                          await widget.commentsProvider
                              .uploadCommentDataToFireStore(
                                  userID:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  text: commentController.text,
                                  postID: widget.postModel.postID!);
                          commentController.clear();
                        }
                      : null,
                  child: const Icon(Icons.send_sharp)),
              radius: getProportionateScreenWidth(20),
              controller: commentController),
        ),
      ),
    );
  }
}

class CommentTile extends StatefulWidget {
  const CommentTile({
    Key? key,
  }) : super(key: key);

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    final commentsModel = Provider.of<CommentsModel>(context);
    final user = customerProvider.getUserByID(commentsModel.userID!);
    return ListTile(
      minLeadingWidth: 50,
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
