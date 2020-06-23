import 'file:///C:/Users/guill/AndroidStudioProjects/flutter_app_domotica/lib/Devices/model/device_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterappdomotica/Users/repository/cloud_firestore_repository.dart';
import 'package:rxdart/rxdart.dart';

class DevicesBloc {
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  final _devicesController = BehaviorSubject<DeviceModel>();

  Stream<QuerySnapshot> allDevicesListStreamByRoomName(String roomName) => _cloudFirestoreRepository.getAllDevices(roomName);

  void changeStatusValue(String deviceUID, bool status) => _cloudFirestoreRepository.changeStatusValue(deviceUID, status);

  void changeDeviceValue(String deviceUID, int value) => _cloudFirestoreRepository.changeDeviceValue(deviceUID, value);

  dispose() {
    _devicesController?.close();
  }
}
