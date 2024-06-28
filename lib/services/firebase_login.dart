import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<Map<String, dynamic>> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print("Google User: $googleUser");

    if (googleUser == null) {
      // The user canceled the sign-in
      throw Exception('User canceled the sign-in process');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    print("Google Auth: ${googleAuth.accessToken}, ${googleAuth.idToken}");

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential auth = await FirebaseAuth.instance.signInWithCredential(credential);
    print("User Credential: $auth");

    // Return both the UserCredential and idToken
    return {
      'idToken': credential.idToken,
      'auth': auth,
    };
  } catch (e) {
    print("Error during Google Sign-In: $e");
    throw e; // Re-throw the exception after logging it
  }
}

Future<void> signOut() async {
  // Sign out from Firebase
  await FirebaseAuth.instance.signOut();

  // Sign out from Google
  await GoogleSignIn().signOut();
}
