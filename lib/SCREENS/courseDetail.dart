import 'dart:ffi';

import 'package:flutter/material.dart';
import 'createCourse.dart';
import 'package:E_Learning/Home/courseNav.dart';
import 'package:E_Learning/models/course.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/Course.dart';

class CourseDetail extends StatelessWidget {
  static const routeName = '/courseDetail';

  @override
  Widget build(BuildContext context) {
    Course course = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
              tag: course.id,
              child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(course.coverPhoto),
                          fit: BoxFit.cover)))),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Course: ${course.title}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Taught by ${course.userProfile.name}',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      course.description,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                    )),
                Container(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Theme.of(context).primaryColor,
                      splashColor: Theme.of(context).accentColor,
                      child: const Text(
                        'Enroll',
                        style: TextStyle(color: Colors.white),
                      ),
                      textColor: Colors.blue,
                      onPressed: () {
                        Provider.of<CourseProvider>(context, listen: false)
                            .enrollUser(course);
                      },
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
