import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/logs_model.dart';

class LogsProvider with ChangeNotifier {
  List<LogsModel> _list = [];

  List<LogsModel> get getList => _list;

  final loggedInUser = FirebaseAuth.instance.currentUser;
  void clearList() {
    _list.clear();
  }

  Future<void> fetch() async {
    if (loggedInUser != null) {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(" " + loggedInUser!.uid)
          .collection("logs")
          .get()
          .then(
            (QuerySnapshot<Map<String, dynamic>> snapshot) => {
              _list = [],
              for (var doc in snapshot.docs)
                {
                  _list.insert(
                    0,
                    LogsModel.fromMap(logsID: doc.id),
                  ),
                },
            },
          );
      notifyListeners();
    }
  }

  Future<void> createLog() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(" " + loggedInUser!.uid)
        .collection("logs")
        .add({});
    
  }
}
