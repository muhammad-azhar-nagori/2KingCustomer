import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/profile/profile_view.dart';
import '../../../../helper/size_configuration.dart';
import '../../../../models/contractor_model.dart';

class StoryView extends StatefulWidget {
  final ContractorsModel? userModel;
  final String? itemURL;
  const StoryView({
    super.key,
    required this.userModel,
    this.itemURL,
  });

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {
          if (controller.value >= 0.999) {
            controller.reset();
          }
        });
      });
    controller.repeat().whenCompleteOrCancel(() {
      Navigator.pop(context);
    });
    Future.delayed(const Duration(seconds: 5)).then((value) async {});

    // controller.repeat().whenCompleteOrCancel(() {

    //   Navigator.pop(context);
    // });
    // controller.repeat(reverse: false);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        // Do something here
        controller.reset();
        return true;
      },
      child: Material(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Center(
            child: Stack(children: [
              const SizedBox(
                width: 10,
              ),
              LinearProgressIndicator(
                color: const Color.fromARGB(255, 0, 0, 0),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                value: controller.value,
              ),
              Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileView(userID: widget.userModel!.userID),
                            )),
                        child: CircleAvatar(
                            foregroundImage: CachedNetworkImageProvider(
                                widget.userModel!.profileImageURL!)),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
                      ),
                      Text(
                        widget.userModel!.name!,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                      ),
                      const Spacer(),
                      IconButton(
                          icon: const Icon(Icons.close,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          onPressed: () {
                            controller.reset();
                          })
                    ],
                  )),
              SizedBox(
                width: setWidth(100),
                child: Center(
                  child: Image.network(
                    widget.itemURL!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ]),
          )),
    ));
  }
}
