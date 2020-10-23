import 'dart:io';

import 'package:flutter/foundation.dart';
import '../models/userProfile.dart';

class CoursePost {
  final String title, description, parentId, postType;
  var video_link;

  UserProfile userProfile;
  CoursePost({
    @required this.postType,
    @required this.parentId,
    @required this.title,
    @required this.description,
    @required this.userProfile,
    this.video_link,
  });
}
