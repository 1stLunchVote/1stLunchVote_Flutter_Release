import 'package:firebase_database/firebase_database.dart';

class LoginRemoteDataSource{
  LoginRemoteDataSource._privateConstructor();
  static final LoginRemoteDataSource instance = LoginRemoteDataSource._privateConstructor();

  factory LoginRemoteDataSource() {
    return instance;
  }

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Future<bool> getUserExists(String uid) async{
    final snapshot = await _db.ref("users/$uid").get();
    return snapshot.exists;
  }

  Future<void> createUser(String? uid, String? name, String? email, String? imageUrl) async{
    if (uid != null && !await getUserExists(uid)){
      return _db.ref("users/$uid").set({
        "name" : name,
        "email" : email,
        "imageUrl" : imageUrl
      });
    }
  }
}