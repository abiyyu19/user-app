import 'package:flutter/material.dart';
import 'package:userapp/core/app_router/app_router.dart';
import 'package:userapp/injection_container.dart';

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(final BuildContext context) {
    const TextTheme textTheme = TextTheme(
      displayLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
      headlineLarge: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),
      labelMedium: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300),
      labelSmall: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
    );

    final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 20),
      hintStyle: textTheme.bodyMedium?.copyWith(color: Colors.grey),
      errorStyle: textTheme.labelMedium?.copyWith(color: Colors.red),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      isDense: true,
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    );

    return MaterialApp.router(
      routerConfig: getIt<AppRouter>().config(),
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: inputDecorationTheme,
        textTheme: textTheme,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
