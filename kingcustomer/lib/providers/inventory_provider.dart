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

  Future<void> fetchInventory() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(" " + loggedInUser!.uid)
        .collection("logs")
        .doc("M4XynyYl03rreQUdtwg6")
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
    notifyListeners();
  }

  Future<void> uploadItemDataToFireStore({
    String? itemName,
    String? qty,
    String? total,
    String? perItem,
  }) async {
    DocumentReference<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection("orders")
        .doc(" " + loggedInUser!.uid)
        .collection("logs")
        .doc("M4XynyYl03rreQUdtwg6")
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
          total: total),
    );
    notifyListeners();
  }

  Future<void> deleteItem({
    required String? inventoryID,
  }) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(" " + loggedInUser!.uid)
        .collection("logs")
        .doc("M4XynyYl03rreQUdtwg6")
        .collection("inventory")
        .doc(inventoryID)
        .delete();

    _list.removeWhere(
      (element) => element.inventoryID == inventoryID,
    );
    notifyListeners();
  }

  InventoryModel getInventoryByID(String logsID) {
    return _list
        .where((element) => element.inventoryID!.trim() == logsID.trim())
        .first;
  }
}
