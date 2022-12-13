import 'package:flutter/cupertino.dart';

class StoryModel with ChangeNotifier {
  final String? userID;
  final String? storyID;
  final String? imageURL;
  final DateTime? postedTime;
  final String? userName;
  final String? caption;
  StoryModel(
      {this.userID,
      this.storyID,
      this.imageURL,
      this.postedTime,
      this.userName,
      this.caption});

  factory StoryModel.fromMap(
      {required Map<String, dynamic> map, required String storyID}) {
    return StoryModel(
        storyID: storyID,
        userID: map["userID"],
        postedTime: map["date"].toDate(),
        imageURL: map["imgVideo"],
        userName: map["userName"],
        caption: map["caption"]);
  }
}
