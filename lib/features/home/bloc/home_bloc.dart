import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/domain/domain.dart';
import 'package:userapp/injection_container.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  HomeBloc(this._authRepository, this._userRepository) : super(const HomeState()) {
    on<_OnFetchInitialUsers>(_onFetchInitialList);
    on<_OnFetchNextPage>(_onFetchNextPage);
    on<_Logout>(_onLogout);
  }

  void _onFetchInitialList(final _OnFetchInitialUsers event, final Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final Result<List<User>> usersRes = await _userRepository.getUsers(page: state.page);

    if (usersRes is Error<List<User>>) {
      log('err: ${usersRes.error}', name: 'HomeBloc');
      emit(state.copyWith(status: HomeStatus.failure));
      return;
    }

    final List<User> users = (usersRes as Ok<List<User>>).value;

    emit(state.copyWith(status: HomeStatus.success, page: 0, users: users));
  }

  void _onFetchNextPage(final _OnFetchNextPage event, final Emitter<HomeState> emit) async {}

  Future<void> _onLogout(final _Logout event, final Emitter<HomeState> emit) async {
    emit(state.copyWith(logoutButtonState: ButtonState.loading, logoutStatus: HomeStatus.initial));

    final Result<void> logoutRes = await _authRepository.logout();
    if (logoutRes is Error<void>) {
      log('err: ${logoutRes.error}', name: 'HomeBloc');
      emit(
        state.copyWith(logoutButtonState: ButtonState.enabled, logoutStatus: HomeStatus.failure),
      );
      return;
    }

    await getIt<AppRouter>().replaceAll([const SplashRoute()]);

    emit(state.copyWith(logoutButtonState: ButtonState.enabled, logoutStatus: HomeStatus.success));
  }
}
