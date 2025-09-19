part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.onFetchInitialUsers() = _OnFetchInitialUsers;
  const factory HomeEvent.onFetchNextPage() = _OnFetchNextPage;
  const factory HomeEvent.logout() = _Logout;
}
