import 'package:dpm_flutter/src/dpm.g.dart';
import 'package:rxdart/rxdart.dart';

abstract class IDpmController {
  Future<bool> isProfileOwnerApp();
  Future<void> createWorkProfile();
  Future<void> enableWorkProfile();
  Future<void> setSysApp(String name);
  Future<bool> screenCapturePolicy(bool disabled);
}


class DpmController implements IDpmController {
  final DpmSender _sink;

  final BehaviorSubject<bool> _poController = BehaviorSubject.seeded(false);
  final BehaviorSubject<bool> _screenCaptureController = BehaviorSubject.seeded(true);


  Stream<bool> get poStream => _poController.stream;
  Stream<bool> get screenCaptureDisabledStream => _screenCaptureController.stream;

  Function(bool) get updateUser => _poController.sink.add;
  Function(bool) get screenCaptureDisabled => _screenCaptureController.sink.add;



  DpmController() : _sink = DpmSender() {
    init();
    _screenCaptureController.listen((value) {
      if (_poController.value == true) {
        screenCapturePolicy(value);
      }
    });
  }

  init() async{
    updateUser(await isProfileOwnerApp());
  }


  @override
  Future<bool> isProfileOwnerApp() => _sink.isProfileOwnerApp();

  @override
  Future<void> createWorkProfile() => _sink.createWorkProfile();

  @override
  Future<void> enableWorkProfile() => _sink.enableWorkProfile();

  @override
  Future<void> setSysApp(String name) => _sink.setSysApp(name);

  @override
  Future<bool> screenCapturePolicy(bool disabled) async {
    return await _sink.screenCapturePolicy(disabled);
  }

}