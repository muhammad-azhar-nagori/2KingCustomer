import 'package:flutter/material.dart';
import '../../../Screens/menu/aboutus/socialmedia_icons.dart';
import '../../../helper/size_configuration.dart';
import 'package:provider/provider.dart';
import '../../../providers/about.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final aboutProvider = Provider.of<AboutProvider>(context);

    List<AboutModel> aboutDataList = aboutProvider.getAboutList;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                getProportionateScreenWidth(20),
                0,
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BuildTitleWithDescription(
                    title: "About Us",
                    description: "",
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: aboutDataList.length,
                    separatorBuilder: ((context, index) => SizedBox(
                          height: getProportionateScreenHeight(10),
                        )),
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10),
                    ),
                    itemBuilder: ((context, index) {
                      return BuildTitleWithDescription(
                        title: aboutDataList[index].getTitle,
                        description: aboutDataList[index].getDescription,
                      );
                    }),
                  ),
                  const BuildTitleWithDescription(
                    title: "Follow Us",
                    description:
                        "For latest update please follow us on our social media platforms.",
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  const SocialMediaIconsStrip()
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class BuildTitleWithDescription extends StatelessWidget {
  final String? _title, _description;
  const BuildTitleWithDescription({
    Key? key,
    required String? title,
    required String? description,
  })  : _title = title,
        _description = description,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _title!,
          style: TextStyle(
            color: const Color.fromARGB(255, 11, 11, 11).withOpacity(0.8),
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(25),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(5)),
        Text(
          _description!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color.fromARGB(255, 11, 11, 11).withOpacity(0.8),
            fontSize: getProportionateScreenWidth(15),
          ),
        ),
      ],
    );
  }
}
