import 'package:flutter/cupertino.dart';

class CommentsModel with ChangeNotifier {
  final String? commentID;
  final String? userID;
  final String? text;

  factory CommentsModel.fromMap(
      {required Map<String, dynamic> map, required String commentID}) {
    return CommentsModel(
      commentID: commentID,
      userID: map["userID"],
      text: map["text"],
    );
  }

  CommentsModel({
    this.commentID,
    this.userID,
    this.text,
  });
}
