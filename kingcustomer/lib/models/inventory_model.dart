import 'package:flutter/cupertino.dart';

class InventoryModel with ChangeNotifier {
  final String? inventoryID;
  final String? itemName;
  final String? perItem;
  final String? qty;
  final String? total;
  InventoryModel({
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
    );
  }
}
