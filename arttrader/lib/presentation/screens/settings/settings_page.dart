import 'package:arttrader/export.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: SettingsPage());
  @override
  Widget build(BuildContext context) {
    final previousStatus = context.read<AppBloc>().state.previousStatus;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.read<AppBloc>().state.status.toString()),
          Text(previousStatus.toString()),
          CupertinoButton(
              child: const Text('log out'),
              onPressed: () {
                context.read<AppBloc>().add(const AppLogoutRequested());
              })
        ],
      )),
    );
  }
}
