import 'dart:convert';

import 'package:college/Screens/Department_Screen.dart';
import 'package:college/Screens/fees_history.dart';
import 'package:college/Screens/login_Screen.dart';
import 'package:college/Screens/materials_Screen.dart';
import 'package:college/Screens/signup_screen.dart';
import 'package:college/Screens/user_profile.dart';
import 'package:college/payment/fee_payment_Screen.dart';
import 'package:college/posts/Comment_Screen.dart';
import 'package:college/posts/upload_Screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'Screens/Home_Screen.dart';
import 'Screens/feesReceiptScreen.dart';
import 'Screens/splash_screen.dart';
import 'models/fees_model.dart';
import 'models/user_model.dart';

final route = RouteMap(
  routes: {
    "/": (_) => MaterialPage(child: SplashScreen()),
    "/HomeScreen": (_) => MaterialPage(child: HomeScreen()),
    "/DepartmentScreen": (_) => MaterialPage(child: DepartmentScreen()),
    "/signUpScreen": (_) => MaterialPage(child: SignupPage()),
    "/LoginScreen": (_) => MaterialPage(child: LoginScreen()),
    "/dashboard": (_) => MaterialPage(child: StudentDashboard()),
    "/uploadScreen": (_) => MaterialPage(child: UploadScreen()),
    "/feesScreen":(_)=>MaterialPage(child: FeePaymentPage()),
    "/HistoryScreen":(_)=>MaterialPage(child: FeesHistory()),

    '/FeesReceiptScreen': (route) {
      final feeJson = Uri.decodeComponent(route.queryParameters['fee']!);
      final userJson = Uri.decodeComponent(route.queryParameters['user']!);


      final feeMap = jsonDecode(feeJson) as Map<String, dynamic>;
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;

      return MaterialPage(
        child: FeesReceiptScreen(
          feesModel: FeesModel.fromMap(feeMap),
          userModel: UserModel.fromMap(userMap),
        ),
      );
    },







    "/materials/:branch/:sem": (routeData) {
      final branch = routeData.pathParameters["branch"]!;
      final sem = routeData.pathParameters["sem"]!;
      return MaterialPage(
        child: materialsScreen(branch: branch, sem: sem),
      );
    },

    "/post/:postId/comments": (route) =>
        MaterialPage(child: CommentScreen(postId: route.pathParameters["postId"]!,))
  },
);
