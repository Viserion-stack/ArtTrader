import 'package:arttrader/domain/home/bloc/art_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Align(
                  alignment: const Alignment(0, -1 / 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ArtList(
                            artList:
                                context.read<ArtBloc>().state.artCollection!),
                      ),
                      // BlocBuilder<ArtBloc, ArtState>(
                      //   builder: (context, state) {
                      //     return state.status == ArtStatus.loading
                      //         ? const CircularProgressIndicator.adaptive()
                      //         : FloatingActionButton.large(
                      //             onPressed: () {
                      //               // print(state.artCollection!.length);
                      //               context.read<ArtBloc>().add(
                      //                   const GetCollecionRequested('art'));
                      //             },
                      //             child: const Text(
                      //               'Get cllection',
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           );
                      //   },
                      // ),
                    ],
                  ),
                );
        },
      ),
      //bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
