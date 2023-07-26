

import 'export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = const AppBlocObserver();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authenticationRepository = AuthenticationRepository();
  final artRepository = ArtRepository();
  await authenticationRepository.user.first;
  runApp(
    App(
      authenticationRepository: authenticationRepository,
      artRepository: artRepository,
    ),
  );
}
