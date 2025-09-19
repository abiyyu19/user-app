import 'package:flutter/material.dart';
import 'package:userapp/injection_container.dart';
import 'package:userapp/user_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  injection();

  runApp(const UserApp());
}
