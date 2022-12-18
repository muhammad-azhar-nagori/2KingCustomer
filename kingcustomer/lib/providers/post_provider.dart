import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kingcustomer/models/post_model.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> _list = [];

  List<PostModel> get getList => _list;

  Future<void> fetch() async {
    await FirebaseFirestore.instance.collection("c_post").get().then(
          (QuerySnapshot<Map<String, dynamic>> snapshot) => {
            _list = [],
            for (var doc in snapshot.docs)
              {
                _list.insert(
                  0,
                  PostModel.fromMap(map: doc.data(), postID: doc.id),
                ),
              },
          },
        );
    notifyListeners();
  }

  List<PostModel> getPostByID(String userID) {
    getList.sort(((a, b) => a.postedTime!.compareTo(b.postedTime!)));
    return getList.where((element) => element.userID == userID).toList();
  }

  Future<void> uploadPostDataToFireStore({
    String? userID,
    String? imageURL,
    String? userName,
    String? caption = "",
    DateTime? date,
  }) async {
    DocumentReference<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection("c_post").add({
      "imgVideo": imageURL,
      "userName": userName,
      "userID": userID,
      "date": date,
      "comments": [],
      "likes": [],
      "caption": caption,
    });
    _list.insert(
      0,
      PostModel(
        imageURL: imageURL,
        caption: caption,
        postedTime: date,
        postID: doc.id,
        userID: userID,
        userName: userName,
      ),
    );
    notifyListeners();
  }

  Future<void> updateLikes({
    String? postID,
    List? likes,
  }) async {
    FirebaseFirestore.instance
        .collection("c_post")
        .doc(postID)
        .update({'likes': likes});

    notifyListeners();
  }

  Future<String> uploadImageToStorage(
      {required String? imagePath,
      required String? userID,
      required String? imageType}) async {
    File imageFile = File(imagePath!);

    String _imageBaseName = basename(imageFile.path);
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child("images")
        .child(userID!)
        .child(imageType!)
        .child(_imageBaseName);
    await imageReference.putFile(imageFile);
    String getImageUrl = await imageReference.getDownloadURL();
    notifyListeners();
    return getImageUrl;
  }

  Future<void> deleteImageFromStorage(
      {required String? imageURL,
      required String? userID,
      required String? imageType}) async {
    String? imageName = imageURL!.split('2F')[2].split('?alt')[0];
    await FirebaseStorage.instance
        .ref()
        .child("images")
        .child(userID!)
        .child(imageType!)
        .child(imageName)
        .delete();
    notifyListeners();
  }
}
