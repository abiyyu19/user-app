import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/domain/domain.dart';
import 'package:userapp/features/home/bloc/home_bloc.dart';
import 'package:userapp/injection_container.dart';
import 'package:userapp/widgets/widgets.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final BuildContext context) =>
        HomeBloc(getIt(), getIt())..add(const HomeEvent.onFetchInitialUsers()),
    child: const HomeView(),
  );
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(final BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: const Text('Home'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => context.read<HomeBloc>().add(const HomeEvent.logout()),
          icon: const Icon(Icons.logout),
        ),
        const SizedBox(width: 4),
      ],
    ),
    body: SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (final BuildContext context, final HomeState state) => switch (state.status) {
          HomeStatus.success => _UserList(users: state.users),
          HomeStatus.failure => Center(
            child: CustomButton.blue(
              state: ButtonState.enabled,
              text: 'Retry',
              onTap: () => context.read<HomeBloc>().add(const HomeEvent.onFetchInitialUsers()),
            ),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    ),
  );
}

class _UserList extends StatelessWidget {
  const _UserList({required this.users});

  final List<User> users;

  @override
  Widget build(final BuildContext context) => ListView.separated(
    itemCount: users.length,
    itemBuilder: (final BuildContext context, final int index) => ListTile(
      title: Text('${users[index].firstName} ${users[index].lastName}'),
      leading: Image.network(users[index].avatar ?? ''),
    ),
    separatorBuilder: (final BuildContext context, final int index) => const Divider(),
  );
}
