import 'package:telephony/telephony.dart';

abstract class SMSCenter {
  static onMessage(SmsMessage message) async {}

  static onMessageBackground(SmsMessage message) async {}
}
