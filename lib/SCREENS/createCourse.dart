import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:E_Learning/providers/Course.dart';

class CreateCourse extends StatefulWidget {
  static const routeName = '/createCourse';
  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  File _image;
  bool loading = false;
  final picker = ImagePicker();
  final _title = TextEditingController();
  final _description = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  uploadFromStorage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    cropImage(image);
  }

  cropImage(var image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);
    setState(() {
      _image = croppedImage;
    });
  }

  createCourseReq() async {
    setState(() {
      loading = true;
    });

    if (_title.text != null && _description.text != null && _image != null) {
      Provider.of<CourseProvider>(context, listen: false)
          .CreateCourse(_title.text, _description.text, _image)
          .then((_) => {
                setState(() {
                  loading = false;
                })
              });
    }
  }

  double borderRadius = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Course'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: new SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(20),
          child: new Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: _title,
                    decoration: InputDecoration(
                      labelText: 'Enter course title',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: _description,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Enter course description',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                // Container(
                //     margin: EdgeInsets.symmetric(vertical: 10),
                //     child: Text('Add cover photo',
                //         style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //         ))),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                        onTap: () => {uploadFromStorage()},
                        child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 7,
                                    color: Colors.grey,
                                    offset: Offset(0, 3),
                                  ),
                                ]),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                child: _image != null
                                    ? Image.file(_image)
                                    : Image(
                                        image: AssetImage(
                                            'assets/placeholder.png'),
                                        fit: BoxFit.fitHeight,
                                      ))))),
                Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: loading == false
                        ? new RaisedButton(
                            onPressed: () async => {
                                  await createCourseReq(),
                                  Navigator.pop(context)
                                },
                            child: const Text('Create course',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)))
                        : CircularProgressIndicator()),
              ],
            ),
          ),
        )));
  }
}
