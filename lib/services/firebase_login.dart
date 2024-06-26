import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<Map<String, dynamic>> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    // The user canceled the sign-in
    throw Exception('User canceled the sign-in process');
  }

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  UserCredential auth = await FirebaseAuth.instance.signInWithCredential(credential);

  // Return both the UserCredential and idToken
  return {
    'idToken': credential.idToken,
    'auth': auth,
  };
}

Future<void> signOut() async {
  // Sign out from Firebase
  await FirebaseAuth.instance.signOut();

  // Sign out from Google
  await GoogleSignIn().signOut();
}
