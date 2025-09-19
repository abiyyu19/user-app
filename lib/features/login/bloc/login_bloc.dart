import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/domain/domain.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required final AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const LoginState()) {
    on<_Login>(_onLogin);
    on<_ButtonStateChanged>(_onButtonStateChanged);
  }

  Future<void> _onLogin(final _Login event, final Emitter<LoginState> emit) async {
    log('username: ${event.username}', name: 'LoginBloc');
    log('password: ${event.password}', name: 'LoginBloc');

    emit(state.copyWith(buttonState: ButtonState.loading, loginStatus: LoginStatus.loading));
    final Result<User> loginRes = await _authRepository.login(
      username: event.username,
      password: event.password,
    );
    emit(state.copyWith(buttonState: ButtonState.enabled));

    if (loginRes is Error<User>) {
      log('err: ${loginRes.error}', name: 'LoginBloc');
      emit(state.copyWith(loginStatus: LoginStatus.failure));
      return;
    }

    final User user = (loginRes as Ok<User>).value;
    final Result<void> saveUserRes = await _authRepository.saveLoggedUserToSecureStorage(
      user: user,
    );
    if (saveUserRes is Error<void>) {
      log('err: ${saveUserRes.error}', name: 'LoginBloc');
      emit(state.copyWith(loginStatus: LoginStatus.failure));
      return;
    }

    emit(state.copyWith(loginStatus: LoginStatus.success));
  }

  void _onButtonStateChanged(final _ButtonStateChanged event, final Emitter<LoginState> emit) =>
      emit(state.copyWith(buttonState: event.buttonState, loginStatus: LoginStatus.initial));
}
