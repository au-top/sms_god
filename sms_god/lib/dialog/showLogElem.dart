import 'package:flutter/material.dart';
import 'package:sms_god/state/local/log.dart';

class LogListView extends StatefulWidget {
  final SMSLog smsLog;
  const LogListView({Key? key, required this.smsLog}) : super(key: key);

  @override
  _LogListViewState createState() => _LogListViewState();
}

class _LogListViewState extends State<LogListView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.smsLog,
      builder: (context, child) => ListView.builder(
        itemBuilder: ((context, index) {
          final logElem = widget.smsLog.logs[index];
          return ListTile(
            leading: Text(logElem.level.name),
            title: Text(logElem.origin),
            subtitle: Text(logElem.content, style: const TextStyle(overflow: TextOverflow.ellipsis)),
            onTap: () {
              showLogElemDialog(context, logElem);
            },
          );
        }),
        itemCount: widget.smsLog.logs.length,
      ),
    );
  }
}

Future showLogElemDialog(BuildContext context, LogElem logElem) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(logElem.level.name),
              Text(logElem.origin),
              Text(logElem.logDateTime.toString()),
              Text(logElem.content),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        ),
      );
    },
  );
}
