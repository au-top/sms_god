import 'package:flutter/material.dart';

class DataPacker<T> extends StatelessWidget {
  final T data;
  final Widget child;

  const DataPacker({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: child,
    );
  }
}
