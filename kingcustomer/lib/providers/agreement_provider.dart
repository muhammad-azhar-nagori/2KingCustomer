import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:kingcustomer/providers/customer_provider.dart';

import '../models/agreement_model.dart';

class AgreementProvider with ChangeNotifier {
  List<AgreementModel> _list = [];

  List<AgreementModel> get getList => _list;

  final loggedInUser = currentUserID;
  void clearList() {
    _list.clear();
    notifyListeners();
  }

  Future<void> fetch() async {
    if (loggedInUser != null) {
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(loggedInUser)
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

  updateStatus(String agreementID, bool status, String contractorID) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(loggedInUser)
        .collection("agreements")
        .doc(agreementID)
        .update({"status": status});
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(contractorID)
        .collection("agreements")
        .doc(agreementID)
        .update({"status": status});
    fetch();
    notifyListeners();
  }

  deleteAgreement(String agreementID) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(loggedInUser!)
        .collection("agreements")
        .doc(agreementID)
        .delete();
    notifyListeners();
  }

  AgreementModel getAgreementByID(String agreementID) {
    return _list
        .where((element) => element.agreementID!.trim() == agreementID.trim())
        .first;
  }
}
