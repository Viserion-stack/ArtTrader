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
  final List<Art>? artCollection;
  final Art? art;
  const ArtState({
    required this.status,
    required this.artCollection,
    this.collection,
    this.art,
  });

  //const ArtState.initial() : this._(status: ArtStatus.loading);
  @override
  List<Object?> get props => [status, collection, artCollection, art];

  ArtState copyWith({
    ArtStatus? status,
    FirebaseFirestore? collection,
    List<Art>? artCollection,
    Art? art,
  }) {
    return ArtState(
      status: status ?? this.status,
      collection: collection ?? this.collection,
      //artCollection: artCollection ?? [],
      artCollection: artCollection ?? this.artCollection,
      art: art ?? this.art,
    );
  }
}
