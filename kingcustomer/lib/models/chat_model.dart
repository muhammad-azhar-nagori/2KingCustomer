import 'package:flutter/cupertino.dart';

class ChatModel with ChangeNotifier {
  final String? otherID;
  factory ChatModel.fromMap({required String otherID}) {
    return ChatModel(otherID: otherID);
  }

  ChatModel({
    this.otherID,
  });
}
