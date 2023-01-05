// // ignore_for_file: unused_catch_clause

// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:kingcustomer/models/current_user.dart';
// import 'package:kingcustomer/widgets/mycontainer.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../helper/size_configuration.dart';
// import '../../../../models/customer_model.dart';
// import '../../../../providers/current_user_provider.dart';
// import '../../../../providers/customer_provider.dart';
// import '../../../../providers/story_provider.dart';

// class CreateStory extends StatefulWidget {
//   const CreateStory({super.key});

//   @override
//   State<CreateStory> createState() => _CreateStoryState();
// }

// class _CreateStoryState extends State<CreateStory> {
//   String _imagePath = "";
//   File? _selectedImageFile;
//   final TextEditingController _textController = TextEditingController();
//   void pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final _image = await _picker.pickImage(source: ImageSource.gallery);
//     if (_image?.path != null) {
//       setState(() {
//         _selectedImageFile = File(_image!.path);
//         _imagePath = _image.path;
//       });
//     }
//   }

//   @override
//   initState() {
//     pickImage();
//     // this is called when the class is initialized or called for the first time
//     super
//         .initState(); //  this is the material super constructor for init state to link your instance initState to the global initState context
//   }

//   uploadStory() async {
//     try {
//       if (_imagePath.isNotEmpty) {
//         CustomerProvider userProvider =
//             Provider.of<CustomerProvider>(context, listen: false);
//         CustomerModel loggedInUser = userProvider.getCurrentUser();
//         final storyProvider =
//             Provider.of<StoryProvider>(context, listen: false);
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: ((context) => WillPopScope(
//               onWillPop: () async => false,
//               child: const Center(child: CircularProgressIndicator()))),
//         );
//         String? imageURL = await storyProvider.uploadImageToStorage(
//             imagePath: _imagePath, userID: loggedInUser.userID);

//         await storyProvider.uploadImageDataToFireStore(
//           imageURL: imageURL,
//           userID: loggedInUser.userID,
//           userName: loggedInUser.name,
//           caption: _textController.text,
//         );
//         await storyProvider.fetch();

//         Navigator.pop(context);
//         Navigator.pop(context);
//       }

//       // Future.delayed(const Duration(milliseconds: 0)).then((value) async {
//       //   await postProvider.fetch();
//       // });
//       // ignore: empty_catches
//     } on FirebaseException catch (e) {
//       // ignore: empty_catches
//     } catch (e) {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     CustomerProvider userProvider =
//         Provider.of<CustomerProvider>(context, listen: false);
//     CustomerModel loggedInUser =
//         userProvider.getUserByID(FirebaseAuth.instance.currentUser!.uid.trim());
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.black),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           centerTitle: true,
//           title: const Text(
//             "Share Story",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: (kToolbarHeight / 100) * 40,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: EdgeInsets.only(
//               left: getProportionateScreenWidth(8),
//               right: getProportionateScreenWidth(8),
//               bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: SizedBox(
//             height: setHeight(100),
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 Row(
//                   children: [
//                     SizedBox(
//                       height: getProportionateScreenHeight(60),
//                       width: getProportionateScreenWidth(60),
//                       child: CircleAvatar(
//                         child: ClipOval(
//                           child: CachedNetworkImage(
//                             imageUrl: loggedInUser.profileImageURL!,
//                             fit: BoxFit.fill,
//                             height: getProportionateScreenHeight(80),
//                             width: getProportionateScreenWidth(80),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: setWidth(2),
//                     ),
//                     Text(
//                       loggedInUser.name!,
//                       style: Theme.of(context).textTheme.displaySmall,
//                     ),
//                     const Spacer(),
//                     ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                           const Color.fromARGB(255, 255, 210, 32),
//                         ),
//                         minimumSize: MaterialStateProperty.all(
//                           Size(setWidth(6), setHeight(6)),
//                         ),
//                       ),
//                       onPressed: () {
//                         uploadStory();
//                       },
//                       child: const Text("Share",
//                           style:
//                               TextStyle(fontSize: 18, color: Colors.black87)),
//                     ),
//                   ],
//                 ),
//                 _selectedImageFile != null
//                     ? Stack(
//                         alignment: AlignmentDirectional.topEnd,
//                         children: [
//                           MyContainer(
//                             width: setWidth(100),
//                             height: setHeight(40),
//                             child: Image.file(_selectedImageFile!),
//                           ),
//                           FloatingActionButton(
//                               onPressed: () {
//                                 setState(() {
//                                   _selectedImageFile = null;
//                                 });
//                               },
//                               child: const Icon(Icons.cancel),
//                               isExtended: false,
//                               mini: true),
//                         ],
//                       )
//                     : MyContainer(
//                         height: setHeight(40),
//                         child: InkWell(
//                             child: const Icon(Icons.add_a_photo),
//                             onTap: () {
//                               pickImage();
//                             }),
//                         width: setWidth(100),
//                       ),
//                 TextFormField(
//                   controller: _textController,
//                   maxLines: 20,
//                   textAlign: TextAlign.start,
//                   style: const TextStyle(
//                     fontSize: 18,
//                   ),
//                   decoration: InputDecoration(
//                     filled: true,
//                     contentPadding:
//                         EdgeInsets.all(getProportionateScreenWidth(10)),
//                     isCollapsed: true,
//                     hintText: "What's in your mind?",
//                   ),
//                 ),
//               ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
