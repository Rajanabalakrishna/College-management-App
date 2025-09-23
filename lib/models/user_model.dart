import 'package:flutter/foundation.dart';
import 'dart:convert';

class UserModel {
  final String name;
  final String uid;
  final String rollNo;
  final String profilePic;
  final String branch;
  final int year;
  final int busFees;
  final int tuitionFees;
  final int hostelFees;
  final double cgpa;
  final bool isAuthenticated;
  final String password;
  final String email;

  UserModel({
    required this.name,
    required this.uid,
    required this.rollNo,
    required this.profilePic,
    required this.branch,
    required this.year,
    required this.busFees,
    required this.tuitionFees,
    required this.hostelFees,
    required this.cgpa,
    required this.isAuthenticated,
    required this.password,
    required this.email,
  });

  UserModel copyWith({
    String? name,
    String? uid,
    String? rollNo,
    String? profilePic,
    String? branch,
    int? year,
    int? busFees,
    int? tuitionFees,
    int? hostelFees,
    double? cgpa,
    bool? isAuthenticated,
    String? password,
    String? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      rollNo: rollNo ?? this.rollNo,
      profilePic: profilePic ?? this.profilePic,
      branch: branch ?? this.branch,
      year: year ?? this.year,
      busFees: busFees ?? this.busFees,
      tuitionFees: tuitionFees ?? this.tuitionFees,
      hostelFees: hostelFees ?? this.hostelFees,
      cgpa: cgpa ?? this.cgpa,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'rollNo': rollNo,
      'profilePic': profilePic,
      'branch': branch,
      'year': year,
      'busFees': busFees,
      'tuitionFees': tuitionFees,
      'hostelFees': hostelFees,
      'cgpa': cgpa,
      'isAuthenticated': isAuthenticated,
      'password': password,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      rollNo: map['rollNo'] ?? '',
      profilePic: map['profilePic'] ?? '',
      branch: map['branch'] ?? '',
      year: map['year'] ?? 0,
      busFees: map['busFees'] ?? 0,
      tuitionFees: map['tuitionFees'] ?? 0,
      hostelFees: map['hostelFees'] ?? 0,
      cgpa: (map['cgpa'] ?? 0).toDouble(),
      isAuthenticated: map['isAuthenticated'] ?? false,
      password: map['password'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, rollNo: $rollNo, profilePic: $profilePic, branch: $branch, year: $year, busFees: $busFees, tuitionFees: $tuitionFees, hostelFees: $hostelFees, cgpa: $cgpa, isAuthenticated: $isAuthenticated, password: $password, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.uid == uid &&
        other.rollNo == rollNo &&
        other.profilePic == profilePic &&
        other.branch == branch &&
        other.year == year &&
        other.busFees == busFees &&
        other.tuitionFees == tuitionFees &&
        other.hostelFees == hostelFees &&
        other.cgpa == cgpa &&
        other.isAuthenticated == isAuthenticated &&
        other.password == password &&
        other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    uid.hashCode ^
    rollNo.hashCode ^
    profilePic.hashCode ^
    branch.hashCode ^
    year.hashCode ^
    busFees.hashCode ^
    tuitionFees.hashCode ^
    hostelFees.hashCode ^
    cgpa.hashCode ^
    isAuthenticated.hashCode ^
    password.hashCode ^
    email.hashCode;
  }
}