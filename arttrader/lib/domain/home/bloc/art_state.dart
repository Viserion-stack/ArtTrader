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
  final AuthenticationRepository? authenticationRepository;
  final List<Art>? artCollection;
  final List<Art>? myCollection;
  final List<Art>? bidsCollection;
  final Art? art;
  final int lastListIndex;
  const ArtState({
    required this.status,
    required this.artCollection,
    this.myCollection,
    this.bidsCollection,
    this.collection,
    this.authenticationRepository,
    this.art,
    this.lastListIndex = 0,
  });

  //const ArtState.initial() : this._(status: ArtStatus.loading);
  @override
  List<Object?> get props => [
        status,
        collection,
        artCollection,
        myCollection,
        bidsCollection,
        authenticationRepository,
        art,
        lastListIndex,
      ];

  ArtState copyWith({
    ArtStatus? status,
    FirebaseFirestore? collection,
    List<Art>? artCollection,
    List<Art>? myCollection,
    List<Art>? bidsCollection,
    Art? art,
    int? lastListIndex,
  }) {
    return ArtState(
      status: status ?? this.status,
      collection: collection ?? this.collection,
      artCollection: artCollection ?? this.artCollection,
      myCollection: myCollection ?? this.myCollection,
      bidsCollection: bidsCollection ?? this.bidsCollection,
      art: art ?? this.art,
      lastListIndex: lastListIndex ?? this.lastListIndex,
    );
  }

  // List<Art> getArtsByUser() {
  //   List<Art> artList = [];
  //   try {
  //     final user = authenticationRepository!.currentUser.email;
  //     print(user);

  //     artList =
  //         artCollection!.where((element) => element.addedBy == user).toList();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   return artList;
  // }

  // List<Art> getArtsBidsByUser(String userName) {
  //   List<Art> filteredArts = [];
  //   for (Art art in artCollection!) {
  //     List<Bid> biddingHistory = art.biddingHistory!;

  //     for (Bid bid in biddingHistory) {
  //       if (bid.bidderName == userName) {
  //         filteredArts.add(art);
  //         break;
  //       }
  //     }
  //   }
  //   return filteredArts;
  // }
}
