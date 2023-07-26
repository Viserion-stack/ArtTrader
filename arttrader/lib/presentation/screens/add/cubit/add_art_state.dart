part of 'add_art_cubit.dart';

final class AddArtState extends Equatable {
  final Name name;
  final Price price;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const AddArtState({
    this.name = const Name.pure(),
    this.price = const Price.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });
  @override
  List<Object?> get props => [name, price, status, isValid, errorMessage];

  AddArtState copyWith({
    Name? name,
    Price? price,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return AddArtState(
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
