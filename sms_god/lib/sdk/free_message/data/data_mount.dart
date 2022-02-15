import 'package:flutter/material.dart';
import 'package:sms_god/sdk/free_message/future_state.dart';

typedef FutureWidgetErrorBuilder = Widget Function(Object? error, StackTrace? stackTrace);

class FutureDataMount<T extends FutureState> extends StatelessWidget {
  final T data;
  final WidgetBuilder builder;
  final FutureWidgetErrorBuilder? errorBuilder;
  final WidgetBuilder? loadBuilder;

  const FutureDataMount({Key? key, required this.data, required this.builder, this.errorBuilder, this.loadBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data.initState,
      builder: (context, futureState) {
        if (futureState.hasError) {
          print(futureState.error);
          print(futureState.stackTrace);
          return errorBuilder == null ? const Center(child: Icon(Icons.error_outline_rounded)) : errorBuilder!(futureState.error, futureState.stackTrace);
        }
        if (futureState.connectionState != ConnectionState.done) {
          return loadBuilder == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : loadBuilder!(context);
        }
        return builder(context);
      },
    );
  }

  static of<T extends FutureState>(BuildContext context) {
    return context.findAncestorWidgetOfExactType<FutureDataMount<T>>();
  }
}
