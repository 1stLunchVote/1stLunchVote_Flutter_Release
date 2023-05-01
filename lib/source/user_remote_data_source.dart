import 'package:firebase_database/firebase_database.dart';

class UserRemoteDataSource {
  UserRemoteDataSource._privateConstructor();
  static final UserRemoteDataSource instance = UserRemoteDataSource._privateConstructor();

  factory UserRemoteDataSource() {
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

  Stream<DatabaseEvent> getUserNickname(String? uid){
    return _db.ref("users/$uid/name").onValue;
  }
}