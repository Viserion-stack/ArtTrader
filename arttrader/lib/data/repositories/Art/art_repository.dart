import 'package:arttrader/export.dart';

/// {@template get_arts_failure}
/// Thrown during the fetching data from firestore if a failure occurs.
/// {@endtemplate}
class GetArtsFailure implements Exception {
  /// The associated error message.
  final String message;
  const GetArtsFailure([this.message = 'An uknown exception occurred.']);

  factory GetArtsFailure.fromCode(String code) {
    switch (code) {
      case 'storage/unknown':
        return const GetArtsFailure(
          'An unknown error occurred.',
        );
      case 'storage/object-not-found':
        return const GetArtsFailure(
          'TThere is no object in the requested appeal.',
        );
      case 'storage/bucket-not-found':
        return const GetArtsFailure(
          'ANo tray is configured for Cloud Storage.',
        );
      case 'storage/project-not-found':
        return const GetArtsFailure(
          'No project is configured for Cloud Storage.',
        );
      case 'storage/quota-exceeded':
        return const GetArtsFailure(
          'The limit in your Cloud Storage has been exceeded. If you use the free level, go to the paid plan. If you are using a paid plan, contact Firebase support.',
        );
      case 'storage/unauthenticated':
        return const GetArtsFailure(
          'TThe user is not authenticated, authenticate and try again.',
        );
      case 'storage/unauthorized':
        return const GetArtsFailure(
            'The user is not authorized to perform the desired action, check your safety rules to make sure they are correct.');
      case 'storage/retry-limit-exceeded':
        return const GetArtsFailure(
            'The maximum time limit of operations (upload, download, deletion, etc.) has been exceeded. Try uploading again.');
      case 'storage/invalid-checksum':
        return const GetArtsFailure(
            'The file on the client does not correspond to the checksum of the file received by the server. Try uploading again.');
      case 'storage/canceled':
        return const GetArtsFailure('The user canceled the operation.');
      case 'storage/invalid-event-name':
        return const GetArtsFailure(
            'Invalid event name provided. Must be one of [running, progress, pause]');
      case 'storage/invalid-url':
        return const GetArtsFailure(
            'Invalid URL provided to refFromURL(). Must be of the form: gs://bucket/object or https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>');
      case 'storage/invalid-argument':
        return const GetArtsFailure(
            'The argument passed to put() must be File, Blob, or UInt8 Array. The argument passed to putString() must be a raw, Base64, or Base64URL string.');
      case 'storage/no-default-bucket':
        return const GetArtsFailure(
            'No bucket has been set in your config\'s storageBucket property');
      case 'storage/cannot-slice-blob':
        return const GetArtsFailure(
            'Commonly occurs when the local file has changed (deleted, saved again, etc.). Try uploading again after verifying that the file has not changed.');
      case 'storage/server-file-wrong-size':
        return const GetArtsFailure(
            'File on the client does not match the size of the file recieved by the server. Try uploading again.');
      default:
        return const GetArtsFailure();
    }
  }
}

//  class FirestoreException implements Exception(
//   FirestoreError errorCode,
//   String message,
// )

class ArtRepository {
  /// {@macro art_repository}
  final FirebaseFirestore _firebaseFirestore;
  ArtRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  // TaskEither<GetArtsFailure, List<Art>> getCollection(
  //     {required String collectionName}) {
  //   return TaskEither<GetArtsFailure, List<Art>>(
  //     () async {
  //       try {
  //         List<Art> collectionList = [];
  //         final collection =
  //             await _firebaseFirestore.collection(collectionName).get();

  //         for (var element in collection.docs) {
  //           debugPrint(element.id);
  //           collectionList.add(Art.fromJson(element.data()));
  //         }
  //         return right(collectionList);
  //       } on FirebaseException catch (e) {
  //         return left(GetArtsFailure.fromCode(e.toString()));
  //       } catch (error) {
  //         return left(GetArtsFailure.fromCode(error.toString()));
  //       }
  //     },
  //   );
  // }

