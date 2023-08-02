part of 'conectivity_bloc.dart';

enum ConectivityStatus {
  offline,
  online,
}

final class ConectivityState extends Equatable {
  final ConectivityStatus status;

  const ConectivityState._({
    required this.status,
  });

  const ConectivityState.initial()
      : this._(
          status: ConectivityStatus.offline,
        );

  const ConectivityState.online()
      : this._(
          status: ConectivityStatus.online,
        );

  const ConectivityState.offline()
      : this._(
          status: ConectivityStatus.offline,
        );

  @override
  List<Object?> get props => [status];
}
