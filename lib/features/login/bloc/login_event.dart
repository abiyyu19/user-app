part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.started() = _Started;
  const factory LoginEvent.login({required final String username, required final String password}) =
      _Login;
  const factory LoginEvent.buttonStateChanged(final ButtonState buttonState) = _ButtonStateChanged;
}
