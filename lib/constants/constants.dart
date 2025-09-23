import 'package:college/Screens/Home_Screen.dart';
import 'package:college/posts/Feed_Screen.dart';
import 'package:flutter/material.dart';

class Constants
{
  static const icon="assets/images/Sivani_logo.jpg";
  static const college="assets/images/college.jpg";
  static const background="assets/images/background.jpg";

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';
  static const usersCollection="users";
  static const facultyCollection="faculty";
  static const adminCollection="admin";
  static const postsCollection="posts";
  static const commentsCollection="comments";
  static const AssignmentCollection="assignments";
  static const feesCollection="fees";

  static const tabWidgets=[
    PostsScreen(),
    HomeScreen()
  ];

}