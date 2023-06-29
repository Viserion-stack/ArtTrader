part of 'art_bloc.dart';

enum ArtStatus {
  initial,
  loading,
  succes,
  error,
}

final class ArtState extends Equatable {
  final ArtStatus status;
  final FirebaseFirestore? collection;
  final List<dynamic>? artCollection;
  const ArtState({
    required this.status,
    required this.artCollection,
    this.collection,
  });

  //const ArtState.initial() : this._(status: ArtStatus.loading);
  @override
  List<Object?> get props => [status, collection, artCollection];

  ArtState copyWith({
    ArtStatus? status,
    FirebaseFirestore? collection,
    List<dynamic>? artCollection,
  }) {
    return ArtState(
      status: status ?? this.status,
      collection: collection ?? this.collection,
      artCollection: artCollection ?? [],
    );
  }
}
