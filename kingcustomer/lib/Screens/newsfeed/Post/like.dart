import 'package:flutter/material.dart';

import '../../../helper/size_configuration.dart';

class Like extends StatefulWidget {
  const Like({
    Key? key,
    required this.isLiked,
  }) : super(key: key);
  final bool isLiked;

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.thumb_up,
          color: widget.isLiked ? Colors.blueAccent : Colors.black,
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text("Like",
            style:
                TextStyle(color: widget.isLiked ? Colors.blueAccent : Colors.black)),
      ],
    );
  }
}
