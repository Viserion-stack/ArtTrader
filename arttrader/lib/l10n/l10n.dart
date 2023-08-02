import 'package:arttrader/export.dart';

class L10n {
  static const all = [
    Locale('en'),
    Locale('pl'),
  ];
}


extension Strings on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
  //String get locale => strings.localeName;
}
