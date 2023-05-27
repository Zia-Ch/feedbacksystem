// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String sectionId;
  final String courseId;
  final bool isWorking;
  final bool isAdmin;

  UserModel({
    required this.email,
    required this.sectionId,
    required this.courseId,
    required this.isWorking,
    required this.isAdmin,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? password,
    String? sectionId,
    String? courseId,
    bool? isWorking,
    bool? isAdmin,
  }) {
    return UserModel(
      email: email ?? this.email,
      sectionId: sectionId ?? this.sectionId,
      courseId: courseId ?? this.courseId,
      isWorking: isWorking ?? this.isWorking,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'sectionId': sectionId,
      'courseId': courseId,
      'isWorking': isWorking,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      sectionId: map['sectionId'] as String,
      courseId: map['courseId'] as String,
      isWorking: map['isWorking'] as bool,
      isAdmin: map['isAdmin'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel( email: $email,  sectionId: $sectionId, courseId: $courseId, isWorking: $isWorking, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.sectionId == sectionId &&
        other.courseId == courseId &&
        other.isWorking == isWorking &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        sectionId.hashCode ^
        courseId.hashCode ^
        isWorking.hashCode ^
        isAdmin.hashCode;
  }
}
