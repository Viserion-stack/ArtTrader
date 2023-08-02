import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/utils/network_helper.dart';

part 'conectivity_event.dart';
part 'conectivity_state.dart';

class ConectivityBloc extends Bloc<ConectivityEvent, ConectivityState> {
  ConectivityBloc._() : super(const ConectivityState.initial()) {
    on<ConectivityObserve>(_observe);
    on<Online>(_online);
    on<Offline>(_offline);
  }
  static final ConectivityBloc _instance = ConectivityBloc._();

  factory ConectivityBloc() => _instance;

  void _observe(event, emit) {
    NetworkHelper.observeNetwork();
  }
  void _online(Online event, emit) {
    emit(const ConectivityState.online());
  }

  void _offline(Offline event, emit) {
    emit(const ConectivityState.offline());
  }
}
