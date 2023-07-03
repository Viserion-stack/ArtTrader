part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
  home,
  search,
  add,
  bids,
  settings,
  details,
}

final class AppState extends Equatable {
  final AppStatus status;
  final User user;
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.changePage(AppStatus status) : this._(status: status);
  @override
  List<Object> get props => [status, user];
}
