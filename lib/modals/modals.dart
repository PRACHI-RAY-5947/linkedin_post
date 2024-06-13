import 'dart:io';

import 'package:flutter/cupertino.dart';

class User {
  static String?  author, detail,  name, email;
  static File? image;

  void reset() {
        author = detail  = name = email  = image = null;
  }
}

//Singleton
class Globals {
  //private named constructor
  Globals._();
  //assign into static final object
  static final Globals globals = Globals._();

  User user = User();

  List<User> allUsers = [];
}

// List<TextEditingController> controller = [
//   TextEditingController(),
//   TextEditingController(),
// ];

