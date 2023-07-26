import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(const CameraState(status: CameraStatus.initial)) {
    //on<CameraEvent>((event, emit) {});

    on<OpenCamera>(_onOpenCamera);
    on<TakePhotoRequest>(_onTakePhotoRequested);
    on<PhotoTaken>(_onPhotoTaken);
    on<CameraError>(_onCameraError);
    on<CloseModal>(_onCloseModal);
  }

  Future<void> _onOpenCamera(
      OpenCamera event, Emitter<CameraState> emit) async {
    emit(state.copyWith(status: CameraStatus.initial));
  }

  Future<void> _onTakePhotoRequested(
      TakePhotoRequest event, Emitter<CameraState> emit) async {
    emit(state.copyWith());
  }

  Future<void> _onPhotoTaken(
      PhotoTaken event, Emitter<CameraState> emit) async {
    emit(state.copyWith(
      image: event.image,
      isModalOpen: true,
    ));
  }

  Future<void> _onCloseModal(
      CloseModal event, Emitter<CameraState> emit) async {
    emit(state.copyWith(
      isModalOpen: false,
    ));
  }

  Future<void> _onCameraError(
      CameraError event, Emitter<CameraState> emit) async {
    emit(state.copyWith(status: CameraStatus.error));
  }
}
