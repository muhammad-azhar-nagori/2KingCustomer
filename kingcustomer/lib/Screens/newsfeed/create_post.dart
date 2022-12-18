// // ignore_for_file: avoid_print

// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:kingcustomer/widgets/mycontainer.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../../helper/size_configuration.dart';
// import '../../providers/current_user_provider.dart';
// import '../../providers/customer_provider.dart';
// import '../../providers/post_provider.dart';

// class CreatePost extends StatefulWidget {
//   const CreatePost({super.key});

//   @override
//   State<CreatePost> createState() => _CreatePostState();
// }

// class _CreatePostState extends State<CreatePost> {
//   String _imagePath = "";
//   File? _selectedImageFile;

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

//   uploadPost() async {
//     final userProvider = Provider.of<CustomerProvider>(context);
//     final loggedInUser =
//         userProvider.getUserByID(FirebaseAuth.instance.currentUser!.uid.trim());
//     final postProvider = Provider.of<PostProvider>(context);
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: ((context) => const Center(child: CircularProgressIndicator())),
//     );
//     try {
//       DateTime date = DateTime.now();
//       String imageURL = await postProvider.uploadImageToStorage(
//           imagePath: _imagePath,
//           imageType: "posts",
//           userID: loggedInUser.userID);

//       await postProvider.uploadPostDataToFireStore(
//         imageURL: imageURL,
//         userID: loggedInUser.userID,
//         userName: loggedInUser.name,
//         date: date,
//         caption: "",
//       );

//       await postProvider.fetch();
//       Navigator.pop(context);
//       Navigator.pop(context);
      
//       // Future.delayed(const Duration(milliseconds: 0)).then((value) async {
//       //   await postProvider.fetch();
//       // });
//     } on FirebaseException catch (e) {
//       print(e.message);
//       print(e.code);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<CustomerProvider>(context);
//     final loggedInUser =
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
//             "Create Post",
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
//                       height: getProportionateScreenHeight(80),
//                       width: getProportionateScreenWidth(80),
//                       child: CircleAvatar(
//                         backgroundImage: CachedNetworkImageProvider(
//                             loggedInUser.profileImageURL!),
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           loggedInUser.name!,
//                           style: Theme.of(context).textTheme.displaySmall,
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                           const Color.fromARGB(255, 255, 210, 32),
//                         ),
//                         fixedSize: MaterialStateProperty.all(
//                           Size(setWidth(5), setHeight(5)),
//                         ),
//                       ),
//                       onPressed: () async {
//                         // String imageURL = postProvider.uploadImageToStorage(
//                         //     imagePath: _imagePath,
//                         //     imageType: "posts",
//                         //     userID: loggedInUser.userID);
//                         // postProvider.uploadImageDataToFireStore(
//                         //     imageURL: imageURL,
//                         //     userID: loggedInUser.userID,
//                         //     userName: loggedInUser.name);
//                         await uploadPost();
//                         // Navigator.pop(context);
//                         // Future.delayed(const Duration(milliseconds: 0))
//                         //     .then((value) async {
//                         //   await postProvider.fetch();
//                         // });
//                       },
//                       child: const Text("Post",
//                           style:
//                               TextStyle(fontSize: 18, color: Colors.black87)),
//                     ),
//                   ],
//                 ),
//                 _selectedImageFile != null
//                     ? Stack(alignment: AlignmentDirectional.topEnd, children: [
//                         MyContainer(
//                             width: setWidth(100),
//                             height: setHeight(40),
//                             child: Image.file(_selectedImageFile!))
//                       ])
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
