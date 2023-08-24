import 'package:arttrader/export.dart';
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
                      child: CachedNetworkImage(
                        imageUrl: selectedArt.imageUrl!,
                        errorWidget: (context, error, stackTrace) {
                          return imageFromBase64String(selectedArt.imageUrl!);
                        },
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
              ),
              Text('${context.strings.currentBid} ${state.art!.price}'),
              PlaceBid(
                selectedArt: selectedArt,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedArt.biddingHistory!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: Text(
                        selectedArt.biddingHistory![index].bidderName!,
                      ),
                      title: Text(
                        selectedArt.biddingHistory![index].bidAmount!
                            .toString(),
                        textAlign: TextAlign.end,
                      ),
                      trailing: Text(DateFormat('yyyy-MM-dd \n HH:mm:ss')
                          .format(selectedArt.biddingHistory![index].timeStamp!)
                          .toString()),
                    );
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

