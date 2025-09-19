part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isFailure => this == LoginStatus.failure;
}

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    @Default(ButtonState.disabled) final ButtonState buttonState,
    @Default(LoginStatus.initial) final LoginStatus loginStatus,
  }) = _LoginState;
}
