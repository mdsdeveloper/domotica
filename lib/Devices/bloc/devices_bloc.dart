import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterappdomotica/Devices/model/device_model.dart';
import 'package:flutterappdomotica/Users/repository/cloud_firestore_repository.dart';
import 'package:rxdart/rxdart.dart';

class DevicesBloc {
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  final _devicesController = BehaviorSubject<DeviceModel>();

  Stream<QuerySnapshot> allDevicesListStreamByRoomName(String roomName) => _cloudFirestoreRepository.getAllDevices(roomName);

  void changeDeviceModel(DeviceModel deviceModel) {
    _devicesController.sink.add(deviceModel);
  }

  Stream<DeviceModel> get deviceStream => _devicesController.stream;

  void changeStatusValue(String deviceUID, bool status) {
    _cloudFirestoreRepository.changeStatusValue(deviceUID, status);
  }

  void changeDeviceValue(String deviceUID, int value) => _cloudFirestoreRepository.changeDeviceValue(deviceUID, value);

  dispose() {
    _devicesController?.close();
  }
}
