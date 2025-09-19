import 'package:flutter/material.dart';
import 'package:userapp/injection_container.dart';
import 'package:userapp/user_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await injection();

  runApp(const UserApp());
}
