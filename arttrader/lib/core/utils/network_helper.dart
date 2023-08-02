import 'package:arttrader/export.dart';

class NetworkHelper {
  static void observeNetwork() async {
    // Initialize the connectivity plugin.
    Connectivity connectivity = Connectivity();

    // Check the connectivity status before listening for changes.
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection, do something.
      //ConectivityBloc().add(Offline());
    } else {
      // There is an internet connection, listen for changes.
      connectivity.onConnectivityChanged.listen((ConnectivityResult event) {
        // Check the new connectivity status.
        switch (event) {
          case ConnectivityResult.wifi:
            ConectivityBloc().add(Online());

            debugPrint('Connected to wifi');

            break;
          case ConnectivityResult.mobile:
            debugPrint('Connected to mobile data');
            ConectivityBloc().add(Online());

            break;
          case ConnectivityResult.none:
            debugPrint('No internet connection');
            ConectivityBloc().add(Offline());

            break;

          default:
            break;
        }
      });
    }
  }
}
