import 'package:arttrader/domain/repositories/Art/art_repository.dart';
import 'package:arttrader/domain/repositories/Authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../models/art/art.dart';
import '../../models/art/name.dart';
import '../../models/art/price.dart';

part 'add_art_state.dart';

class AddArtCubit extends Cubit<AddArtState> {
  final AuthenticationRepository _authenticationRepository;
  final ArtRepository _artRepository;
  AddArtCubit(this._artRepository, this._authenticationRepository)
      : super(const AddArtState());

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([state.price]),
      ),
    );
  }

  void priceChanged(String value) {
    final price = Price.dirty(value);
    emit(
      state.copyWith(
        price: price,
        isValid: Formz.validate([state.price]),
      ),
    );
  }

  Future<void> addArt(String imageUrl) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final user = _authenticationRepository.currentUser;
      final artToAdd = Art(
          id: '',
          addedBy: user.email,
          name: state.name.value,
          price: int.tryParse(state.price.value),
          biddingHistory: const [],
          imageUrl: imageUrl);
      await _artRepository.addArt(artToAdd);

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzSubmissionStatus.failure,
      ));
    } catch (error) {
      debugPrint(error.toString());

      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
