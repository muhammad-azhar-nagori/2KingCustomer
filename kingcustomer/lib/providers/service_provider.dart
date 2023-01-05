import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../models/service_model.dart';

class ServiceProvider with ChangeNotifier {
  List<ServiceModel> _list = [];

  List<ServiceModel> get getList => _list;
  void clearList() {
    _list.clear();
    notifyListeners();
  }

  Future<void> fetch() async {
    await FirebaseFirestore.instance.collection("c_services").get().then(
          (QuerySnapshot<Map<String, dynamic>> snapshot) => {
            _list = [],
            for (var doc in snapshot.docs)
              {
                _list.insert(
                  0,
                  ServiceModel.fromMap(map: doc.data(), serviceID: doc.id),
                ),
              },
          },
        );
    notifyListeners();
  }
}
