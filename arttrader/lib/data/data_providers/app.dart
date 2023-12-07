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
            BlocProvider<CameraBloc>(
              create: (_) => CameraBloc(),
            ),
            BlocProvider<ConectivityBloc>(
              create: (context) => ConectivityBloc()..add(ConectivityObserve()),
            ),
            ChangeNotifierProvider(
              create: (context) => SearcHistoryState()..loadFromPrefs(),
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
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          //locale: const Locale('pl'),
          supportedLocales: AppLocalizations.supportedLocales,
          theme: CustomTheme.darkTheme,
          home: Scaffold(
            //appBar: CustomAppBar(userEmail: context.select((value) => null), userPhotoUrl: userPhotoUrl),
            body: BlocConsumer<ConectivityBloc, ConectivityState>(
              listener: (context, state) {
                if (state.status == ConectivityStatus.offline) {
                  SnackbarHelper.showSnackBar(
                    context,
                    context.strings.connectionOffline,
                  );
                } else if (state.status == ConectivityStatus.online) {
                  SnackbarHelper.showSnackBar(
                    context,
                    context.strings.connectionOnline,
                  );
                }
              },
              builder: (context, state) {
                return FlowBuilder<AppStatus>(
                  state: context.select((AppBloc bloc) => bloc.state.status),
                  onGeneratePages: onGenerateAppViewPages,
                  observers: [
                    HeroController(),
                  ],
                );
              },
            ),

            bottomNavigationBar: state.status == AppStatus.unauthenticated
                ? null
                : const CustomBottomBar(),
          ),
        );
      },
    );
  }
}
