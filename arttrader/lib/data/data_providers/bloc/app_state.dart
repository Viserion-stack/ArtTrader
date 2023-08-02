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
  final AppStatus previousStatus;
  final User user;
  const AppState._({
    required this.status,
    this.user = User.empty,
    required this.previousStatus,
  });
  const AppState.authenticated(User user)
      : this._(
          previousStatus: AppStatus.authenticated,
          status: AppStatus.authenticated,
          user: user,
        );

  const AppState.unauthenticated()
      : this._(
          previousStatus: AppStatus.unauthenticated,
          status: AppStatus.unauthenticated,
        );

  const AppState.changePage(AppStatus status, AppStatus previousStatus)
      : this._(
          previousStatus: previousStatus,
          status: status,
          
        );

  @override
  List<Object?> get props => [status, user, previousStatus];

  
   
}
