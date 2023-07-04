part of 'camera_bloc.dart';

sealed class CameraEvent {
  const CameraEvent();
}

final class OpenCamera extends CameraEvent {
  const OpenCamera();
}

final class CameraError extends CameraEvent {
  final CameraException errorMessage;
  const CameraError(this.errorMessage);
}

final class TakePhotoRequest extends CameraEvent {
  const TakePhotoRequest();
}

final class PhotoTaken extends CameraEvent {
  final String image;
  const PhotoTaken(this.image);
}

final class CloseModal extends CameraEvent {
  const CloseModal();
}
