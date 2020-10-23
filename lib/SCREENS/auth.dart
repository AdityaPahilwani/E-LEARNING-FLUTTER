import 'package:E_Learning/Home/mainNav.dart';
import 'package:E_Learning/SCREENS/feed.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase/firebase.dart' as fb;
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth extends StatelessWidget {
  static const routeName = '/auth';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<String> _login() async {
  //   try {
  //     // await _googleSignIn.disconnect();
  //     // await FirebaseAuth.instance.signOut();

  //     final GoogleSignIn _googleSignIn = GoogleSignIn();
  //     final FirebaseAuth _auth = FirebaseAuth.instance;

  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final User user = (await _auth.signInWithCredential(credential)).user;

  //     print("signed in ${user.providerData[0].displayName}");

  //     // store user data
  //     if (user.email != null) {
  //       await firestore.collection('users').doc(user.uid).set({
  //         'gmail': user.email,
  //         'profile_picture': user.providerData[0].photoURL,
  //         'name': user.providerData[0].displayName
  //       });
  //     }
  //     String email = user.email;
  //     return email;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://static.vecteezy.com/system/resources/thumbnails/000/171/284/original/T_23-01.jpg'),
                      fit: BoxFit.cover))),
          Align(
            alignment: Alignment.bottomCenter,
            child: new Container(
              width: 400,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: new RaisedButton(
                  onPressed: () async {
                    Provider.of<UserProvider>(context, listen: false)
                        .login()
                        .then((name) => {
                              if (name != null)
                                {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    MainNav.routeName,
                                  )
                                }
                            });
                  },
                  child: const Text('Tap to continue',
                      style: TextStyle(fontSize: 20)),
                  color: Colors.grey[200],
                  splashColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0))),
            ),
          )
        ],
      ),
    );
  }
}
