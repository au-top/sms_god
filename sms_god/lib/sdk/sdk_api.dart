import 'package:telephony/telephony.dart';

abstract class SdkApi {
  Future onMessage(SmsMessage message);
}
