import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/homepage/components/story/story_view.dart';
import 'package:kingcustomer/widgets/mycontainer.dart';
import 'package:kingcustomer/helper/size_configuration.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../models/story_model.dart';
import '../../../../models/contractor_model.dart';
import '../../../../providers/story_provider.dart';
import '../../../../providers/contractor_provider.dart';

class Stories extends StatelessWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storyProvider = Provider.of<StoryProvider>(context);
    final storyList = storyProvider.getList;

    final userProvider = Provider.of<ContractorsProvider>(context);

    return SizedBox(
        height: getProportionateScreenHeight(140),
        width: setWidth(100),
        child: SizedBox(
          width: setWidth(100),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemExtent: setWidth(22),
              itemCount: storyList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: storyList[index],
                    child: StoryTile(
                      user: userProvider.getUserByID(storyList[index].userID!),
                    ));
              }),
        ));
  }
}

class StoryTile extends StatelessWidget {
  const StoryTile({
    Key? key,
    required this.user,
  }) : super(key: key);
  final ContractorsModel user;
  @override
  Widget build(BuildContext context) {
    final storyModel = Provider.of<StoryModel>(context);
    final userModel = user;
    return Stack(
      children: [
        MyContainer(
          height: setHeight(18),
          width: setWidth(20),
          image: CachedNetworkImageProvider(userModel.profileImageURL!),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onTap: () => Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: StoryView(
                  caption: storyModel.caption,
                  postTime: storyModel.postedTime.toString().split(" ").first,
                  itemURL: storyModel.imageURL,
                  userModel: userModel,
                ),
                duration: const Duration(milliseconds: 400),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: storyModel.imageURL!,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                getProportionateScreenWidth(100),
              ),
            ),
          ),
          child: CircleAvatar(
              foregroundImage:
                  CachedNetworkImageProvider(userModel.profileImageURL!)),
        ),
      ],
    );
  }
}
