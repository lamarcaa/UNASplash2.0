import 'package:flutter/material.dart';

class FirebaseIdProvider with ChangeNotifier {
  String _firebaseId = '';

  String get firebaseId => _firebaseId;

  setFirebaseId(String id) {
    _firebaseId = id;
    notifyListeners();
    print('ID do Firebase armazenado: $_firebaseId');
  }
}
