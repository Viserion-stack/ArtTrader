import 'package:arttrader/export.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authenticationRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppPageChanged>(_onAppPageChanged);
    //on<UpdatePreviousPageStatus>(_onUpdatePreviousPageStatus);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<GetCurrentUser>(_onGetCurrentUser);

    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  get getUerData => _authenticationRepository.currentUser;
  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onAppPageChanged(AppPageChanged event, Emitter<AppState> emit) {
    emit(AppState.changePage(event.status, state.status));
    debugPrint('Change app page => App Status = ${event.status}');
  }

  void _onGetCurrentUser(GetCurrentUser event, Emitter<AppState> emit) {
    final user = _authenticationRepository.currentUser;
    emit(AppState._(
        status: state.status,
        previousStatus: state.previousStatus,
        user: user));
    //return _authenticationRepository.currentUser.id;
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
