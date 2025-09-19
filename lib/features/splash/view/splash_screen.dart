import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/domain/domain.dart';
import 'package:userapp/injection_container.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();

    _authRepository = getIt<AuthRepository>();
    unawaited(_setup());
    SchedulerBinding.instance.addPostFrameCallback((final _) {});
  }

  Future<void> _setup() async {
    final Result<User?> tokenResult = await _authRepository.getLoggedUserFromSecureStorage();

    if (tokenResult is Error<User?>) {
      await _handleSessionExpired(tokenResult.error);
      return;
    }

    final User? user = (tokenResult as Ok<User?>).value;
    if (user == null) {
      await _handleSessionExpired(Exception('user is null, user has no session'));
      return;
    }
    log('Welcome Back! ${user.username}', name: 'SplashScreen');

    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      await context.router.replaceAll([const HomeRoute()]);
    }
  }

  Future<void> _handleSessionExpired(final Exception error) async {
    log('user session has expired', name: 'SplashScreen');
    log('err: $error', name: 'SplashScreen');
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      await context.router.replaceAll([const LoginRoute()]);
    }
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(backgroundColor: Colors.white, elevation: 0, toolbarHeight: 0),
    body: Center(child: _buildLogo(context)),
  );

  Widget _buildLogo(final BuildContext context) =>
      Image.asset('assets/user_logo.jpg', height: context.screenWidth * 0.3);
}
