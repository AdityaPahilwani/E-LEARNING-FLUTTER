import 'package:flutter/material.dart';

import 'package:E_Learning/SCREENS/addPostInCourse.dart';
import 'package:E_Learning/SCREENS/courseHome.dart';
import 'package:E_Learning/models/course.dart';
import 'package:E_Learning/SCREENS/enrolledUser.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/coursePost.dart';
import 'package:E_Learning/SCREENS/information.dart';

class CourseNav extends StatefulWidget {
  @override
  static const routeName = '/courseNav';
  _CourseNavState createState() => _CourseNavState();
}

class _CourseNavState extends State<CourseNav> {
  @override
  int pageIndex = 0;
  List<Widget> pages;
  bool _isLoading = false;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Course course = ModalRoute.of(context).settings.arguments;
    bool isAdmin = course.isAdmin;
    List<dynamic> enrolledId = course.enrolledId;
    String parentId = course.id;
    var appBarTitles;
    if (isAdmin) {
      pages = [
        CoursePosts(parentId),
        CourseInformationPost(parentId),
        EnrolledUser(enrolledId, parentId),
        AddPostCourse(parentId),
      ];

      appBarTitles = [
        course.title,
        'Information',
        'Enrolled users',
        'Add post'
      ];
    } else {
      pages = [
        CoursePosts(parentId),
        CourseInformationPost(parentId),
      ];
      appBarTitles = [
        course.title,
        'Information',
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[pageIndex]),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: pages[pageIndex],
      bottomNavigationBar: isAdmin
          ? BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      IconData(0xe871, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ),
                    title: Text(
                      'Feed',
                      style: TextStyle(color: Colors.white),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.info_outline, color: Colors.white),
                    title: Text(
                      'Information',
                      style: TextStyle(color: Colors.white),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle, color: Colors.white),
                    title: Text(
                      'Enrolled users',
                      style: TextStyle(color: Colors.white),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(IconData(57672, fontFamily: 'MaterialIcons'),
                        color: Colors.white),
                    title: Text(
                      'Add post',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
              currentIndex: pageIndex,
              onTap: (i) {
                print(i);
                setState(() {
                  pageIndex = i;
                });
              },
              type: BottomNavigationBarType.fixed,
            )
          : BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      IconData(0xe871, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ),
                    title: Text(
                      'Feed',
                      style: TextStyle(color: Colors.white),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.info_outline, color: Colors.white),
                    title: Text(
                      'Information',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
              currentIndex: pageIndex,
              onTap: (i) {
                print(i);
                setState(() {
                  pageIndex = i;
                });
              },
            ),
    );
  }
}
