import 'dart:io';

import 'package:arttrader/export.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<void> addArt(XFile image) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final user = _authenticationRepository.currentUser;
      String imageUrl = '';
      final Reference storageRef =
          FirebaseStorage.instance.ref('${user.email}/${image.name}');
      final UploadTask uploadTask = storageRef.putFile(File(image.path));

      // Listen for the upload task to complete
      imageUrl = await (await uploadTask).ref.getDownloadURL();

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
