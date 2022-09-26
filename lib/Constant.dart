import 'package:flutter/material.dart';

const titleStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
);
const contextStyle = TextStyle(
  fontSize: 14,
  color: Colors.black,
);

// ---- STRINGS ----
const baseURL = 'http://onesblog.herokuapp.com/api';
const loginUrl = '/login';
const registerUrl = '/register';
const logoutUrl = '/logout';
const userUrl = '/user';
const postsUrl = '/posts';
const commentsUrl = '/comments';
const verifyUrl = '/verifyCode';
const locationsUrl = '/locations';

// ---- ERRORS ----
const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

Map<String, String> headers = {"Accept" : "application/json"};