import 'package:flutter/material.dart';

const Color grey = Color(0xff505561);
const Color white = Colors.white;
const Color primaryColor = Colors.lightBlueAccent;
const Color secondaryColor = Color(0xff68caf1);

const TextStyle kTextStyle = TextStyle(
color: Colors.white,
fontWeight: FontWeight.w500,
fontSize: 25
);

const InputBorder kErrorBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.red));
const InputBorder kFocusBorder = OutlineInputBorder(borderSide: BorderSide(width: 2, color: grey));
const InputBorder kBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.white));

const int NEW_USER_CODE = 10;
const int RETURNING_USER_CODE = 20;