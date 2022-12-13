import 'package:flutter/cupertino.dart';

class OrdersModel with ChangeNotifier {
  final String? orderID;
  final String? aggrementID;
  final String? serviceTotal;
  final String? inventoryTotal;
  final String? grandTotal;
  final String? status;
  final String? logsID;
  OrdersModel({
    this.orderID,
    this.aggrementID,
    this.serviceTotal,
    this.inventoryTotal,
    this.grandTotal,
    this.status,
    this.logsID,
  });

  factory OrdersModel.fromMap(
      {required Map<String, dynamic> map, required String orderID}) {
    return OrdersModel(
      orderID: orderID,
      aggrementID: map["aggrementID"],
      serviceTotal: map["serviceTotal"],
      inventoryTotal: map["inventoryTotal"],
      grandTotal: map["grandTotal"],
      logsID: map["logsID"],
      status: map["status"],
    );
  }
}
