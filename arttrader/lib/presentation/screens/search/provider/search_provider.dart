import '../../../../export.dart';

class SearcHistoryState extends ChangeNotifier {
  List<String> searcHistory = [];

  Future<void> loadFromPrefs() async {
    print('loaded searcHistory form prefs');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searcHistory = prefs.getStringList('searchHistory') ?? [];
    notifyListeners();
    print(searcHistory);
  }

  Future<void> saveToPrefs(List<String> newSearchHistoy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', newSearchHistoy);
    notifyListeners();
  }
}
