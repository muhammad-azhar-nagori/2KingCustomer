import 'package:flutter/cupertino.dart';

class ServiceLogModel with ChangeNotifier {
  final String? serviceID;
  final String? serviceName;
  final String? perDay;
  final String? noOfDays;
  final String? total;
  final String? logsID;
  ServiceLogModel({
    this.serviceID,
    this.logsID,
    this.serviceName,
    this.perDay,
    this.noOfDays,
    this.total,
  });

  factory ServiceLogModel.fromMap(
      {required Map<String, dynamic> map, required String serviceID}) {
    return ServiceLogModel(
      serviceID: serviceID,
      serviceName: map["serviceName"],
      perDay: map["perDay"],
      noOfDays: map["noOfDays"],
      total: map["total"],
      logsID: map["logsID"],
    );
  }
}
