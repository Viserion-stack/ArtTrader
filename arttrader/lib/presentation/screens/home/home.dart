import 'package:arttrader/export.dart';
import 'widgets/art_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  @override
  Widget build(BuildContext context) {
    //final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      // appBar: CustomAppBar(
      //   userEmail: user.email!,
      //   userPhotoUrl: user.photo!,
      // ),
      body: BlocBuilder<ArtBloc, ArtState>(
        builder: (context, state) {
          return state.status == ArtStatus.loading
              ? Container(
                  color: const Color(0xFF303030),
                  child:
                      const Center(child: CircularProgressIndicator.adaptive()))
              : Align(
                  alignment: const Alignment(0, -1 / 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ArtList(artList: state.artCollection!),
                      ),
                    ],
                  ),
                );
        },
      ),
      //bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
