import 'package:flutter/material.dart';

import '../../helper/size_configuration.dart';

class OppositeMessages extends StatelessWidget {
  const OppositeMessages({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: getProportionateScreenHeight(40),
          decoration: BoxDecoration(
            color:const  Color.fromARGB(255, 171, 197, 214),
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: setHeight(5 / 2)),
          ),
        ),
      ],
    );
  }
}
