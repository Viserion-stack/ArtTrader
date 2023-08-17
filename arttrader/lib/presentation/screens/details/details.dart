import 'package:arttrader/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[0-9.]')),
                ],
                //initialValue: (state.art!.price! + 1).toString(),
                decoration: InputDecoration(
                    hintText: ((state.art!.price! + 1).toString()),
                    fillColor: Colors.white,
                    icon: const Icon(Icons.monetization_on_rounded)),
                validator: (value) {
                  int val = int.parse(value!);
                  if (value.isEmpty || val <= state.art!.price!) {
                    return 'Please enter vaild bid value';
                  }
                  return null;
                },
                onChanged: (value) {
                  //TODO: handle validation
                },
              ),
              CupertinoButton.filled(
                onPressed: () {
                  final User user = context.read<AppBloc>().getUerData;
                  final bid = Bid(
                      bidderName: user.email,
                      timeStamp: DateTime.now(),
                      bidAmount: (state.art!.price! + 1));

                  context
                      .read<ArtBloc>()
                      .add(PlaceBidRequested(art: state.art!, bid: bid));
                },
                child: Text(context.strings.palaceBid),
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
