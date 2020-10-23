import 'dart:ffi';

import 'package:flutter/material.dart';
import 'createCourse.dart';
import 'package:E_Learning/Home/courseNav.dart';
import 'package:E_Learning/models/course-post.dart';
import 'package:video_player/video_player.dart';

class CoursePostDetail extends StatefulWidget {
  @override
  static CoursePost coursePost;
  //  CoursePost coursePost1 = ModalRoute.of(context).settings.arguments;
  CoursePostDetail(CoursePost coursePost1) {
    coursePost = coursePost1;
  }

  static const routeName = '/coursePostDetail';
  _CoursePostDetailState createState() => _CoursePostDetailState();
}

class _CoursePostDetailState extends State<CoursePostDetail> {
  @override
  CoursePost course = CoursePostDetail.coursePost;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    print('course post detail init ');
    print(course);
    _controller = VideoPlayerController.network(course.video_link);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
  }

  // String url= CoursePostDetail.coursePost.video_link;
  // final String urlToStreamVideo = CoursePostDetail.coursePost.video_link;
  // final VlcPlayerController controller = new VlcPlayerController();
  // final double playerWidth = 640;
  // final double playerHeight = 360;

  Widget build(BuildContext context) {
    print('course post detail $course');
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
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          // SizedBox(
          //     height: playerHeight,
          //     width: playerWidth,
          //     child: new VlcPlayer(
          //       aspectRatio: 16 / 9,
          //       url: urlToStreamVideo,
          //       controller: controller,
          //       placeholder: Center(child: CircularProgressIndicator()),
          //     )),

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
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
