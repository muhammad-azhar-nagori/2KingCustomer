import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/post_model.dart';
import '../../../helper/size_configuration.dart';
import '../../../providers/comments_provider.dart';
import '../../../providers/post_provider.dart';
import 'open_comments.dart';

class Comments extends StatefulWidget {
  const Comments({
    required this.postModel,
    required this.postProvider,
    Key? key,
  }) : super(key: key);

  final PostModel postModel;
  final PostProvider postProvider;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    final commentsProvider = Provider.of<CommentsProvider>(context);

    return GestureDetector(
      onTap: () async {
        await commentsProvider.fetch();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OpenComments(
                  postModel: widget.postModel,
                  postProvider: widget.postProvider,
                  commentsProvider: commentsProvider),
            ));

        // showCupertinoModalPopup(
        //   context: context,
        //   builder: (context) => MyContainer(
        //       padding: EdgeInsets.only(
        //           bottom: MediaQuery.of(context).viewInsets.bottom),
        //       color: const Color.fromARGB(255, 255, 230, 149),
        //       width: setWidth(100),
        //       height: setHeight(60),
        //       child: OpenComments(
        //         commentsProvider: commentsProvider,
        //         postModel: postModel,
        //         postProvider: postProvider,
        //       )),
        // );
      },
      child: Container(
        color: Colors.transparent,
        height: setHeight(5),
        width: setWidth(45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.comment),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            const Text("Comments"),
          ],
        ),
      ),
    );
  }
}
