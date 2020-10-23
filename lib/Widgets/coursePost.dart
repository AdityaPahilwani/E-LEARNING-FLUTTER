import 'package:flutter/material.dart';
import 'package:E_Learning/models/course-post.dart';
import '../SCREENS/coursePostDetail.dart';

class CoursePostWidget extends StatelessWidget {
  CoursePost coursePost;
  int index = 1;
  CoursePostWidget(CoursePost coursePostParam, int indexParam) {
    // print('cons');
    // print(index);
    // print('cons');
    coursePost = coursePostParam;
    index = indexParam + 1;
  }
  Widget build(BuildContext context) {
    print(index);
    return Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CoursePostDetail(coursePost)),
            );
          },
          child: Container(
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\#$index',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                Text(coursePost.title,
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ],
            ),
          ),
        ));
  }
}
