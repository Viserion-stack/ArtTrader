part of 'art_bloc.dart';

sealed class ArtEvent {
  const ArtEvent();
}

// final class GetCollecionRequested extends ArtEvent {
//   final String collectionName;
//   const GetCollecionRequested(this.collectionName);
// }

final class GetArtsRequested extends ArtEvent {
  const GetArtsRequested();
}

final class OpenDetailPage extends ArtEvent {
  const OpenDetailPage();
}

final class GetSelectedArt extends ArtEvent {
  final String artId;
  const GetSelectedArt(this.artId);
}

final class AddItemToCollectionRequested extends ArtEvent {
  final Art artToAdd;
  const AddItemToCollectionRequested({
    required this.artToAdd,
  });
}

final class PlaceBidRequested extends ArtEvent {
  final Art art;
  final Bid bid;
  const PlaceBidRequested({
    required this.art,
    required this.bid,
  });
}

final class DeleteArtRequested extends ArtEvent {
  final Art art;
  const DeleteArtRequested({
    required this.art,
  });
}

final class GetMyBidList extends ArtEvent {
  const GetMyBidList();
}

final class GetMyArtList extends ArtEvent {
  const GetMyArtList();
}

final class UpdateLikeCount extends ArtEvent {
  final Art art;
  final int newLikeCount;
  const UpdateLikeCount({
    required this.art,
    required this.newLikeCount,
  });
}

final class SetListIndex extends ArtEvent {
  final int index;
  const SetListIndex(this.index);
}
