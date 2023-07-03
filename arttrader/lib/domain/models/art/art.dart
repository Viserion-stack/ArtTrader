import 'package:equatable/equatable.dart';

class Art extends Equatable {
  /// The current art id.
  /// The current art name
  /// The current art price
  final String? id;
  final String? name;
  final String? imageUrl;
  final int? price;

  /// {@macro art}
  const Art({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory Art.fromJson(Map<String, dynamic> json, String id) {
    return Art(
      id: id,
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }

  /// Empty art.
  static const emptyArt = Art(id: '', name: '', imageUrl: '', price: 0);
  @override
  List<Object?> get props => [id, name, imageUrl, price];
}
