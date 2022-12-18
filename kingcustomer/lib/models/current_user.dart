// import 'package:flutter/material.dart';

// class CustomerModel with ChangeNotifier {
//   final String? userID;
//   final String? email;
//   final bool? status;
//   final List? rating;
//   final List? services;
//   final String? profileImageURL;
//   final bool? gender;
//   final String? name;
//   final String? contactNumber;
//   final String? cnic;
//   final DateTime? createdDate;
//   CustomerModel({
//     this.cnic,
//     this.status,
//     this.createdDate,
//     this.userID,
//     this.name,
//     this.email,
//     this.rating,
//     this.services,
//     this.profileImageURL,
//     this.gender,
//     this.contactNumber,
//   });
//   factory CustomerModel.fromMap(
//       {required Map<String, dynamic> map, required String userID}) {
//     return CustomerModel(
//       userID: userID,
//       cnic: map["cnic"],
//       name: map["name"],
//       email: map["email"],
//       rating: map["rating"],
//       services: map["services"],
//       profileImageURL: map["profileImageURL"],
//       gender: map["gender"],
//       contactNumber: map["contactNumber"],
//       status: map["status"],
//       createdDate: map["createdDate"].toDate(),
//     );
//   }
// }
