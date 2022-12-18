import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/agreement_model.dart';

class AgreementProvider with ChangeNotifier {
  List<AgreementModel> _list = [];

  List<AgreementModel> get getList => _list;

  final loggedInUser = FirebaseAuth.instance.currentUser;
  void clearList() {
    _list.clear();
  }

  Future<void> fetch() async {
    if (loggedInUser != null) {
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(loggedInUser!.uid)
          .collection("agreements")
          .get()
          .then(
            (QuerySnapshot<Map<String, dynamic>> snapshot) => {
              _list = [],
              for (var doc in snapshot.docs)
                {
                  _list.insert(
                    0,
                    AgreementModel.fromMap(
                        map: doc.data(), aggrementID: doc.id),
                  ),
                },
            },
          );
      notifyListeners();
    }
  }

  AgreementModel getAgreementByID(String agreementID) {
    return _list
        .where((element) => element.agreementID!.trim() == agreementID.trim())
        .first;
  }
}
