import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../SCREENS/courseDetail.dart';
import '../SCREENS/courseHome.dart';
import '../Home/courseNav.dart';
import 'package:E_Learning/models/course.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/Course.dart';
// class FeedCard extends StatefulWidget {
//   @override
//   _FeedCardState createState() => _FeedCardState();
// }

// class _FeedCardState extends State<FeedCard> {
class FeedCard extends StatelessWidget {
  @override
  double borderRadius = 10, padding = 10;
  var title, description, taughtBy, coverPhoto, id;
  bool isAdmin, enrolled;
  Course screenArguments;
  String finalText;
  void initState() {}

  FeedCard(Course passed) {
    screenArguments = passed;
    print(screenArguments.id);
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (screenArguments.enrolled == false) {
          Navigator.pushNamed(context, CourseDetail.routeName,
              arguments: screenArguments);
          return;
        }
        Navigator.pushNamed(context, CourseNav.routeName,
            arguments: screenArguments);
      },
      child: new Container(
        width: double.infinity,
        height: 310,
        margin: EdgeInsets.all(borderRadius),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey,
                offset: Offset(0, 3),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
                tag: screenArguments.id,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.white,
                      child: Image.network(
                        screenArguments.coverPhoto,
                        fit: BoxFit.cover,
                      ),
                    ))),
            new Padding(
              padding:
                  EdgeInsets.only(left: padding, top: padding, right: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(screenArguments.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  new Text('Taught by ${screenArguments.userProfile.name}',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  screenArguments.enrolled == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: OutlineButton(
                                  child: const Text(
                                    'View Course',
                                  ),
                                  //  color: Colors.black87,
                                  textColor: Colors.black87,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, CourseDetail.routeName,
                                        arguments: screenArguments);
                                  },
                                )),
                            OutlineButton(
                              child: const Text('Enroll'),

                              //  color: Theme.of(context).primaryColor,
                              textColor: Theme.of(context).primaryColor,
                              onPressed: () {
                                Provider.of<CourseProvider>(context,
                                        listen: false)
                                    .enrollUser(screenArguments);
                              },
                            ),
                          ],
                        )
                      : Container(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Theme.of(context).primaryColor,
                            splashColor: Theme.of(context).accentColor,
                            child: const Text(
                              'Resume your course',
                              style: TextStyle(color: Colors.white),
                            ),
                            textColor: Colors.blue,
                            onPressed: () {
                              Navigator.pushNamed(context, CourseNav.routeName,
                                  arguments: screenArguments);
                            },
                          ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
