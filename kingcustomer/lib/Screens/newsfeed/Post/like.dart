import 'package:flutter/material.dart';

import '../../../helper/size_configuration.dart';

class Like extends StatelessWidget {
  const Like({
    Key? key,
    required this.isLiked,
  }) : super(key: key);
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: setHeight(5),
      width: setWidth(48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(
            thickness: 0.1,
            color: Colors.black,
            height: 0,
          ),
          Icon(
            Icons.thumb_up,
            color: isLiked ? Colors.blueAccent : Colors.black,
          ),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          Text("Like",
              style:
                  TextStyle(color: isLiked ? Colors.blueAccent : Colors.black)),
        ],
      ),
    );
  }
}
