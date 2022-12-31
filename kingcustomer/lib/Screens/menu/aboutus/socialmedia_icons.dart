import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../helper/size_configuration.dart';
import '../../../widgets/mycontainer.dart';
import 'package:flutter/material.dart';

class SocialMediaIconsStrip extends StatelessWidget {
  const SocialMediaIconsStrip({
    Key? key,
  }) : super(key: key);
  launchURL({required String? url, required BuildContext context}) async {
    try {
      Uri uri = Uri.parse(url!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw "Error occured, trying to launch.";
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => MyContainer(
          height: setHeight(20),
          width: setWidth(50),
          child: const Text("Unexpected Error"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.facebook),
          onPressed: () {
            launchURL(
              url:
                  "https://www.facebook.com/mohammadalijinnahuniversityofficial/",
              context: context,
            );
          },
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        IconButton(
          icon: const Icon(FontAwesomeIcons.youtube),
          onPressed: () {
            launchURL(
              url: "https://www.youtube.com/c/MAJUOfficial",
              context: context,
            );
          },
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        IconButton(
          icon: const Icon(FontAwesomeIcons.twitter),
          onPressed: () {
            launchURL(
              url:
                  "https://twitter.com/MAJUOFFICIAL?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor",
              context: context,
            );
          },
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        IconButton(
          icon: const Icon(FontAwesomeIcons.instagram),
          onPressed: () {
            launchURL(
              url: "https://www.instagram.com/majuofficial/",
              context: context,
            );
          },
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
      ],
    );
  }
}
