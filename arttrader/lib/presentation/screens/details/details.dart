import 'package:arttrader/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
                child: SizedBox(
                  width: double.infinity,
                  child: Hero(
                    tag: selectedArt.id!,
                    child: InteractiveViewer(
                      scaleEnabled: true,
                      constrained: true,
                      maxScale: 5,
                      child: Image.network(
                        selectedArt.imageUrl!,
                        errorBuilder: (context, error, stackTrace) {
                          return imageFromBase64String(selectedArt.imageUrl!);
                        },
                        filterQuality: FilterQuality.high,
                        //fit: BoxFit.fitWidth,
                      ),
                    ),
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