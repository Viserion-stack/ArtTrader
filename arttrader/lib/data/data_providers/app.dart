import '../../export.dart';

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
              create: (BuildContext context) => ArtBloc(
                  artRepository: _artRepository,
                  authenticationRepository: _authenticationRepository)
                ..add(
                  const GetArtsRequested(),
                ),
            ),
            BlocProvider<AddArtCubit>(
                create: (BuildContext context) =>
                    AddArtCubit(_artRepository, _authenticationRepository)),
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
      theme: CustomTheme.darkTheme,          
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
