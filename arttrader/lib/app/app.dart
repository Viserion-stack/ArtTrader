import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:arttrader/domain/add/bloc/camera_bloc.dart';
import 'package:arttrader/domain/add/cubit/add_art_cubit.dart';
import 'package:arttrader/domain/home/bloc/art_bloc.dart';
import 'package:arttrader/domain/home/widgets/custom_bottom_bar.dart';
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
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider<AppBloc>(
        create: (BuildContext context) =>
            AppBloc(authenticationRepository: _authenticationRepository),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ArtBloc>(
              create: (BuildContext context) =>
                  ArtBloc(artRepository: _artRepository)
                    ..add(
                      const GetArtsRequested(),
                    ),
            ),
            BlocProvider<AddArtCubit>(
                create: (BuildContext context) => AddArtCubit(_artRepository)
                   
            ),
            BlocProvider<CameraBloc>(create: (_) => CameraBloc()

                //lazy: false,
                ),
          ],
          child: const AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff386a20), useMaterial3: true),
      //TODO theme: theme,
      home: Scaffold(
        //appBar: CustomAppBar(userEmail: context.select((value) => null), userPhotoUrl: userPhotoUrl),
        body: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
          observers: [
            HeroController(),
          ],
        ),
        bottomNavigationBar: const CustomBottomBar(),
      ),
    );
  }
}
