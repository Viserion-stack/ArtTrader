import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:arttrader/domain/models/art/bid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../app/routes/widget/page_widget.dart';
import '../add/extension/xfile_extension.dart';
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
            final previousStatus = context.read<AppBloc>().state.previousStatus;
            context.read<AppBloc>().add(AppPageChanged(previousStatus));
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
              Expanded(
                flex: 2,
                child: Hero(
                  tag: selectedArt.id!,
                  child: Image.network(
                    selectedArt.imageUrl!,
                    errorBuilder: (context, error, stackTrace) {
                      return imageFromBase64String(selectedArt.imageUrl!);
                    },
                  ),
                ),
              ),
              Text('current Bid: ${state.art!.price}'),
              CupertinoButton.filled(
                  child: const Text('Place a bid by 1'),
                  onPressed: () {
                    final bid = Bid(
                        bidderName: 'TestUser',
                        timeStamp: DateTime.now(),
                        bidAmount: (state.art!.price! + 1));

                    context
                        .read<ArtBloc>()
                        .add(PlaceBidRequested(art: state.art!, bid: bid));
                  }),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedArt.biddingHistory!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(
                        selectedArt.biddingHistory![index].bidderName!,
                      ),
                      title: Text(selectedArt.biddingHistory![index].bidAmount!
                          .toString()),
                      trailing: Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(selectedArt.biddingHistory![index].timeStamp!)
                          .toString()),
                    );
                    //   trailing: Text(selectedArt
                    //       .biddigHistory![index].timeStamp!
                    //       .toString()),
                    // );
                  },
                ),
              )
            ],
          ));
        },
      ),
    );
  }
}
