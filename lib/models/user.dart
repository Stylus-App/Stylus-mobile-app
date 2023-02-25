// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApiUser {
  String id;
  // ignore: non_constant_identifier_names
  String Email;
  // ignore: non_constant_identifier_names
  String Password;
  ApiUser({
    required this.id,
    required this.Email,
    required this.Password,
  });

  ApiUser copyWith({
    String? id,
    String? Email,
    String? Password,
  }) {
    return ApiUser(
      id: id ?? this.id,
      Email: Email ?? this.Email,
      Password: Password ?? this.Password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Email': Email,
      'Password': Password,
    };
  }

  factory ApiUser.fromMap(Map<String, dynamic> map) {
    return ApiUser(
      id: map['id'] as String,
      Email: map['Email'] as String,
      Password: map['Password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiUser.fromJson(String source) =>
      ApiUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApiUser(id: $id, Email: $Email, Password: $Password)';

  @override
  bool operator ==(covariant ApiUser other) {
    if (identical(this, other)) return true;

    return other.id == id && other.Email == Email && other.Password == Password;
  }

  @override
  int get hashCode => id.hashCode ^ Email.hashCode ^ Password.hashCode;
}
