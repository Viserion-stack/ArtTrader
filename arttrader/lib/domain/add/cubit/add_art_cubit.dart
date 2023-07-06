import 'package:arttrader/domain/repositories/Art/art_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/art/art.dart';
import '../../models/art/name.dart';
import '../../models/art/price.dart';

part 'add_art_state.dart';

class AddArtCubit extends Cubit<AddArtState> {
  final ArtRepository _artRepository;
  AddArtCubit(this._artRepository) : super(const AddArtState());

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
      final artToAdd = Art(
          id: '',
          name: state.name.value,
          price: int.tryParse(state.price.value),
          imageUrl: imageUrl);
      await _artRepository.addArt(artToAdd);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on FirebaseException catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzSubmissionStatus.failure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
