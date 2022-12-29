import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../models/contractor_model.dart';
import 'package:path/path.dart';

class ContractorsProvider with ChangeNotifier {
  List<ContractorsModel> _list = [];

  List<ContractorsModel> get getList => _list;

  void clearList() {
    _list.clear();
    notifyListeners();
  }

  Future<void> fetch() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc("Y1DImckjzK5z2khAEi7o")
        .collection("contractors")
        .get()
        .then((QuerySnapshot snapshot) {
      _list = [];
      for (var documents in snapshot.docs) {
        Map<String, dynamic> dataMap = documents.data() as Map<String, dynamic>;
        _list.insert(
            0,
            ContractorsModel.fromMap(
                map: dataMap, userID: documents.id.trim()));
      }
    });
    notifyListeners();
  }

  ContractorsModel getUserByID(String userID) {
    return _list
        .where((element) => element.userID!.trim() == userID.trim())
        .first;
  }

  Future<void> updateRating({
    String? postID,
    List? rating,
  }) async {
    FirebaseFirestore.instance
        .collection("post")
        .doc(postID)
        .update({'rating': rating});

    notifyListeners();
  }

  Future<void> uploadUserDataToFireStore({
    String? userID,
    String? email,
    String? password,
    bool? status,
    List? rating,
    List? services,
    String? profileImageURL,
    bool? gender,
    String? name,
    String? contactNumber,
    String? cnic,
    DateTime? createdDate,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc("Y1DImckjzK5z2khAEi7o")
        .collection("contractors")
        .doc(userID)
        .set({
      "name": name,
      "email": email,
      "status": status,
      "profileImageURL": profileImageURL,
      "gender": gender,
      "cnic": cnic,
      "contactNumber": contactNumber,
      "rating": rating,
      "services": services,
      "createdDate": createdDate
    });
  }

  Future<String> uploadUserImageToStorage({
    required String? imagePath,
    required String? userID,
  }) async {
    File imageFile = File(imagePath!);

    String _imageBaseName = basename(imageFile.path);
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child("images")
        .child(userID!)
        .child("profileImg")
        .child(_imageBaseName);
    await imageReference.putFile(imageFile);
    String getImageUrl = await imageReference.getDownloadURL();
    notifyListeners();
    return getImageUrl;
  }

  Future<void> deletWorkerImageFromStorage(
      {required String? imageURL,
      required String? userID,
      required String? imageType}) async {
    String? imageName = imageURL!.split('2F')[2].split('?alt')[0];
    await FirebaseStorage.instance
        .ref()
        .child("images")
        .child(userID!)
        .child("profileImg")
        .child(imageName)
        .delete();
    notifyListeners();
  }
}
