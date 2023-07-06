import 'package:formz/formz.dart';

/// Validation errors for the [name] [FormzInput].

enum PriceValidationError {
  invalid,
}

/// {@template price}
/// Form input for an price input.
/// {@endtemplate}

class Price extends FormzInput<String, PriceValidationError> {
  /// {@macro name}
  const Price.pure() : super.pure('');

  const Price.dirty([super.value = '']) : super.dirty();

  static final RegExp _priceRegExp = RegExp(
    r'^(-?)(0|([1-9][0-9]*))(\.[0-9]+)?( ?)(€?)$',
  );

  @override
  PriceValidationError? validator(String? value) {
    return _priceRegExp.hasMatch(value ?? '')
        ? null
        : PriceValidationError.invalid;
  }
}
