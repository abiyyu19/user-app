import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/features/login/login.dart';
import 'package:userapp/injection_container.dart';
import 'package:userapp/widgets/widgets.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final BuildContext context) => LoginBloc(authRepository: getIt()),
    child: const LoginView(),
  );
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final CustomTextController<String> _usernameController = CustomTextController<String>.onlyText(
    labelText: 'Username',
    hintText: 'Username',
    isRequired: true,
    isAutoFocus: true,
    maxLength: 255,
    validateSync: (final String value) {
      if (value.isEmpty) return 'Email is Required';
      return null;
    },
  );

  final CustomTextController<String> _passwordController = CustomTextController<String>.onlyText(
    labelText: 'Password',
    hintText: 'Password',
    isRequired: true,
    isObscureText: true,
    maxLength: 255,
    validateSync: (final String value) {
      if (value.length < 4) return 'Password must be at least 4 characters long';
      return null;
    },
  );

  @override
  void initState() {
    super.initState();
    _usernameController.state.addListener(_onFormValueChanged);
    _passwordController.state.addListener(_onFormValueChanged);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFormValueChanged() {
    final bool isUsernameValid = _usernameController.state.value == UiState.success;
    final bool isPasswordValid = _passwordController.state.value == UiState.success;

    final ButtonState buttonState = isUsernameValid && isPasswordValid
        ? ButtonState.enabled
        : ButtonState.disabled;
    context.read<LoginBloc>().add(LoginEvent.buttonStateChanged(buttonState));
  }

  void _onLoginButtonPressed() {
    final String username = _usernameController.data.value!;
    final String password = _passwordController.data.value!;
    context.read<LoginBloc>().add(LoginEvent.login(username: username, password: password));
  }

  void _onLoginStatusChanged(final BuildContext context, final LoginState state) {
    if (state.loginStatus.isSuccess) {
      unawaited(context.router.replaceAll([const SplashRoute()]));
    }

    if (state.loginStatus.isFailure) {}
  }

  @override
  Widget build(final BuildContext context) => BlocListener<LoginBloc, LoginState>(
    listenWhen: (final LoginState previous, final LoginState next) =>
        previous.loginStatus != next.loginStatus,
    listener: _onLoginStatusChanged,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              spacing: 12,
              children: [
                // Email field
                CustomTextField<String>(customTextController: _usernameController),

                // Password field
                CustomTextField<String>(customTextController: _passwordController),

                // Error message
                BlocSelector<LoginBloc, LoginState, LoginStatus>(
                  selector: (final state) => state.loginStatus,
                  builder: (final context, final loginStatus) => Visibility(
                    visible: loginStatus.isFailure,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email and password do not match',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),

                // Login button
                LoginButton(onPressed: _onLoginButtonPressed),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class LoginButton extends StatelessWidget {
  const LoginButton({required this.onPressed, super.key});

  final void Function() onPressed;

  @override
  Widget build(final BuildContext context) => BlocSelector<LoginBloc, LoginState, ButtonState>(
    selector: (final LoginState state) => state.buttonState,
    builder: (final BuildContext context, final ButtonState buttonState) =>
        CustomButton.blue(state: buttonState, text: 'Login', onTap: onPressed),
  );
}
