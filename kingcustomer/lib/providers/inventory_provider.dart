import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/inventory_model.dart';

class InventoryProvider with ChangeNotifier {
  final loggedInUser = FirebaseAuth.instance.currentUser;
  List<InventoryModel> _list = [];
  List<InventoryModel> get getInventoryList => _list;
  void clearList() {
    _list.clear();
    notifyListeners();
  }

  Future<void> fetchInventory(String logsID) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(loggedInUser!.uid)
        .collection("logs")
        .doc(logsID)
        .collection("inventory")
        .get()
        .then(
          (QuerySnapshot<Map<String, dynamic>> snapshot) => {
            _list = [],
            for (var doc in snapshot.docs)
              {
                _list.insert(
                  0,
                  InventoryModel.fromMap(map: doc.data(), inventoryID: doc.id),
                ),
              },
          },
        );
    _list.removeLast();
    notifyListeners();
  }

  Future<void> uploadItemDataToFireStore(
      {String? itemName,
      String? qty,
      String? total,
      String? perItem,
      String? logsID,
      String? contractorID}) async {
    DocumentReference<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection("orders")
        .doc(loggedInUser!.uid)
        .collection("logs")
        .doc(logsID)
        .collection("inventory")
        .add({
      "itemName": itemName,
      "qty": qty,
      "total": total,
      "perItem": perItem,
    });
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(contractorID!)
        .collection("logs")
        .doc(logsID)
        .collection("inventory")
        .add({
      "itemName": itemName,
      "qty": qty,
      "total": total,
      "perItem": perItem,
    });
    _list.insert(
      0,
      InventoryModel(
        inventoryID: doc.id,
        itemName: itemName,
        perItem: perItem,
        qty: qty,
        total: total,
      ),
    );
    _list.removeWhere((element) =>
        element.itemName == "" &&
        element.total == "" &&
        element.qty == "" &&
        element.perItem == "");
    notifyListeners();
  }

  String inventoryTotal() {
    double _sumOfInventory = 0;
    for (var element in _list) {
      _sumOfInventory += double.parse(element.total!);
    }
    return _sumOfInventory.toString();
  }

  Future<void> deleteItem(
      {required String inventoryID, required String logsID}) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(loggedInUser!.uid)
        .collection("logs")
        .doc(logsID)
        .collection("inventory")
        .doc(inventoryID)
        .delete();

    _list.removeWhere(
      (element) => element.inventoryID == inventoryID,
    );
    notifyListeners();
  }

  InventoryModel getInventoryByID(String inventoryID) {
    return _list
        .where((element) => element.inventoryID!.trim() == inventoryID.trim())
        .first;
  }
}
