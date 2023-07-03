part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

final class _AppUserChanged extends AppEvent {
  final User user;
  const _AppUserChanged(this.user);
}

final class AppPageChanged extends AppEvent {
  final AppStatus status;
  const AppPageChanged(this.status);
}
