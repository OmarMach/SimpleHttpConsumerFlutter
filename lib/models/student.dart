import 'package:flutter/foundation.dart';

class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String option;
  final String avatarurl;
  int nombreAbs;
  Student({
    @required this.avatarurl,
    @required this.email,
    @required this.id,
    @required this.firstName,
    @required this.option,
    @required this.lastName,
    this.nombreAbs,
  });
}
