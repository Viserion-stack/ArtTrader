import '../../../export.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.home:
      return [HomePage.page()];
    case AppStatus.search:
      return [SearchPage.page()];
    case AppStatus.add:
      return [AddPage.page()];
    case AppStatus.bids:
      return [BidsPage.page()];
    case AppStatus.settings:
      return [SettingsPage.page()];
    case AppStatus.details:
      return [DetailsPage.page()];
  }
}
