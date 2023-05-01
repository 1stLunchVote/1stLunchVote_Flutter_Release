import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../source/user_remote_data_source.dart';


class LoginRepository{
  final UserRemoteDataSource _userRemoteDataSource;

  LoginRepository(this._userRemoteDataSource);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return _auth.signInWithCredential(credential);
  }

  Future<void> createUser(String? uid, String? name, String? email, String? imageUrl) async{
    return _userRemoteDataSource.createUser(uid, name, email, imageUrl);
  }
}