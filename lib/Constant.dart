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
const baseURL = 'https://onesblog.herokuapp.com/api';
const registerUrl = '/register';
const verifyUrl = '/verifyCode';
const loginUrl = '/login';
const logoutUrl = '/logout';
const locationsUrl = '/locations';
const locationScores = '/location-scores';
const postsUrl = '/posts';
const commentsUrl = '/comments';
// const cities = '/cities';


// ---- ERRORS ----
const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';