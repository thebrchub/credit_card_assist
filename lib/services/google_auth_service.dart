import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthService {
  static final _googleSignIn = GoogleSignIn();
  static final _auth = FirebaseAuth.instance;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      // 🔐 Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      return userCredential;
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
  }
}
