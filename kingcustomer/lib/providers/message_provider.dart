import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';

class MessageProvider with ChangeNotifier {
  List<MessageModel> _list = [];

  List<MessageModel> get getList => _list;
  void clearList() {
    _list.clear();
    notifyListeners();
  }

  List<MessageModel> getSortedList(String? otherID) {
    getList.sort(((a, b) => a.createdAt!.compareTo(b.createdAt!)));
    return getList
        .where((element) => element.chatWith == otherID!)
        .toList()
        .reversed
        .toList();
  }

  final loggedInUser = FirebaseAuth.instance.currentUser;
  Future<void> fetch() async {
    if (loggedInUser != null) {
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(loggedInUser!.uid)
          .collection("messages")
          .get()
          .then(
            (QuerySnapshot<Map<String, dynamic>> snapshot) => {
              _list = [],
              for (var doc in snapshot.docs)
                {
                  _list.insert(
                    0,
                    MessageModel.fromMap(map: doc.data(), messageID: doc.id),
                  ),
                },
            },
          );
      notifyListeners();
    }
  }

  Future<void> uploadMessageDataToFireStore({
    bool? type,
    String? chatWith,
    String? messagetxt,
    String? agreementID,
    DateTime? createdAt,
  }) async {
    DocumentReference<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection("chats")
        .doc(loggedInUser!.uid)
        .collection("messages")
        .add({
      "with": chatWith,
      "type": type,
      "text": messagetxt,
      "createdAt": createdAt,
      "agreementID": agreementID,
    });
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatWith)
        .collection("messages")
        .add({
      "with": loggedInUser!.uid,
      "type": type == true ? false : true,
      "text": messagetxt,
      "createdAt": createdAt,
      "agreementID": agreementID,
    });
    _list.insert(
      0,
      MessageModel(
        chatWith: chatWith,
        createdAt: createdAt,
        messageID: doc.id,
        messageTxt: messagetxt,
        type: type,
        agreementID: agreementID,
      ),
    );
    notifyListeners();
  }

  Future<void> deleteMessage({
    required String? messageID,
    required String? messagetxt,
  }) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(loggedInUser!.uid)
        .collection("messages")
        .doc(messageID)
        .delete();

    _list.removeWhere(
      (element) => element.messageTxt == messagetxt,
    );
    notifyListeners();
  }

  Future<void> deleteAllMessages({
    required String? otherID,
  }) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(loggedInUser!.uid)
        .collection("messages")
        .where('with', isEqualTo: otherID)
        .get()
        .then(
      (QuerySnapshot<Map<String, dynamic>> snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      },
    );

    _list.removeWhere(
      (element) => element.chatWith == otherID,
    );
    notifyListeners();
  }
}
