
import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class DpmSender {
  bool isProfileOwnerApp();
  void createWorkProfile();
  void enableWorkProfile();
  void setSysApp(String name);
  bool screenCapturePolicy(bool disabled);
}


@FlutterApi()
abstract class DpmReceiver {

}