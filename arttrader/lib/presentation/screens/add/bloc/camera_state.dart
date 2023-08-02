part of 'camera_bloc.dart';

enum CameraStatus {
  initial,
  loading,
  succes,
  error,
}

final class CameraState extends Equatable {
  final CameraStatus status;
  final XFile? image;
  final CameraController? cameraController;
  final bool? isModalOpen;

  const CameraState({
    required this.status,
    this.image,
    this.cameraController,
    this.isModalOpen,
  });

  @override
  List<Object?> get props => [status, image, CameraController, isModalOpen];

  CameraState copyWith({
    CameraStatus? status,
    XFile? image,
    CameraController? cameraController,
    bool? isModalOpen,
  }) {
    return CameraState(
      status: status ?? this.status,
      image: image ?? this.image,
      cameraController: cameraController ?? this.cameraController,
      isModalOpen: isModalOpen ?? false,
    );
  }
}
