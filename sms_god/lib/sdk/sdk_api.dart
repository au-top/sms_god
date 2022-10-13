import 'package:sms_god/model/app_config.dart';
import 'package:telephony/telephony.dart';

abstract class SdkApi {
  Future onMessage(SmsMessage message, {required AppConfig appConfig});
}
