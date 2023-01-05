import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/providers/customer_provider.dart';
import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> _list = [];

  List<ChatModel> get getList => _list;

  final loggedInUser = currentUserID;
  void clearList() {
    _list.clear();
    notifyListeners();
  }

  Future<void> fetch() async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(loggedInUser)
        .collection("with")
        .get()
        .then(
          (QuerySnapshot<Map<String, dynamic>> snapshot) => {
            _list = [],
            for (var doc in snapshot.docs)
              {
                _list.insert(
                  0,
                  ChatModel.fromMap(otherID: doc.id),
                ),
              },
          },
        );
    notifyListeners();
  }

  List<ChatModel> getChatByID(String otherID) {
    return _list
        .where((element) => element.otherID!.trim() == otherID.trim())
        .toList();
  }

  Future<void> createNewChat({
    required String? otherID,
  }) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(loggedInUser)
        .collection("with")
        .doc(otherID)
        .set({});
    _list.insert(
      0,
      ChatModel(otherID: otherID),
    );

    notifyListeners();
  }

  Future<void> createOtherChat({
    required String? otherID,
  }) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(otherID)
        .collection("with")
        .doc(loggedInUser!)
        .set({});
    notifyListeners();
  }

  Future<void> deleteChat({
    String? otherID,
  }) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(loggedInUser!)
        .collection("with")
        .doc(otherID)
        .delete();
    _list.removeWhere(
      (element) => element.otherID == otherID,
    );
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(loggedInUser)
        .collection("with")
        .doc(otherID)
        .delete();

    notifyListeners();
  }
}
