import 'package:equatable/equatable.dart';

class Bid extends Equatable {
  /// The current bider name.
  /// The current bid timestamp
  /// The current bit amount
  final String? bidderName;
  final DateTime? timeStamp;
  final int? bidAmount;

  /// {@macro bid}
  const Bid({
    required this.bidderName,
    required this.timeStamp,
    required this.bidAmount,
  });

  factory Bid.fromJson(Map<String, dynamic> json, String id) {
    return Bid(
      bidderName: json['bidderName'],
      timeStamp: json['timeStamp'],
      bidAmount: json['bidAmount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'bidderName': bidderName,
        'timeStamp': timeStamp,
        'bidAmount': bidAmount
      };

  /// Empty art.
  static final emptyArt =
      Bid(bidderName: '', timeStamp: DateTime.now(), bidAmount: 0);
  @override
  List<Object?> get props => [bidderName, timeStamp, bidAmount];
}
