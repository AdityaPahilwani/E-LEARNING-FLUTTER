import 'package:E_Learning/Home/mainNav.dart';
import 'package:flutter/material.dart';

import 'SCREENS/auth.dart';
import 'SCREENS/feed.dart';
import 'SCREENS/courseHome.dart';
import 'SCREENS/addPostInCourse.dart';
import 'SCREENS/createCourse.dart';
import 'SCREENS/enrolledCourse.dart';
import 'SCREENS/userHome.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/Auth.dart';
import 'providers/Course.dart';
import 'providers/coursePost.dart';
import 'SCREENS/loading.dart';
import 'SCREENS/courseDetail.dart';
import 'package:E_Learning/Home/mainNav.dart';
import 'package:E_Learning/Home/courseNav.dart';
import 'package:E_Learning/SCREENS/coursePostDetail.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  } catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProxyProvider<UserProvider, CourseProvider>(
          create: null,
          update: (ctx, UserProvider, previous) =>
              CourseProvider(userProfile: UserProvider.userProfile),
        ),
        ChangeNotifierProxyProvider<UserProvider, CoursePostProvider>(
          create: null,
          update: (ctx, UserProvider, previous) =>
              CoursePostProvider(userProfile: UserProvider.userProfile),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.deepPurpleAccent,
        ),
        home: Loading(),
        routes: {
          Loading.routeName: (ctx) => Loading(),
          Auth.routeName: (ctx) => Auth(),
          CourseDetail.routeName: (ctx) => CourseDetail(),
          CreateCourse.routeName: (ctx) => CreateCourse(),
          AddPostCourse.routeName: (ctx) => CreateCourse(),
          MainNav.routeName: (ctx) => MainNav(),
          CourseNav.routeName: (ctx) => CourseNav(),
          Feed.routeName: (ctx) => CourseNav(),
          UserHomeFeed.routeName: (ctx) => CourseNav(),
          EnrolledCourse.routeName: (ctx) => CourseNav(),
        },
      ),
    );
  }
}
