part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure, empty }

extension HomeStatusX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
}

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.initial) final HomeStatus status,
    @Default(HomeStatus.initial) final HomeStatus logoutStatus,
    @Default([]) final List<User> users,
    @Default(0) final int page,
    @Default(ButtonState.enabled) final ButtonState logoutButtonState,
  }) = _HomeState;
}
