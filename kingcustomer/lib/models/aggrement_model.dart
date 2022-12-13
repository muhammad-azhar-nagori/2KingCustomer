import 'package:flutter/material.dart';

class AggrementModel with ChangeNotifier {
  final String? aggrementID;
  final String? contractorID;
  final String? customerID;

  final DateTime? startDate;
  final Map<String, dynamic>? services;
  final DateTime? endDate;

  final String? details;
  final bool? status;
  AggrementModel({
    this.details,
    this.aggrementID,
    this.contractorID,
    this.customerID,
    this.startDate,
    this.services,
    this.endDate,
    this.status,
  });
  factory AggrementModel.fromMap(
      {required Map<String, dynamic> map, required String aggrementID}) {
    return AggrementModel(
      aggrementID: aggrementID,
      contractorID: map["contractorID"],
      customerID: map["customerID"],
      services: map["services"],
      startDate: map["startDate"].toDate(),
      endDate: map["endDate"].toDate(),
      status: map["status"],
      details: map["details"],
    );
  }
}
