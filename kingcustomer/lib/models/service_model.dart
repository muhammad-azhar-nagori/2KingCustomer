import 'package:flutter/cupertino.dart';

class ServiceModel with ChangeNotifier {
  final String? serviceID;
  final String? serviceimageURL;
  final String? serviceName;
  final bool? serviceCategroy;

  ServiceModel({
    this.serviceCategroy,
    this.serviceID,
    this.serviceimageURL,
    this.serviceName,
  });

  factory ServiceModel.fromMap(
      {required Map<String, dynamic> map, required String serviceID}) {
    return ServiceModel(
      serviceID: serviceID,
      serviceimageURL: map["service_img"],
      serviceName: map["service_name"],
      serviceCategroy: map["service_category"],
    );
  }
}
