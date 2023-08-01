import 'package:bloc/bloc.dart';

import '../../../core/utils/network_helper.dart';

part 'conectivity_event.dart';
part 'conectivity_state.dart';

class ConectivityBloc extends Bloc<ConectivityEvent, ConectivityState> {
  ConectivityBloc._() : super(ConectivityInitial()) {
    on<ConectivityObserve>(_observe);
    on<Online>(_online);
    on<Offline>(_offline);
  }
  static final ConectivityBloc _instance = ConectivityBloc._();

  factory ConectivityBloc() => _instance;

  void _observe(event, emit) {
    NetworkHelper.observeNetwork();
  }

  // void _notifyStatus(ConectivityNotify event, emit) {
  //   event.isConnected ? emit(ConectivitySucces()) : emit(ConectivityFailure());
  // }
  void _online(Online event, emit) {
    emit(ConectivitySucces());
  }

  void _offline(Offline event, emit) {
    emit(ConectivityFailure());
  }
}
