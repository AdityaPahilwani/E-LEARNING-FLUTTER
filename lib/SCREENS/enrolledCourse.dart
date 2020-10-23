import 'package:flutter/material.dart';
import 'createCourse.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/Course.dart';
import '../Widgets/FeedCard.dart';

class EnrolledCourse extends StatefulWidget {
  @override
  static const routeName = '/EnrolledCourse';
  _enrolledCourseState createState() => _enrolledCourseState();
}

class _enrolledCourseState extends State<EnrolledCourse> {
  @override
  void dispose() {
    super.dispose();
  }

  double borderRadius = 10, padding = 10;
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context);
    final courseFeed = course.enrolledCourse;
    return courseFeed.length != 0
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
                itemCount: courseFeed.length,
                itemBuilder: (BuildContext context, i) {
                  return (FeedCard(
                    courseFeed[i],
                  ));
                }),
          )
        : Center(
            child: Text(
              "Nothing to show",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
    ;
  }
}
