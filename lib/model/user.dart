// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String email;
  String uid;
  String uidConected;
  User({
    required this.email,
    required this.uid,
    required this.uidConected,
  });

  User copyWith({
    String? email,
    String? uid,
    String? uidConected,
  }) {
    return User(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      uidConected: uidConected ?? this.uidConected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'uid': uid,
      'uidConected': uidConected,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      uid: map['uid'] as String,
      uidConected: map['uidConected'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'User(email: $email, uid: $uid, uidConected: $uidConected)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.uid == uid &&
        other.uidConected == uidConected;
  }

  @override
  int get hashCode => email.hashCode ^ uid.hashCode ^ uidConected.hashCode;
}
