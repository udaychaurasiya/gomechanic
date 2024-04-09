// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices
{
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  late UserCredential userCredential;
  Future<UserCredential> signInWithGooglewithFirebase()
  async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null)
      {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential =
        GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        userCredential =  await _auth.signInWithCredential(authCredential);
        print("hello");
      }
    } on FirebaseAuthException catch (e)
    {
      print(e.message);
      rethrow;
    }
    return userCredential;
  }


  googleSignOut() async
  {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}