import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../source/login_remote_data_source.dart';


class LoginRepository{
  final FirebaseAuth _firebaseAuth;
  final LoginRemoteDataSource _loginRemoteDataSource;

  LoginRepository(this._firebaseAuth, this._loginRemoteDataSource);

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
    return _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> createUser(String? uid, String? name, String? email, String? imageUrl) async{
    return _loginRemoteDataSource.createUser(uid, name, email, imageUrl);
  }
}