import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: SettingsPage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Center(child: Text(context.read<AppBloc>().state.status.toString())),
    );
  }
}
