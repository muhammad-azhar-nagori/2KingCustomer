import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../helper/size_configuration.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.imageURL,
    required this.caption,
  }) : super(key: key);
  final String? imageURL;
  final String? caption;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(10)),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SizedBox(
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SafeArea(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Center(
                                child: CachedNetworkImage(
                              imageUrl: imageURL!,
                              progressIndicatorBuilder:
                                  (context, url, progress) => const Center(
                                      child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                            )),
                            const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )))),
        ),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 0,
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Text("$caption"),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Container(
                color: const Color.fromARGB(255, 0, 0, 0),
                height: setHeight(31),
                width: setWidth(100),
                // child: Image.network(
                //   "$imageURL",
                //   fit: BoxFit.fitWidth,
                // ),
                child: CachedNetworkImage(
                    imageUrl: imageURL!, fit: BoxFit.fitWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
