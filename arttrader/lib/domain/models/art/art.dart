import 'package:equatable/equatable.dart';

class Art extends Equatable {
  /// The current art id.
  /// The current art name
  /// The current art price
  final String? id;
  final String? name;
  final int? price;

  /// {@macro art}
  const Art({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Art.fromJson(Map<String, dynamic> json) {
    return Art(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }

  /// Empty art.
  static const emptyArt = Art(id: '', name: '', price: 0);
  @override
  List<Object?> get props => [id, name, price];
}
