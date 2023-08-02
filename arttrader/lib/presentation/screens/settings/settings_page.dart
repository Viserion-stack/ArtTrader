import 'package:arttrader/export.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: SettingsPage());
  @override
  Widget build(BuildContext context) {
    final previousStatus = context.read<AppBloc>().state.previousStatus;
    final User user = context.read<AppBloc>().getUerData;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserSection(user: user),
            CustomCard(
                title: context.strings.inviteMembers,
                icon: Icons.person_add_alt_sharp),
            CustomCard(
                title: context.strings.sendFeedback,
                icon: Icons.add_comment_sharp),
            CustomCard(
                title: context.strings.rateArtTrader, icon: Icons.rate_review),
            CustomCard(
                title: context.strings.helpCenter,
                icon: Icons.help_center_rounded),
            CustomCard(title: context.strings.about, icon: Icons.info),
            CustomCard(title: context.strings.privacyMembers, icon: Icons.lock),
            Text(context.read<AppBloc>().state.status.toString()),
            Text(previousStatus.toString()),
            CupertinoButton(
              child: Text(context.strings.logOut),
              onPressed: () {
                context.read<AppBloc>().add(const AppLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}
