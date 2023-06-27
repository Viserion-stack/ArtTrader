import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:arttrader/domain/home/home.dart';
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
  }
}
