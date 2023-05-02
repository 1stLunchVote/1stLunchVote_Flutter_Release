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

  Future<void> createUser(String uid, String? name, String? email, String? imageUrl) async{
    if (await getUserExists(uid)){
      return _db.ref("users/$uid").set({
        "nickname" : name,
        "email" : email,
        "profileImage" : imageUrl
      });
    }
  }

  Stream<DatabaseEvent> getUserNickname(String uid){
    return _db.ref("users/$uid/nickname").onValue;
  }

  Future<void> updateUserNickname(String uid, String nickname) async{
    return _db.ref("users/$uid/nickname").set(nickname);
  }


  Stream<DatabaseEvent> getUserInfo(String uid){
    return _db.ref("users/$uid").onValue;
  }
}