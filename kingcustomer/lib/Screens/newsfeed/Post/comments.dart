import 'package:flutter/material.dart';
import '../../../helper/size_configuration.dart';
import 'open_comments.dart';

class Comments extends StatelessWidget {
  const Comments({
    Key? key,
    required this.isClicked,
  }) : super(key: key);
  final bool isClicked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OpenComments(),
          )),
      child: Row(
        children: [
          const Icon(Icons.comment),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
         const  Text("Comments"),
        ],
      ),
    );
  }
}
