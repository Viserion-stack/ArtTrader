import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:arttrader/domain/repositories/Art/art_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'art_event.dart';
part 'art_state.dart';

class ArtBloc extends Bloc<ArtEvent, ArtState> {
  final ArtRepository _artRepository;
  ArtBloc({required ArtRepository artRepository})
      : _artRepository = artRepository,
        super(const ArtState(status: ArtStatus.initial, artCollection: [])) {
    on<GetCollecionRequested>(_onGetDataCollection);
  }

  void _onGetDataCollection(
      GetCollecionRequested event, Emitter<ArtState> emit) async {
    emit(state.copyWith(status: ArtStatus.loading));
    await Future.delayed(const Duration(seconds: 2), () {});
    final result = await _artRepository
        .getCollection(collectionName: event.collectionName)
        .run();

    emit(
      result.match(
        (l) => state.copyWith(status: ArtStatus.error),
        (collectionArt) {
          //print(collectionArt);
          return state.copyWith(
            status: ArtStatus.succes,
            artCollection: collectionArt,
          );
        },
      ),
    );
  }
}
