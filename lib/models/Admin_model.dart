import 'dart:convert';

class AdminModel {
  final String adminName;
  final String adminKey;
  final String uid;
  final bool isAdminAuthenticated;

  AdminModel({
    required this.adminName,
    required this.adminKey,
    required this.uid,
    required this.isAdminAuthenticated,
  });

  AdminModel copyWith({
    String? adminName,
    String? adminKey,
    String? uid,
    bool? isAdminAuthenticated,
  }) {
    return AdminModel(
      adminName: adminName ?? this.adminName,
      adminKey: adminKey ?? this.adminKey,
      uid: uid ?? this.uid,
      isAdminAuthenticated:
      isAdminAuthenticated ?? this.isAdminAuthenticated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adminName': adminName,
      'adminKey': adminKey,
      'uid': uid,
      'isAdminAuthenticated': isAdminAuthenticated,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      adminName: map['adminName'] ?? '',
      adminKey: map['adminKey'] ?? '',
      uid: map['uid'] ?? '',
      isAdminAuthenticated: map['isAdminAuthenticated'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdminModel(adminName: $adminName, adminKey: $adminKey, uid: $uid, isAdminAuthenticated: $isAdminAuthenticated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdminModel &&
        other.adminName == adminName &&
        other.adminKey == adminKey &&
        other.uid == uid &&
        other.isAdminAuthenticated == isAdminAuthenticated;
  }

  @override
  int get hashCode {
    return adminName.hashCode ^
    adminKey.hashCode ^
    uid.hashCode ^
    isAdminAuthenticated.hashCode;
  }
}