import 'package:flutter/material.dart';
import 'createCourse.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/Widgets/userGrid.dart';
import 'package:E_Learning/models/userProfile.dart';
import 'package:E_Learning/providers/coursePost.dart';
import 'package:E_Learning/providers/coursePost.dart';

class EnrolledUser extends StatefulWidget {
  @override
  static const routeName = '/EnrolledUser';
  static List<dynamic> enrolledId1;
  static String parentId1;
  EnrolledUser(values, parentId) {
    enrolledId1 = values;
    parentId1 = parentId;
  }

  _EnrolledUserState createState() => _EnrolledUserState();
}

class _EnrolledUserState extends State<EnrolledUser> {
  @override
  @override
  List<dynamic> enrolledId = EnrolledUser.enrolledId1;
  List<UserProfile> users;
  String parentId = EnrolledUser.parentId1;
  bool _isLoading = false;
  void initState() {
    super.initState();
    print('init called $parentId');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUsers();
    });
  }

  void dispose() {
    super.dispose();
  }

  _fetchUsers() async {
    try {
      setState(() {
        _isLoading = true;
      });
      print(parentId);
      List<UserProfile> items =
          Provider.of<CoursePostProvider>(context, listen: false)
              .fetchFromProviderUserPost(parentId);
      print('enrollled id are ${enrolledId.length}');
      print('item lenth  id are ${items.length}');

      if (items.length == 0) {
        await Provider.of<CoursePostProvider>(context, listen: false)
            .fetchEnrolledUsers(enrolledId, parentId);
        items = Provider.of<CoursePostProvider>(context, listen: false)
            .fetchFromProviderUserPost(parentId);
      }

      setState(() {
        _isLoading = false;
        users = items;
      });
    } catch (e) {
      print('errorr iss $e');
    }
  }

  @override
  double borderRadius = 10, padding = 10;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 70;
    final double itemWidth = size.width / 2;
    // final course = Provider.of<CourseProvider>(context);
    // final courseFeed = course.feedCourse;
    return _isLoading == false
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: GridView.builder(
                itemCount: users.length,
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                ),
                itemBuilder: (BuildContext context, i) {
                  return (ListUser(users[i]));
                }),
          )
        : Center(child: CircularProgressIndicator());
  }
}