  Future<List<Art>> getArts() async {
    List<Art> artList = [];
    try {
      final collection = await _firebaseFirestore.collection('art').get();

      for (var element in collection.docs) {
        //debugPrint(element.id);
        artList.add(Art.fromJson(element.data()));
      }
      return artList;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      GetArtsFailure.fromCode(e.code);
      return artList;
    } catch (error) {
      debugPrint(error.toString());
      throw GetArtsFailure(error.toString());
    }
  }

  Future<void> addArt(Art art) async {
    try {
      CollectionReference artCollection = _firebaseFirestore.collection('art');
      DocumentReference documentRef = await artCollection.add(art.toJson());
      String artId = documentRef.id;
      await documentRef.update({'id': artId});
      debugPrint('Art added successfully with ID: $artId');
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      GetArtsFailure.fromCode(e.code);
    } catch (error) {
      debugPrint(error.toString());
      throw GetArtsFailure(error.toString());
    }
  }

  Future<void> updateLikesCount(Art art, int newLikeCount) async {
    try {
      CollectionReference artCollection = _firebaseFirestore.collection('art');
      DocumentReference documentRef = artCollection.doc(art.id);
      String artId = documentRef.id;
      await documentRef.update({'likes': newLikeCount});
      debugPrint('Likes count changed  successfully on $artId');
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      GetArtsFailure.fromCode(e.code);
    } catch (error) {
      debugPrint(error.toString());
      throw GetArtsFailure(error.toString());
    }
  }
  Future<void> updateSavedCount(Art art, int newSavedCount) async {
    try {
      CollectionReference artCollection = _firebaseFirestore.collection('art');
      DocumentReference documentRef = artCollection.doc(art.id);
      String artId = documentRef.id;
      await documentRef.update({'savedCount': newSavedCount});
      debugPrint('Saved count changed  successfully on $artId');
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      GetArtsFailure.fromCode(e.code);
    } catch (error) {
      debugPrint(error.toString());
      throw GetArtsFailure(error.toString());
    }
  }

  Future<void> deleteArt(Art art) async {
    try {
      final DocumentReference documentRef =
          FirebaseFirestore.instance.collection('artItems').doc(art.id);

      await documentRef
          .delete()
          .then((value) => debugPrint('Art item deleted succesfully'));
    } catch (e) {
      if (e is FirebaseException) {
        debugPrint('Firebase Exception: ${e.message}');
      } else {
        debugPrint('Error occurred while deleting the art item: $e');
      }
    }
  }

  Future<void> placeBid(Art art, Bid bid) async {
    try {
      CollectionReference artCollection = _firebaseFirestore.collection('art');
      final DocumentReference documentRef = artCollection.doc(art.id);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final DocumentSnapshot snapshot = await transaction.get(documentRef);

        if (snapshot.exists) {
          final List<dynamic> biddingHistory =
              (snapshot.data() as Map<String, dynamic>)['biddingHistory'] ?? [];

          biddingHistory.add({
            'bidderName': bid.bidderName,
            'timestamp': Timestamp.fromDate(bid.timeStamp!),
            'bidAmount': bid.bidAmount,
          });

          transaction.update(documentRef,
              {'biddingHistory': biddingHistory, 'price': bid.bidAmount});
        }
      });
    } on FirebaseException catch (e) {
      GetArtsFailure.fromCode(e.code);
    } catch (error) {
      throw GetArtsFailure(error.toString());
    }
  }

  // Future<List> getCollecion({required String collectionName}) async {
  //   List<dynamic> collectionList = [];

  //   try {
  //     final collection =
  //         await _firebaseFirestore.collection(collectionName).get();

  //     for (var element in collection.docs) {
  //       debugPrint(element.data().toString());
  //       collectionList.add(element.data());
  //     }
  //     // print(collection.toString());
  //     return collectionList;
  //   } on FirebaseException catch (e) {
  //     throw GetArtsFailure.fromCode(e.code);
  //   } catch (_) {
  //     throw const GetArtsFailure();
  //   }
  // }
}
