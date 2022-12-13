import 'package:flutter/material.dart';
import '../../../helper/size_configuration.dart';
import 'comments.dart';
import 'like.dart';

class OpenPost extends StatelessWidget {
  const OpenPost({
    super.key,
    required this.imageURL,
    required this.caption,
  });

  final String? imageURL;

  final String? caption;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
                padding:const  EdgeInsets.all(12),
                child: Row(
                  children: [
                    CircleAvatar(foregroundImage: NetworkImage(imageURL!)),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    Text(
                      caption!,
                      style:const  TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )),
            Container(
              color:const  Color.fromARGB(255, 0, 0, 0),
              height: setHeight(31),
              child: Image.network(
                imageURL!,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(50),
                  right: getProportionateScreenWidth(50),
                  bottom: getProportionateScreenHeight(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child:const  Like(
                      isLiked: false,
                    ),
                    onTap: () =>const  Like(
                      isLiked: true,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: getProportionateScreenHeight(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>const  Comments(isClicked: true),
                    child:const  Comments(isClicked: false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
