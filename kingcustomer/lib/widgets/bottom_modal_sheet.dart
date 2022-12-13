import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/loginSignup/mytextfield.dart';
import 'package:kingcustomer/helper/size_configuration.dart';

customBottomModalSheet(
    {required BuildContext context,
    required String? title,
    required TextEditingController? controller,
    required String? hintText,
    double? hight = 220,
    Widget? button}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 210, 32),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(getProportionateScreenWidth(20)),
            topLeft: Radius.circular(getProportionateScreenWidth(20)),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 210, 32),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(getProportionateScreenWidth(20)),
              topLeft: Radius.circular(getProportionateScreenWidth(20)),
            ),
          ),
          margin: EdgeInsets.only(
            top: getProportionateScreenHeight(0.2),
            right: getProportionateScreenHeight(0.2),
            left: getProportionateScreenHeight(0.2),
          ),
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(20),
            left: getProportionateScreenWidth(20),
            top: getProportionateScreenHeight(20),
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: getProportionateScreenHeight(20),
            ),
            child: Wrap(
              runSpacing: getProportionateScreenWidth(10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: getProportionateScreenWidth(20),
                      ),
                    ),
                  ],
                ),
                MyTextField(
                  width: SizeConfig.screenWidth,
                  height: 50,
                  radius: 20,
                  leading: button,
                  controller: controller,
                  hintText: hintText,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
