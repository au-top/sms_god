import 'package:flutter/material.dart';

class DataListen extends StatefulWidget {
  final List<ChangeNotifier> changeNotifiers;
  final WidgetBuilder builder;

  const DataListen({
    Key? key,
    required this.changeNotifiers,
    required this.builder,
  }) : super(key: key);

  @override
  _DataListenState createState() => _DataListenState();
}

class _DataListenState extends State<DataListen> {
  void update() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (var element in widget.changeNotifiers) {
      element.addListener(update);
    }
  }

  @override
  void dispose() {
    for (var element in widget.changeNotifiers) {
      element.removeListener(update);
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DataListen oldWidget) {
    for (var element in oldWidget.changeNotifiers) {
      element.removeListener(update);
    }
    for (var element in widget.changeNotifiers) {
      element.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
