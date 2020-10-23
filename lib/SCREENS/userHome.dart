import 'package:flutter/material.dart';
import 'createCourse.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/Course.dart';
import '../Widgets/adminCard.dart';

class UserHomeFeed extends StatefulWidget {
  @override
  static const routeName = '/UserHomeFeed';
  _userHomeFeedState createState() => _userHomeFeedState();
}

class _userHomeFeedState extends State<UserHomeFeed> {
  @override
  bool _isLoading = false;
  void initState() {}
  void dispose() {
    super.dispose();
  }

  @override
  double borderRadius = 10, padding = 10;
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context);
    final courseFeed = course.userCourse;
    return courseFeed.length != 0
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
                itemCount: courseFeed.length,
                itemBuilder: (BuildContext context, i) {
                  return (AdminCard(courseFeed[i]));
                }),
          )
        : Center(
            child: Text(
              "Nothing to show",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
  }
}
