import 'package:flutter/cupertino.dart';

class InventoryModel with ChangeNotifier {
  final String? inventoryID;
  final String? itemName;
  final String? perItem;
  final String? qty;
  final String? total;
  
  final String? logsID;
  InventoryModel({
    this.logsID,
    this.inventoryID,
    this.itemName,
    this.perItem,
    this.qty,
    this.total,
  });

  factory InventoryModel.fromMap(
      {required Map<String, dynamic> map, required String inventoryID}) {
    return InventoryModel(
      inventoryID: inventoryID,
      itemName: map["itemName"],
      perItem: map["perItem"],
      qty: map["qty"],
      total: map["total"],
      logsID: map["logsID"]
    );
  }
}
