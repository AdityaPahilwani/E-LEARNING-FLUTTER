import 'dart:convert';
import 'package:E_Learning/SCREENS/createCourse.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'package:E_Learning/models/userProfile.dart';
import 'package:flutter/foundation.dart';
import 'package:E_Learning/models/course.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:E_Learning/providers/Auth.dart';
import 'package:provider/provider.dart';
import 'package:E_Learning/models/course-post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class CoursePostProvider with ChangeNotifier {
  CoursePost coursePost;
  List<CoursePost> courseItems = [];
  List<CoursePost> selectedCourseItems = [];
  List<UserProfile> courseEnrolledUsers = [];
  List<UserProfile> selectedCourseEnrolledUsers = [];
  UserProfile userProfile, tempUser;
  List<DocumentSnapshot> documentSnapshots;

  CoursePostProvider({this.userProfile});

  Future<void> CreateCoursePost(
      String parentId, String title, String description, var video) async {
    try {
      var id = userProfile.uid;
      var finalFile = "false";
      String postType = "INFORMATION-POST";
      if (video != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
            path.basename(video.path);
        final StorageReference storageReference = _storage
            .ref()
            .child("course")
            .child(userProfile.uid)
            .child(fileName);

        final StorageUploadTask uploadTask = storageReference.putFile(video);

        StorageTaskSnapshot onComplete = await uploadTask.onComplete;
        finalFile = await onComplete.ref.getDownloadURL();
        postType = "VIDEO-POST";
      }
      var result = await firestore.collection('posts').add({
        'parentId': parentId,
        'title': title,
        'description': description,
        'url': finalFile,
        'createdAt': Timestamp.now(),
        "postType": postType,
        'createdBy': userProfile.uid
      });

      coursePost = new CoursePost(
          parentId: parentId,
          title: title,
          description: description,
          video_link: finalFile,
          userProfile: userProfile,
          postType: postType);
      courseItems.add(coursePost);
      notifyListeners();
    } catch (e) {
      print('errrrorrrr issssssssss $e');
    }
  }

  Future<void> fetchCoursePosts(String parentId) async {
    try {
      Map userData;
      // print('from api   $parentId');
      var snap = await firestore
          .collection('posts')
          .where('parentId', isEqualTo: parentId)
          .orderBy("createdAt", descending: false)
          .get();

      documentSnapshots = snap.docs;

      var id, data;
      var userSnapShot;
      for (var key in documentSnapshots) {
        id = key.id;
        data = key.data();

        userSnapShot =
            await firestore.collection('users').doc(data['createdBy']).get();
        userData = userSnapShot.data();
        tempUser = new UserProfile(
            name: userData['name'],
            gmail: userData['gmail'],
            profile_picture: userData['profile_picture'],
            uid: id);
        // print('user dataaa issss $tempUser');
        courseItems.add(CoursePost(
            parentId: data['parentId'],
            title: data['title'],
            description: data['description'],
            video_link: data['url'],
            userProfile: tempUser,
            postType: data['postType']));
      }
    } catch (e) {
      print('error is $e');
    }
  }

  List<CoursePost> fetchFromProviderCoursePost(
      String parentId, String postType) {
    return courseItems
        .where((element) => element.parentId == parentId)
        .where((element) => element.postType == postType)
        .toList();
  }

  Future<void> fetchEnrolledUsers(
      List<dynamic> enrolledId, String parentId) async {
    try {
      Map userData;
      var userSnapShot;
      for (var key in enrolledId) {
        userSnapShot = await firestore.collection('users').doc(key).get();
        userData = userSnapShot.data();
        // print('userrrr issssssssss $userData');

        tempUser = new UserProfile(
            name: userData['name'],
            gmail: userData['gmail'],
            profile_picture: userData['profile_picture'],
            uid: key,
            parentId: parentId);
        print('parent idddd ${tempUser.parentId}');
        courseEnrolledUsers.add(tempUser);
      }
    } catch (e) {
      print('error is $e');
    }
  }

  List<UserProfile> fetchFromProviderUserPost(String feedId) {
    // print(courseEnrolledUsers
    //     .where((element) => element.parentId == feedId)
    //     .toList());
    print('$courseEnrolledUsers');
    return courseEnrolledUsers
        .where((element) => element.parentId == feedId)
        .toList();
  }

  void clearCoursePostProvider() {
    coursePost = null;
    courseItems = [];
    selectedCourseItems = [];
    userProfile = null;
    tempUser = null;
    selectedCourseEnrolledUsers = [];
    courseEnrolledUsers = [];
  }
}
