import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:E_Learning/models/userProfile.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
FirebaseFirestore firestore = FirebaseFirestore.instance;

class UserProvider with ChangeNotifier {
  UserProfile userProfile;

  Future<UserProfile> getUser() async {
    return userProfile;
  }

  Future<String> login() async {
    try {
      Map documentSnapshots;
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;

      print("signed in ${user.providerData[0].displayName}");

      // store user data
      if (user.email != null) {
        var snap = await firestore.collection('users').doc(user.uid).get();

        if (snap.exists) {
          documentSnapshots = snap.data();

          userProfile = new UserProfile(
              name: documentSnapshots['displayName'],
              gmail: documentSnapshots['email'],
              profile_picture: documentSnapshots['photoURL'],
              uid: user.uid,
              createdCourse: documentSnapshots['createdCourse'],
              enrolledCourse: documentSnapshots['enrolledCourse']);
        } else {
          await firestore.collection('users').doc(user.uid).set({
            'gmail': user.email,
            'profile_picture': user.providerData[0].photoURL,
            'name': user.providerData[0].displayName,
            'createdCourse': [],
            'enrolledCourse': []
          });
          userProfile = new UserProfile(
              name: user.providerData[0].displayName,
              gmail: user.email,
              profile_picture: user.providerData[0].photoURL,
              uid: user.uid,
              createdCourse: [],
              enrolledCourse: []);
        }
      }
      String email = user.email;
      return email;
    } catch (e) {
      print('error issss $e');
    }
  }

  Future<void> getCurrentUser() async {
    final User user = _auth.currentUser;
    // print('user founddd $user');
    if (user != null) {
      await getUserFromId(user.uid);
    }
  }

  Future<Void> getUserFromId(String id) async {
    Map data;

    try {
      // print('$id helllllllllo');
      var documentSnapshot = await firestore.collection('users').doc(id).get();

      data = documentSnapshot.data();
      // print('user data is   $data');
      userProfile = new UserProfile(
          name: data['name'],
          gmail: data['gmail'],
          profile_picture: data['profile_picture'],
          uid: id,
          createdCourse: data['createdCourse'],
          enrolledCourse: data['enrolledCourse']);
      notifyListeners();
      print(userProfile);
    } catch (e) {
      print(e);
    }
  }

  Future<Void> signOut() async {
    userProfile = null;
    await _auth.signOut();
    await _googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
