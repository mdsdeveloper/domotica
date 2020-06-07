import 'package:flutterappdomotica/Users/api/cloud_firestore_api.dart';

import 'package:flutterappdomotica/Users/model/user_model.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(UserModel user) => _cloudFirestoreAPI.updateUserData(user);
}