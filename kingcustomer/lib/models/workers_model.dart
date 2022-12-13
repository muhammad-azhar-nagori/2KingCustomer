import 'package:flutter/material.dart';

class WorkerModel with ChangeNotifier {
  final String? userID;
  final bool? status;
  final String? profileImg;
  final String? number;
  final String? name;
  final bool? gender;
  final String? experience;
  final String? email;
  final String? cnic;
  final String? service;
  WorkerModel({
    this.userID,
    this.status,
    this.profileImg,
    this.number,
    this.name,
    this.gender,
    this.experience,
    this.email,
    this.cnic,
    this.service,
  });
  factory WorkerModel.fromMap(
      {required Map<String, dynamic> map, required String userID}) {
    return WorkerModel(
      userID: userID,
      name: map["worker_name"],
      email: map["worker_email"],
      status: map["worker_status"],
      profileImg: map["worker_profile_img"],
      gender: map["worker_gender"],
      experience: map["worker_experience"],
      cnic: map["worker_CNIC"],
      number: map["worker_number"],
      service: map["worker_service"],
    );
  }
}
