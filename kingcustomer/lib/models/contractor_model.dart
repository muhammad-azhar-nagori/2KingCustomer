import 'package:flutter/material.dart';

class ContractorsModel with ChangeNotifier {
  final String? userID;
  final String? email;
  final String? password;
  final bool? status;
  final List? rating;
  final List? services;
  final String? profileImageURL;
  final bool? gender;
  final String? name;
  final String? contactNumber;
  final String? cnic;
  final DateTime? createdDate;
  ContractorsModel({
    this.cnic,
    this.status,
    this.createdDate,
    this.userID,
    this.name,
    this.email,
    this.password,
    this.rating,
    this.services,
    this.profileImageURL,
    this.gender,
    this.contactNumber,
  });
  factory ContractorsModel.fromMap(
      {required Map<String, dynamic> map, required String userID}) {
    return ContractorsModel(
      userID: userID,
      cnic: map["cnic"],
      name: map["name"],
      email: map["email"],
      rating: map["rating"],
      services: map["services"],
      profileImageURL: map["profileImageURL"],
      gender: map["gender"],
      contactNumber: map["contactNumber"],
      password: map["password"],
      status: map["status"],
      createdDate: map["createdDate"].toDate(),
    );
  }
}
