import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/post_model.dart';
import '../../../providers/comments_provider.dart';
import '../../../widgets/mycontainer.dart';
import '../../../helper/size_configuration.dart';
import '../../../providers/post_provider.dart';
import 'open_comments.dart';

class Comments extends StatelessWidget {
  const Comments({
    required this.postModel,
    required this.postProvider,
    Key? key,
    required this.commentsProvider,
  }) : super(key: key);

  final PostModel postModel;
  final PostProvider postProvider;
  final CommentsProvider commentsProvider;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => MyContainer(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                color: const Color.fromARGB(255, 255, 230, 149),
                width: setWidth(100),
                height: setHeight(60),
                child: OpenComments(
                  commentsProvider: commentsProvider,
                  postModel: postModel,
                  postProvider: postProvider,
                )),
          );
        } catch (e) {}
      },
      child: Container(
        color: Colors.transparent,
        height: setHeight(5),
        width: setWidth(48),
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
