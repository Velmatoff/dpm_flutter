
import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class DpmSender {
  bool isProfileOwnerApp();
}


@FlutterApi()
abstract class DpmReceiver {

}