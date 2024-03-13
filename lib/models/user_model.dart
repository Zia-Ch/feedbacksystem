// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final String sectionId;
  final String courseId;
  final bool isDeleted;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.email,
    required this.sectionId,
    required this.courseId,
    required this.isDeleted,
    required this.isAdmin,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? sectionId,
    String? courseId,
    bool? isDeleted,
    bool? isAdmin,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      sectionId: sectionId ?? this.sectionId,
      courseId: courseId ?? this.courseId,
      isDeleted: isDeleted ?? this.isDeleted,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'sectionId': sectionId,
      'courseId': courseId,
      'isDeleted': isDeleted,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'] as String,
      email: map['email'] as String,
      sectionId: map['sectionId'] as String,
      courseId: map['courseId'] as String,
      isDeleted: map['isDeleted'] as bool,
      isAdmin: map['isAdmin'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, sectionId: $sectionId, courseId: $courseId, isDeleted: $isDeleted, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.sectionId == sectionId &&
        other.courseId == courseId &&
        other.isDeleted == isDeleted &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        sectionId.hashCode ^
        courseId.hashCode ^
        isDeleted.hashCode ^
        isAdmin.hashCode;
  }
}
