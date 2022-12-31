import 'package:flutter/material.dart';
import 'package:kingcustomer/Screens/newsfeed/Post/post.dart';
import 'package:kingcustomer/providers/post_provider.dart';
import 'package:provider/provider.dart';
import '../../helper/size_configuration.dart';

class Newsfeed extends StatefulWidget {
  const Newsfeed({Key? key}) : super(key: key);

  @override
  State<Newsfeed> createState() => _NewsfeedState();
}

class _NewsfeedState extends State<Newsfeed> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final postsList = postProvider.getList;
    Future<void> _onRefresh() async {
      setState(() {});
      await postProvider.fetch();
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: getProportionateScreenWidth(40),
        leading: Image.asset(
          "assets/images/logo-black-half.png",
          fit: BoxFit.contain,
        ),
        title: GestureDetector(
          onTap: () {
            _scrollController.initialScrollOffset;
          },
          child: const Text(
            "Newsfeed",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        // bottom: PreferredSize(
        //   preferredSize: Size(setWidth(100), setHeight(7)),
        //   child: ListTile(
        //     leading: CircleAvatar(
        //       child: ClipOval(
        //         child: CachedNetworkImage(
        //           imageUrl: loggedInUser.profileImageURL!,
        //           fit: BoxFit.fill,
        //           height: getProportionateScreenHeight(80),
        //           width: getProportionateScreenWidth(80),
        //         ),
        //       ),
        //     ),
        //     title: InkWell(
        //       onTap: () => Navigator.push(
        //         context,
        //         PageTransition(
        //             type: PageTransitionType.bottomToTop,
        //             child: const CreatePost(),
        //             duration: const Duration(milliseconds: 300),
        //             inheritTheme: true,
        //             ctx: context),
        //       ),
        //       child: Container(
        //         height: getProportionateScreenHeight(40),
        //         child: const Padding(
        //           padding: EdgeInsets.all(12),
        //           child: Text("Share your skills.."),
        //         ),
        //         decoration: BoxDecoration(
        //           shape: BoxShape.rectangle,
        //           border: Border.all(),
        //           borderRadius: const BorderRadius.all(
        //             Radius.circular(20),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: const Color.fromARGB(255, 251, 225, 54),
        strokeWidth: 4.0,
        onRefresh: () async {
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishs execution.
          return Future<void>.delayed(const Duration(seconds: 0))
              .then((value) async => await _onRefresh());
        },
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: postsList.length,
          itemBuilder: (context, int index) => ChangeNotifierProvider.value(
            value: postsList[index],
            child: const Post(),
          ),
          // physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
