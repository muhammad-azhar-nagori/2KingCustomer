import 'package:flutter/cupertino.dart';

class LogsModel with ChangeNotifier {
  final String? logsID;
  LogsModel({
    this.logsID,
  });

  factory LogsModel.fromMap(
      {required String logsID}) {
    return LogsModel(
      logsID: logsID,
    );
  }
}
