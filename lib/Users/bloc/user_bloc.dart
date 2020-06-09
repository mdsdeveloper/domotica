import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterappdomotica/Users/model/user_model.dart';
import 'package:flutterappdomotica/Users/repository/cloud_firestore_repository.dart';
import 'package:flutterappdomotica/Users/service/user_service.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _userController = BehaviorSubject<FirebaseUser>();
  final UserService _userService = UserService();
  final _cloudFirestoreRepository = CloudFirestoreRepository();


  // Recuperar los datos del Stream
  Stream<FirebaseUser> get userStream => _userController.stream;
  // Insertar valores al Stream
  Function(FirebaseUser) get changeUser => _userController.sink.add;
  // Obtener el último valor ingresado a los streams
  Stream<FirebaseUser> get authStatus => FirebaseAuth.instance.onAuthStateChanged;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();


  createUser(BuildContext context, String email, String password) async {
    FirebaseUser user = await _userService.createUser(context, email, password);
    _userController.sink.add(user);
//    Crear userModel
    UserModel userModel = _buildUserModel(user);
//    Crea el usuario en cloud firestore
    updateUserData(userModel);
    print(userModel);
    print("Email: " + userModel.email + " uid: " + userModel.uid);
  }

  UserModel _buildUserModel(FirebaseUser user) {
      UserModel userModel = new UserModel(
        uid: user.uid,
        name: user.displayName,
        apellidos: "",
        nickName: "",
        email: user.email,
        photoUrl: user.photoUrl);
    return userModel;
  }

  //2. Registrar usuario en base de datos
  void updateUserData(UserModel user) => _cloudFirestoreRepository.updateUserDataFirestore(user);

//  Loging user with email and password
  Future<FirebaseUser> signInWithEmailAndPassword(BuildContext context, String email, String password) async {
    FirebaseUser user = await _userService.signInWithEmailAndPassword(context, email, password);
    UserModel userModel = _buildUserModel(user);
//  Actualiza el usuario en cloud firestore
    updateUserData(userModel);
    return user;
  }
//  LogOut
  void cerrarSesion(BuildContext context) {
    _userService.signOut(context);
  }

//  Resend password
  void sendPasswordReset(BuildContext context, String email) {
    _userService.sendPasswordReset(context, email);
  }
  dispose() {
    _userController?.close();
  }


}
