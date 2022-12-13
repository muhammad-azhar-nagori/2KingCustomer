import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  List<OrdersModel> _list = [];

  List<OrdersModel> get getList => _list;

  final loggedInUser = FirebaseAuth.instance.currentUser;
  void clearList() {
    _list.clear();
  }

  Future<void> fetch() async {
    if (loggedInUser != null) {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(" " + loggedInUser!.uid)
          .collection("orderDetails")
          .get()
          .then(
            (QuerySnapshot<Map<String, dynamic>> snapshot) => {
              _list = [],
              for (var doc in snapshot.docs)
                {
                  _list.insert(
                    0,
                    OrdersModel.fromMap(map: doc.data(), orderID: doc.id),
                  ),
                },
            },
          );
      notifyListeners();
    }
  }

  List<OrdersModel> getOrderByID(String aggrementID) {
    return _list
        .where((element) => element.aggrementID!.trim() == aggrementID.trim())
        .toList();
  }
}
