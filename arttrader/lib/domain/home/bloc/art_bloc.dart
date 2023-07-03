import 'package:arttrader/domain/repositories/Art/art_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/art/art.dart';

part 'art_event.dart';
part 'art_state.dart';

class ArtBloc extends Bloc<ArtEvent, ArtState> {
  final ArtRepository _artRepository;
  ArtBloc({required ArtRepository artRepository})
      : _artRepository = artRepository,
        super(const ArtState(status: ArtStatus.initial, artCollection: [])) {
    on<GetCollecionRequested>(_onGetDataCollection);
    on<GetArtsRequested>(_onGetArtDataCollection);
    on<GetSelectedArt>(_onGetSelectedArt);
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

  void _onGetArtDataCollection(
      GetArtsRequested event, Emitter<ArtState> emit) async {
    emit(state.copyWith(status: ArtStatus.loading));
    await Future.delayed(const Duration(seconds: 2), () {});
    try {
      final result = await _artRepository.getArts();
      emit(state.copyWith(status: ArtStatus.succes, artCollection: result));
    } catch (e) {
      emit(state.copyWith(status: ArtStatus.error));
    }
  }

  void _onGetSelectedArt(GetSelectedArt event, Emitter<ArtState> emit) {
    final artIndex =
        state.artCollection!.indexWhere((element) => element.id == event.artId);
    final selectedArt = state.artCollection![artIndex];
    emit(state.copyWith(art: selectedArt));
    debugPrint(selectedArt.toString());
  }
}
