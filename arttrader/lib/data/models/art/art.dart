import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'bid.dart';

class Art extends Equatable {
  /// The current art id.
  /// The current art name
  /// The current art image
  /// The current art bidding history
  /// The current art price
  final String? id;
  final String? addedBy;
  final String? name;
  final String? imageUrl;
  final List<Bid>? biddingHistory;
  final int? price;

  /// {@macro art}
  const Art({
    required this.id,
    required this.addedBy,
    required this.name,
    required this.imageUrl,
    required this.biddingHistory,
    required this.price,
  });
  factory Art.fromJson(Map<String, dynamic> json) {
    final List<Bid> biddingHistory =
        _parseBiddingHistory(json['biddingHistory']);

    return Art(
      id: json['id'],
      addedBy: json['addedBy'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      biddingHistory: biddingHistory,
      price: json['price'],
    );
  }

  static List<Bid> _parseBiddingHistory(dynamic jsonBids) {
    final List<Bid> biddingHistory = [];

    if (jsonBids is Iterable) {
      for (final dynamic bidData in jsonBids) {
        final String bidderName = bidData['bidderName'];
        final DateTime timeStamp = (bidData['timestamp'] as Timestamp).toDate();
        final dynamic bidAmount = bidData['bidAmount'];

        final Bid bid = Bid(
          bidderName: bidderName,
          timeStamp: timeStamp,
          bidAmount: bidAmount,
        );
        biddingHistory.add(bid);
      }
    }

    return biddingHistory;
  }

  // factory Art.fromJson(Map<String, dynamic> json) {
  //   List<Bid> biddingHistory = [];
  //   final bids = json['biddingHistory'];
  //   if (bids != null) {
  //     bids.forEach((String key, dynamic data) {
  //       print(data['bidderName']);
  //       biddingHistory.add(Bid(
  //         bidderName: data['bidderName'],
  //         timeStamp: (data['timestamp'] as Timestamp).toDate(),
  //         bidAmount: data['bidAmount'],
  //       ));
  //     });
  //   }
  //   return Art(
  //     id: json['id'],
  //     addedBy: json['addedBy'],
  //     name: json['name'],
  //     imageUrl: json['imageUrl'],
  //     biddigHistory: biddingHistory,
  //     price: json['price'],
  //   );
  // }

  Map<String, dynamic> toJson() => {
        'id': id,
        'addedBy': addedBy,
        'imageUrl': imageUrl,
        'name': name,
        'biddingHistory': {
          'bidAmount': price,
          'bidderName': '',
          'timestamp': DateTime.now(),
        },
        'price': price
      };

  /// Empty art.
  static const emptyArt = Art(
      id: '',
      addedBy: '',
      imageUrl: '',
      name: '',
      biddingHistory: [],
      price: 0);
  //Art(id: '', name: '', imageUrl: '', price: 0);
  @override
  List<Object?> get props =>
      [id, addedBy, imageUrl, name, biddingHistory, price];
  //List<Object?> get props => [id, name, imageUrl, price];
}
