import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/date_time_patterns.dart';

class UserModel {
  List disease;
  String email;
  String name;
  Map position;
  String url;

  UserModel({
    required this.disease,
    required this.email,
    required this.name,
    required this.position,
    required this.url,
  });

  UserModel.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        email = json['email'],
        position = json['position'],
        url = json['url'],
        disease = json['disease'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'position': position,
        'disease': disease,
        'url': url,
      };
}
