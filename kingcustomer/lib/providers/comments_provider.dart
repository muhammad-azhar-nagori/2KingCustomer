import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/comments_model.dart';

class CommentsProvider with ChangeNotifier {
  List<CommentsModel> _list = [];

  List<CommentsModel> get getList => _list;

  Future<void> fetch(String postID) async {
    await FirebaseFirestore.instance
        .collection("post")
        .doc(postID)
        .collection("comments")
        .get()
        .then(
          (QuerySnapshot<Map<String, dynamic>> snapshot) => {
            _list = [],
            for (var doc in snapshot.docs)
              {
                _list.insert(
                  0,
                  CommentsModel.fromMap(map: doc.data(), commentID: doc.id),
                ),
              },
          },
        );
    notifyListeners();
  }

  Future<void> uploadPostDataToFireStore(
      {required String userID,
      required String? text,
      required String from}) async {
    DocumentReference<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection("post").add({
      "userID": userID,
      "text": text,
      "from": from,
    });
    _list.insert(
      0,
      CommentsModel(commentID: doc.id, userID: userID, text: text),
    );
    notifyListeners();
  }

  Future<void> updateLikes({
    String? postID,
    List? likes,
  }) async {
    FirebaseFirestore.instance
        .collection("post")
        .doc(postID)
        .update({'likes': likes});

    notifyListeners();
  }

  // Future<String> uploadImageToStorage(
  //     {required String? imagePath,
  //     required String? userID,
  //     required String? imageType}) async {
  //   File imageFile = File(imagePath!);

  //   String _imageBaseName = basename(imageFile.path);
  //   Reference imageReference = FirebaseStorage.instance
  //       .ref()
  //       .child("images")
  //       .child(userID!)
  //       .child(imageType!)
  //       .child(_imageBaseName);
  //   await imageReference.putFile(imageFile);
  //   String getImageUrl = await imageReference.getDownloadURL();
  //   notifyListeners();
  //   return getImageUrl;
  // }

  // Future<void> deleteImageFromStorage(
  //     {required String? imageURL,
  //     required String? userID,
  //     required String? imageType}) async {
  //   String? imageName = imageURL!.split('2F')[2].split('?alt')[0];
  //   await FirebaseStorage.instance
  //       .ref()
  //       .child("images")
  //       .child(userID!)
  //       .child(imageType!)
  //       .child(imageName)
  //       .delete();
  //   notifyListeners();
  // }
}
