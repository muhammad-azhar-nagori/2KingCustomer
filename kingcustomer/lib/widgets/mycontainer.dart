import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer(
      {Key? key,
      this.image,
      this.height,
      this.width,
      this.child,
      this.color,
      this.padding})
      : super(key: key);
  final ImageProvider? image;
  final double? height;
  final double? width;
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  ImageProvider imageFunc(ImageProvider? img) {
    if (img != null) {
      return img;
    } else {
      return const AssetImage("assets/images/logo-black-full.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
          padding: padding,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: (color != null) ? color : Colors.transparent,
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: child),
    );
  }
}
/*Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text("Add Story"),
            Icon(Icons.add_circle),
          ],
        )); */