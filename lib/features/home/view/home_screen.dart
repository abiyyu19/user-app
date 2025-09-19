import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userapp/features/home/bloc/home_bloc.dart';
import 'package:userapp/injection_container.dart';

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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(final BuildContext context) => const CardScannerScreen();
}

class CardScannerScreen extends StatefulWidget {
  const CardScannerScreen({super.key});

  @override
  State<CardScannerScreen> createState() => _CardScannerScreenState();
}

class _CardScannerScreenState extends State<CardScannerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => const Scaffold(
    resizeToAvoidBottomInset: false,
    body: SafeArea(child: Center(child: Text('Home'))),
  );
}
