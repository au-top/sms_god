import 'package:flutter/material.dart';

enum LogElemLevel { serious, commonly, details }

class LogElem {
  Enum level;
  String origin;
  String content;
  late DateTime logDateTime;
  LogElem({required this.level, required this.content, required this.origin, DateTime? logDateTime}) {
    this.logDateTime = logDateTime ?? DateTime.now();
  }
}

class SMSLog extends ChangeNotifier {
  final List<LogElem> logs = [];

  SMSLog();
  add(LogElem logElem) {
    logs.add(logElem);
    asyncNotifyListeners();
  }

  Future asyncNotifyListeners() {
    return Future(() {
      notifyListeners();
    });
  }
}
