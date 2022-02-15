import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:sms_center/router.dart';

void main(List<String> arguments) async {
  final server = await shelf_io.serve(AppRouter.start, '0.0.0.0', 7676);
}
