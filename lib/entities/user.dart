import 'package:flutter/material.dart';

class User{
  final String name;
  final String mobile;

  User({required this.name, required this.mobile});

  static User fromJson(json)=> User(
      name: json['name'],
      mobile: json['mobile']
  );
}