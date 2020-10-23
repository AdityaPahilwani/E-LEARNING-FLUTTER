import 'package:flutter/material.dart';
import 'createCourse.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/Course.dart';
import '../Widgets/FeedCard.dart';

class Feed extends StatefulWidget {
  @override
  static const routeName = '/feed';
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  @override
  bool _isLoading = false;
  void initState() {
    super.initState();
    print('init called');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCourse();
    });
  }

  void dispose() {
    super.dispose();
  }

  _fetchCourse() async {
    try {
      if (!mounted) {
        print('not mounted');
        return;
      }
      final course = Provider.of<CourseProvider>(context, listen: false);
      final requestMade = course.requestMade;
      if (requestMade == false) {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<CourseProvider>(context, listen: false).fetchCourse();
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  double borderRadius = 10, padding = 10;
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context);
    final courseFeed = course.feedCourse;
    return _isLoading == false
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
        : Center(child: CircularProgressIndicator());
    ;
  }
}
