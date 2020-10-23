import 'package:E_Learning/models/course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/providers/coursePost.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class AddPostCourse extends StatefulWidget {
  @override
  static const routeName = '/addPostCourse';
  static String id1;
  AddPostCourse(id) {
    id1 = id;
  }
  _AddPostCourseState createState() => _AddPostCourseState(id1);
}

enum Post_type { video, information }

class _AddPostCourseState extends State<AddPostCourse> {
  @override
  String id = AddPostCourse.id1;
  bool loading = false;
  _AddPostCourseState(id) {
    print(id);
  }
  Post_type _type = Post_type.video;
  File video;
  final title = TextEditingController();
  final description = TextEditingController();
  final information = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    title.dispose();
    description.dispose();
    super.dispose();
  }

  final picker = ImagePicker();
  uploadFromStorage() async {
    PickedFile videoTemp = await picker.getVideo(source: ImageSource.gallery);
    video = File(videoTemp.path);
    setState(() {
      video = video;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> addPost() async {
      print(title.text);
      print(id);
      setState(() {
        loading = true;
      });
      if (title.text != null && description.text != null) {
        Provider.of<CoursePostProvider>(context, listen: false)
            .CreateCoursePost(id, title.text, description.text, video)
            .then((_) async => {
                  setState(() {
                    loading = false;
                  }),
                  title.clear(),
                  description.clear(),
                  video = null,
                  await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Success'),
                      content: Text('Post added.'),
                      // actions: <Widget>[
                      //   FlatButton(
                      //     child: Text('Okay'),
                      //     onPressed: () {},
                      //   )
                      // ],
                    ),
                  )
                });
      } else {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text('Title and description are mandatory'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: new Container(
        padding: EdgeInsets.all(20),
        child: new Container(
          child: Column(
            children: [
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.symmetric(vertical: 10),
              //   child: Text('Post type',
              //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //       textAlign: TextAlign.left),
              // ),
              // Container(
              //     margin: EdgeInsets.symmetric(vertical: 10),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         ListTile(
              //           title: const Text('Video'),
              //           leading: Radio(
              //             value: Post_type.video,
              //             groupValue: _type,
              //             onChanged: (Post_type value) {
              //               setState(() {
              //                 _type = value;
              //               });
              //             },
              //           ),
              //         ),
              //         ListTile(
              //           title: const Text('Information'),
              //           leading: Radio(
              //             value: Post_type.information,
              //             groupValue: _type,
              //             onChanged: (Post_type value) {
              //               setState(() {
              //                 _type = value;
              //               });
              //             },
              //           ),
              //         ),
              //       ],
              //     )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    labelText: 'Enter post title',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: description,
                  decoration: InputDecoration(
                    labelText: 'Enter post description',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () => {uploadFromStorage()},
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: video != null
                            ? Text('Video selected')
                            : Image(
                                image: AssetImage('assets/placeholder.png'),
                                fit: BoxFit.fitHeight,
                              )),
                  )),
              Container(
                width: 400,
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: loading == false
                    ? RaisedButton(
                        onPressed: () {
                          addPost();
                        },
                        child: const Text('Add post',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)))
                    : CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
