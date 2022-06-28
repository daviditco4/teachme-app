


import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  // GET UID
  Future<String?> getCurrentUID() async {
    return _firebaseAuth.currentUser?.uid;
  }

  // GET CURRENT USER
  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }


}