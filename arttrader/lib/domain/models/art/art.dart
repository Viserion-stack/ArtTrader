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
  final String? name;
  final String? imageUrl;
  final List<Bid>? biddigHistory;
  final int? price;

  /// {@macro art}
  const Art({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.biddigHistory,
    required this.price,
  });

  factory Art.fromJson(Map<String, dynamic> json, String id) {
    print("///////");

    List<Bid> biddingHistory = [];
    final bids = json['biddingHistory'];
    if (bids != null) {
      bids.forEach((data) => biddingHistory.add(Bid(
            bidderName: data['bidderName'],
            timeStamp: (data['timestamp'] as Timestamp).toDate(),
            bidAmount: data['bidAmount'],
          )));
    }
    return Art(
      id: id,
      name: json['name'],
      imageUrl: json['imageUrl'],
      biddigHistory: biddingHistory,
      price: json['price'],
    );
  }

  List<Bid> bidsHistory(Map<String, dynamic> json) {
    List<Bid> biddingHistory = [];
    biddingHistory = json['biddingHistory'].map((data) {
      biddingHistory.add(Bid(
        bidderName: data['bidderName'],
        timeStamp: (data['timestamp'] as Timestamp).toDate(),
        bidAmount: data['bidAmount'].toDouble(),
      ));
      //   return Bid(
      //     bidderName: data['bidderName'],
      //     timeStamp: (data['timestamp'] as Timestamp).toDate(),
      //     bidAmount: data['bidAmount'].toDouble(),
      //   );
      // }).toList();
    });
    print(biddingHistory.length);
    return biddingHistory;
  }

  Map<String, dynamic> toJson() =>
      {'imageUrl': imageUrl, 'name': name, 'price': price};

  /// Empty art.
  static const emptyArt =
      Art(id: '', name: '', imageUrl: '', biddigHistory: [], price: 0);
  //Art(id: '', name: '', imageUrl: '', price: 0);
  @override
  List<Object?> get props => [id, name, imageUrl, biddigHistory, price];
  //List<Object?> get props => [id, name, imageUrl, price];
}
