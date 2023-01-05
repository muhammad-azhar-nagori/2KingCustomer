// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:path/path.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import '../models/workers_model.dart';

// class WorkerProvider with ChangeNotifier {
//   List<WorkerModel> _list = [];

//   List<WorkerModel> get getList => _list;
//   String? userID = FirebaseAuth.instance.currentUser?.uid;
//   void clearList() {
//     _list.clear();
//     notifyListeners();
//   }

//   Future<void> fetch() async {
//     if (userID != null) {
//       await FirebaseFirestore.instance
//           .collection("c_workers")
//           .where("userID", isEqualTo: userID!.trim())
//           .get()
//           .then(
//             (QuerySnapshot<Map<String, dynamic>> snapshot) => {
//               _list = [],
//               for (var doc in snapshot.docs)
//                 {
//                   _list.insert(
//                     0,
//                     WorkerModel.fromMap(map: doc.data(), userID: doc.id),
//                   ),
//                 },
//             },
//           );
//       notifyListeners();
//     }
//   }

//   List<WorkerModel> getWorkerByserviceName(String serviceName) {
//     return _list
//         .where((element) => element.service!.trim() == serviceName)
//         .toList();
//   }

//   Future<void> uploadWorkerDataToFireStore({
//     String? userID,
//     bool? status,
//     String? profileImg,
//     String? number,
//     String? name,
//     bool? gender,
//     String? experience,
//     String? email,
//     String? cnic,
//     String? service,
//   }) async {
//     await FirebaseFirestore.instance.collection("c_workers").add({
//       "worker_name": name,
//       "worker_email": email,
//       "worker_status": status,
//       "worker_profile_img": profileImg,
//       "worker_gender": gender,
//       "worker_experience": experience,
//       "worker_CNIC": cnic,
//       "worker_number": number,
//       "worker_service": service,
//       "userID": userID
//     });
//   }

//   Future<String> uploadWorkerImageToStorage({
//     required String? imagePath,
//     required String? userID,
//   }) async {
//     File imageFile = File(imagePath!);

//     String _imageBaseName = basename(imageFile.path);
//     Reference imageReference = FirebaseStorage.instance
//         .ref()
//         .child("images")
//         .child(userID!)
//         .child("workersImages")
//         .child(_imageBaseName);
//     await imageReference.putFile(imageFile);
//     String getImageUrl = await imageReference.getDownloadURL();
//     notifyListeners();
//     return getImageUrl;
//   }

//   Future<void> deletWorkerImageFromStorage(
//       {required String? imageURL,
//       required String? userID,
//       required String? imageType}) async {
//     String? imageName = imageURL!.split('2F')[2].split('?alt')[0];
//     await FirebaseStorage.instance
//         .ref()
//         .child("images")
//         .child(userID!)
//         .child("workersImages")
//         .child(imageName)
//         .delete();
//     notifyListeners();
//   }
// }
