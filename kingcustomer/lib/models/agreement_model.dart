import 'package:flutter/material.dart';

class AgreementModel with ChangeNotifier {
  final String? agreementID;
  final String? contractorID;
  final String? customerID;

  final DateTime? startDate;
  final List? services;
  final DateTime? endDate;

  final String? details;
  final bool? status;
  AgreementModel({
    this.details,
    this.agreementID,
    this.contractorID,
    this.customerID,
    this.startDate,
    this.services,
    this.endDate,
    this.status,
  });
  factory AgreementModel.fromMap(
      {required Map<String, dynamic> map, required String aggrementID}) {
    return AgreementModel(
      agreementID: aggrementID,
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
