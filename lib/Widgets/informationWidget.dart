import 'package:flutter/material.dart';
import 'package:E_Learning/models/course-post.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/coursePost.dart';
import 'package:E_Learning/Widgets/coursePost.dart';

class InformationWidget extends StatelessWidget {
  @override
  static const routeName = '/CourseInformationPost';
  CoursePost coursePost;
  InformationWidget(CoursePost coursePostParam) {
    coursePost = coursePostParam;
  }

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey,
                offset: Offset(0, 3),
              ),
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 15,
                  foregroundColor: Colors.cyan,
                  backgroundImage:
                      NetworkImage(coursePost.userProfile.profile_picture),
                ),
                new Text(coursePost.userProfile.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(
                    coursePost.title,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  new Text(coursePost.description,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.left),
                ],
              ),
            )
          ],
        ));
  }
}
