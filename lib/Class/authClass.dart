// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';

// class AuthService {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   Stream<User> user; // firebase user
//   Stream<Map<String, dynamic>> profile; // custom user data in Firestore
//   PublishSubject loading = PublishSubject();

//   // constructor
//   AuthService() {
//     user = Stream(_auth.authStateChanges());

//     profile = user.switchMap((User u) {
//       if (u != null) {
//         return _db
//             .collection('users')
//             .document(u.uid)
//             .snapshots()
//             .map((snap) => snap.data);
//       } else {
//         return Stream.just({});
//       }
//     });
//   }

//   Future<FirebaseUser> googleSignIn() async {
//     try {
//       loading.add(true);
//       GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//       GoogleSignInAuthentication googleAuth =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.getCredential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       FirebaseUser user = await _auth.signInWithCredential(credential);
//       updateUserData(user);
//       print("user name: ${user.displayName}");

//       loading.add(false);
//       return user;
//     } catch (error) {
//       return error;
//     }
//   }

//   void updateUserData(FirebaseUser user) async {
//     DocumentReference ref = _db.collection('users').document(user.uid);

//     return ref.setData({
//       'uid': user.uid,
//       'email': user.email,
//       'photoURL': user.photoUrl,
//       'displayName': user.displayName,
//       'lastSeen': DateTime.now()
//     }, merge: true);
//   }

//   Future<String> signOut() async {
//     try {
//       await _auth.signOut();
//       return 'SignOut';
//     } catch (e) {
//       return e.toString();
//     }
//   }

// }

// // TODO refactor global to InheritedWidget
// final AuthService authService = AuthService();
