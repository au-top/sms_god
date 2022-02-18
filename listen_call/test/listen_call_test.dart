import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listen_call/listen_call.dart';

void main() {
  const MethodChannel channel = MethodChannel('listen_call');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ListenCall.platformVersion, '42');
  });
}
