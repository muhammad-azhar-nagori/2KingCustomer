import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingcustomer/models/service_log_model.dart';

class ServiceLogsProvider with ChangeNotifier {
  final loggedInUser = FirebaseAuth.instance.currentUser;
  List<ServiceLogModel> _servicelist = [];

  List<ServiceLogModel> get getServicelist => _servicelist;
  void clearList() {
    _servicelist.clear();
    notifyListeners();
  }

  Future<void> fetchServiceLog(String logsID) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(loggedInUser!.uid)
        .collection("logs")
        .doc(logsID)
        .collection("services")
        .get()
        .then(
          (QuerySnapshot<Map<String, dynamic>> snapshot) => {
            _servicelist = [],
            for (var doc in snapshot.docs)
              {
                _servicelist.insert(
                  0,
                  ServiceLogModel.fromMap(map: doc.data(), serviceID: doc.id),
                ),
              },
          },
        );
    _servicelist.removeLast();
    notifyListeners();
  }

  Future<void> uploadItemDataToFireStore({
    String? serviceName,
    String? noOfDays,
    String? total,
    String? perDay,
    String? logsID,
    String? contractorID,
  }) async {
    DocumentReference<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection("orders")
        .doc(loggedInUser!.uid)
        .collection("logs")
        .doc(logsID)
        .collection("services")
        .add({
      "serviceName": serviceName,
      "noOfDays": noOfDays,
      "total": total,
      "perDay": perDay,
    });
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(contractorID!)
        .collection("logs")
        .doc(logsID)
        .collection("services")
        .add({
      "serviceName": serviceName,
      "noOfDays": noOfDays,
      "total": total,
      "perDay": perDay,
    });
    _servicelist.insert(
      0,
      ServiceLogModel(
        serviceID: doc.id,
        serviceName: serviceName,
        perDay: perDay,
        noOfDays: noOfDays,
        total: total,
      ),
    );
    _servicelist.removeWhere((element) =>
        element.serviceName == "" &&
        element.total == "" &&
        element.perDay == "" &&
        element.noOfDays == "");
    notifyListeners();
  }

  String serviceTotal() {
    double _sumofService = 0;
    for (var element in _servicelist) {
      _sumofService += double.parse(element.total!);
    }
    return _sumofService.toString();
  }

  List<ServiceLogModel> getserviceByServiceID(String serviceLogID) {
    return _servicelist
        .where((element) => element.serviceID!.trim() == serviceLogID.trim())
        .toList();
  }
}
