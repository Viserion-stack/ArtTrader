import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:arttrader/domain/add/add_page.dart';
import 'package:arttrader/domain/bids/bids_page.dart';
import 'package:arttrader/domain/details/details.dart';
import 'package:arttrader/domain/home/home.dart';
import 'package:arttrader/domain/search/search_page.dart';
import 'package:arttrader/domain/settings/settings_page.dart';
import 'package:arttrader/login/view/login_view.dart';
import 'package:flutter/widgets.dart';


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
