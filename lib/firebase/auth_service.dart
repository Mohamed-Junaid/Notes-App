import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_notes/screens/home_page.dart';
import 'package:personal_notes/screens/login_screen.dart';
import 'package:personal_notes/screens/profile.dart';
import 'package:personal_notes/screens/signup_screen.dart';


class AuthService {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Profile();
          } else {
            return const SignupScreen();
          }
        });
  }
  signInWithGoogle(BuildContext ctx) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) =>
        Navigator.of(ctx).push(MaterialPageRoute(builder: (_)=>HomePage())));
  }
  // Sign out
  signOut(BuildContext ctx) {
    FirebaseAuth.instance.signOut();
    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) => const LoginScreen()), (
        route) => false);
  }
}