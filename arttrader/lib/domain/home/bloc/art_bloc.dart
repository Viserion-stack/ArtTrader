import 'package:arttrader/domain/models/art/bid.dart';
import 'package:arttrader/domain/repositories/Art/art_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/art/art.dart';
import '../../repositories/Authentication/authentication.dart';

part 'art_event.dart';
part 'art_state.dart';

class ArtBloc extends Bloc<ArtEvent, ArtState> {
  final ArtRepository _artRepository;
  final AuthenticationRepository? _authenticationRepository;

  ArtBloc(
      {required ArtRepository artRepository,
      AuthenticationRepository? authenticationRepository})
      : _artRepository = artRepository,
        _authenticationRepository = authenticationRepository,
        super(const ArtState(status: ArtStatus.initial, artCollection: [])) {
    //on<GetCollecionRequested>(_onGetDataCollection);
    on<GetArtsRequested>(_onGetArtDataCollection);
    on<GetMyBidList>(_onGetMyBidList);
    on<GetMyArtList>(_onGetMyArtList);
    on<GetSelectedArt>(_onGetSelectedArt);
    on<AddItemToCollectionRequested>(_onAddItemToCollectionRequested);
    on<PlaceBidRequested>(_onPlaceBidRequested);
    on<DeleteArtRequested>(_onDeleteArtRequested);
    on<SetListIndex>(_onSetListIndex);
  }

  void _onSetListIndex(SetListIndex event, Emitter<ArtState> emit) {
    emit(state.copyWith(lastListIndex: event.index));
  }

  Future<void> _onGetMyBidList(
      GetMyBidList event, Emitter<ArtState> emit) async {
    emit(state.copyWith(status: ArtStatus.loading));

    final username = _authenticationRepository!.currentUser.email;
    List<Art> filteredArts = [];
    for (Art art in state.artCollection!) {
      List<Bid> biddingHistory = art.biddingHistory!;

      for (Bid bid in biddingHistory) {
        if (bid.bidderName == username) {
          filteredArts.add(art);
          break;
        }
      }
    }
    emit(
        state.copyWith(status: ArtStatus.succes, bidsCollection: filteredArts));
  }

  Future<void> _onGetMyArtList(
      GetMyArtList event, Emitter<ArtState> emit) async {
    emit(state.copyWith(status: ArtStatus.loading));
    try {
      final username = _authenticationRepository!.currentUser;
      List<Art> myArtlist = state.artCollection!
          .where((element) => element.addedBy == username.email)
          .toList();
      emit(state.copyWith(status: ArtStatus.succes, myCollection: myArtlist));
    } catch (e) {
      emit(state.copyWith(status: ArtStatus.error));
    }
  }

  void _onGetArtDataCollection(
      GetArtsRequested event, Emitter<ArtState> emit) async {
    emit(state.copyWith(status: ArtStatus.loading));
    await Future.delayed(const Duration(seconds: 2), () {});
    try {
      final result = await _artRepository.getArts();
      emit(state.copyWith(status: ArtStatus.succes, artCollection: result));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: ArtStatus.error));
    }
  }

  void _onGetSelectedArt(GetSelectedArt event, Emitter<ArtState> emit) {
    final artIndex =
        state.artCollection!.indexWhere((element) => element.id == event.artId);
    final selectedArt = state.artCollection![artIndex];
    emit(state.copyWith(art: selectedArt));
    //debugPrint(selectedArt.toString());
  }

  Future<void> _onAddItemToCollectionRequested(
      AddItemToCollectionRequested event, Emitter<ArtState> emit) async {
    try {
      await _artRepository.addArt(event.artToAdd);
      emit(state.copyWith(status: ArtStatus.succes));
    } catch (e) {
      emit(state.copyWith(status: ArtStatus.error));
    }
  }

  Future<void> _onPlaceBidRequested(
      PlaceBidRequested event, Emitter<ArtState> emit) async {
    try {
      await _artRepository.placeBid(event.art, event.bid);
      emit(state.copyWith(
        status: ArtStatus.succes,
      ));
    } catch (e) {
      emit(state.copyWith(status: ArtStatus.error));
    }
  }

  Future<void> _onDeleteArtRequested(
      DeleteArtRequested event, Emitter<ArtState> emit) async {
    try {
      await _artRepository.deleteArt(event.art);
      emit(state.copyWith(status: ArtStatus.succes));
    } catch (e) {
      emit(state.copyWith(status: ArtStatus.error));
    }
  }
}
