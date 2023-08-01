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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      //locale: const Locale('pl'),
      supportedLocales: AppLocalizations.supportedLocales,
      theme: CustomTheme.darkTheme,
      home: Scaffold(
        //appBar: CustomAppBar(userEmail: context.select((value) => null), userPhotoUrl: userPhotoUrl),
        body: BlocConsumer<ConectivityBloc, ConectivityState>(
          listener: (context, state) {
            if (state is ConectivityFailure) {
              SnackbarHelper.showSnackBar(context, kNoConnection);
            } else if (state is ConectivitySucces) {
              SnackbarHelper.showSnackBar(context, kConnected);
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

        bottomNavigationBar: const CustomBottomBar(),
      ),
    );
  }
}
