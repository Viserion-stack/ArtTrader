part of 'art_bloc.dart';

sealed class ArtEvent {
  const ArtEvent();
}

final class GetCollecionRequested extends ArtEvent {
  final String collectionName;
  const GetCollecionRequested(this.collectionName);
}

final class AddItemToCollectionRequested extends ArtEvent {
  const AddItemToCollectionRequested();
}
