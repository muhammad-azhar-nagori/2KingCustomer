import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.inputType,
    this.hintText = "",
    this.height = 65,
    required this.width,
    this.color,
    this.leading,
    this.obsecure = false,
    this.radius = 20,
    this.controller,
    this.onChanged,
  });

  final String? hintText;
  final double? height;
  final double width;
  final Color? color;
  final Widget? leading;
  final double radius;
  final bool obsecure;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      obscureText: obsecure,
      controller: controller,
      onChanged: onChanged,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 18,
      ),
      scrollPhysics: const ScrollPhysics(),
      decoration: InputDecoration(
        constraints: BoxConstraints(
          minWidth: width,
          maxWidth: width,
        ),
        suffixIcon: leading,
        fillColor: (color != null) ? color : Colors.white,
        filled: true,
        isCollapsed: true,
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(12, height! / 3, 12, height! / 3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );
  }
}
