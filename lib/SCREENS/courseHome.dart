import 'package:flutter/material.dart';
import 'package:E_Learning/models/course-post.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/coursePost.dart';
import 'package:E_Learning/Widgets/coursePost.dart';

class CoursePosts extends StatefulWidget {
  @override
  static String id;
  CoursePosts(id1) {
    print(id1);
    id = id1;
  }
  static const routeName = '/course';
  _CoursePostsState createState() => _CoursePostsState();
}

class _CoursePostsState extends State<CoursePosts>
    with AutomaticKeepAliveClientMixin {
  @override
  @override
  bool get wantKeepAlive => true;
  bool _isLoading = false;
  String parentId = CoursePosts.id;
  List<CoursePost> FeedItems;
  String type = "VIDEO-POST";
  void initState() {
    super.initState();
    _fetchCoursePostsReq();
  }

  _fetchCoursePostsReq() async {
    try {
      setState(() {
        _isLoading = true;
      });
      print(parentId);
      List<CoursePost> items =
          Provider.of<CoursePostProvider>(context, listen: false)
              .fetchFromProviderCoursePost(parentId, type);

      if (items.length == 0) {
        await Provider.of<CoursePostProvider>(context, listen: false)
            .fetchCoursePosts(parentId);
        items = Provider.of<CoursePostProvider>(context, listen: false)
            .fetchFromProviderCoursePost(parentId, type);
      }

      setState(() {
        _isLoading = false;
        FeedItems = items;
      });
    } catch (e) {
      print('errorr iss $e');
    }
  }

  Widget build(BuildContext context) {
    // final course = Provider.of<CoursePostProvider>(context);
    // final FeedItems = course.selectedCourseItems;
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: _isLoading == false
            ? ListView.builder(
                itemCount: FeedItems.length,
                itemBuilder: (BuildContext context, i) {
                  return (CoursePostWidget(FeedItems[i], i));
                })
            : CircularProgressIndicator());
  }
}
