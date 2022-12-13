import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kingcustomer/models/story_model.dart';

class StoryProvider with ChangeNotifier {
  List<StoryModel> _list = [];

  List<StoryModel> get getList => _list;

  Future<void> fetch() async {
    await FirebaseFirestore.instance.collection("stories").get().then(
          (QuerySnapshot<Map<String, dynamic>> snapshot) => {
            _list = [],
            for (var doc in snapshot.docs)
              {
                _list.insert(
                  0,
                  StoryModel.fromMap(map: doc.data(), storyID: doc.id),
                ),
              },
          },
        );
    notifyListeners();
  }

  List<StoryModel> getStoryByID(String userID) {
    return _list.where((element) => element.userID!.trim() == userID).toList();
  }

  Future<void> uploadImageDataToFireStore(
      {String? userID,
      String? imageURL,
      String? userName,
      String? caption = ""}) async {
    await FirebaseFirestore.instance.collection("stories").add({
      "imgVideo": imageURL,
      "userName": userName,
      "userID": userID,
      "date": DateTime.now(),
      "caption": caption,
    });
  }

  Future<String?> uploadImageToStorage({
    required String? imagePath,
    required String? userID,
  }) async {
    File imageFile = File(imagePath!);

    String _imageBaseName = basename(imageFile.path);
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child("images")
        .child(userID!)
        .child("Stories")
        .child(_imageBaseName);
    await imageReference.putFile(imageFile);
    String getImageUrl = await imageReference.getDownloadURL();
    notifyListeners();
    return getImageUrl;
  }

  Future<void> deleteImageFromStorage({
    required String? imageURL,
    required String? userID,
  }) async {
    String? imageName = imageURL!.split('2F')[2].split('?alt')[0];
    await FirebaseStorage.instance
        .ref()
        .child("images")
        .child(userID!)
        .child("Stories")
        .child(imageName)
        .delete();
    notifyListeners();
  }
}
