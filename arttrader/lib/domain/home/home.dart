import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:arttrader/domain/home/bloc/art_bloc.dart';
import 'package:arttrader/domain/home/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                context.read<AppBloc>().add(const AppLogoutRequested()),
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Avatar(photo: user.photo),
            Text(
              user.email ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              user.name ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            BlocBuilder<ArtBloc, ArtState>(
              builder: (context, state) {
                return state.status == ArtStatus.loading
                    ? const CircularProgressIndicator.adaptive()
                    : FloatingActionButton.large(
                        onPressed: () {
                          context
                              .read<ArtBloc>()
                              .add(const GetCollecionRequested('art'));
                        },
                        child: const Text(
                          'Get cllection',
                          textAlign: TextAlign.center,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
