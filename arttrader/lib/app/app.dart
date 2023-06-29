import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:arttrader/domain/home/bloc/art_bloc.dart';
import 'package:arttrader/domain/repositories/Art/art_repository.dart';
import 'package:arttrader/domain/repositories/Authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes/routes.dart';

class App extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;
  final ArtRepository _artRepository;
  const App({
    required AuthenticationRepository authenticationRepository,
    required ArtRepository artRepository,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _artRepository = artRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (BuildContext context) =>
              AppBloc(authenticationRepository: _authenticationRepository),
        ),
        BlocProvider<ArtBloc>(
          create: (BuildContext context) =>
              ArtBloc(artRepository: _artRepository),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO theme: theme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
