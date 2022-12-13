import 'package:flutter/cupertino.dart';

class PostModel with ChangeNotifier {
  final String? userID;
  final String? postID;
  final String? imageURL;
  final DateTime? postedTime;
  final String? userName;
  final String? caption;
  final List? comments;
  final List? likes;
  PostModel(
      {this.comments,
      this.likes,
      this.userID,
      this.postID,
      this.imageURL,
      this.postedTime,
      this.userName,
      this.caption});

  factory PostModel.fromMap(
      {required Map<String, dynamic> map, required String postID}) {
    return PostModel(
        postID: postID,
        userID: map["userID"],
        postedTime: map["date"].toDate(),
        imageURL: map["imgVideo"],
        userName: map["userName"],
        caption: map["caption"],
        likes: map["likes"],
        comments: map["comments"]);
  }
}
