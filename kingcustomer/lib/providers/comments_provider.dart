import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/comments_model.dart';

class CommentsProvider with ChangeNotifier {
  List<CommentsModel> _list = [];

  List<CommentsModel> get getList => _list;

  Future<void> fetch() async {
    await FirebaseFirestore.instance.collection("comments").get().then(
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

  List<CommentsModel> getCommentByPostID(String postID) {
    List<CommentsModel> _newlist = [];
    for (var element in _list) {
      if (element.postID == postID) {
        _newlist.add(element);
      }
    }
    return _newlist;
  }

  Future<void> uploadCommentDataToFireStore(
      {required String userID,
      required String? text,
      required String postID}) async {
    DocumentReference<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection("comments").add({
      "userID": userID,
      "text": text,
      "postID": postID,
    });
    _list.insert(
      0,
      CommentsModel(commentID: doc.id, userID: userID, text: text),
    );
    notifyListeners();
  }
}
