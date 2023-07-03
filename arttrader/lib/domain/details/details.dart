import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/routes/widget/page_widget.dart';
import '../home/bloc/art_bloc.dart';
import '../models/art/art.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});
  static Page<void> page() => const MyPage<void>(child: DetailsPage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.read<AppBloc>().add(const AppPageChanged(AppStatus.home));
          },
        ),
      ),
      body: BlocBuilder<ArtBloc, ArtState>(
        builder: (context, state) {
          Art selectedArt = state.art!;
          return Center(
              child: Column(
            children: [
              Text(context.read<AppBloc>().state.status.toString()),
              Hero(
                tag: selectedArt.id!,
                child: Image.network(selectedArt.imageUrl!),
              ),
            ],
          ));
        },
      ),
    );
  }
}
