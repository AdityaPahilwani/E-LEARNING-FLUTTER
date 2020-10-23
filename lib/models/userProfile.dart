import 'dart:io';

import 'package:flutter/foundation.dart';

class UserProfile {
  var name, gmail, profile_picture, uid;
  String parentId;
  List<dynamic> createdCourse, enrolledCourse;
  UserProfile(
      {@required this.name,
      @required this.gmail,
      @required this.profile_picture,
      @required this.uid,
      this.createdCourse,
      this.enrolledCourse,
      this.parentId});
  void set setEnrolledCourse(dynamic value) {
    this.enrolledCourse.insert(0, value);
  }
}
