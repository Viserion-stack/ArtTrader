import 'package:flutter/cupertino.dart';

import '../../../../export.dart';

class PlaceBid extends StatefulWidget {
  final Art selectedArt;

  const PlaceBid({
    required this.selectedArt,
    super.key,
  });

  @override
  State<PlaceBid> createState() => PlaceBidState();
}

class PlaceBidState extends State<PlaceBid> {
  final _formKey = GlobalKey<FormState>();
  late int newBid;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            // inputFormatters: [
            //   FilteringTextInputFormatter.deny(RegExp('^[0-9]+$')),
            // ],
            //initialValue: (state.art!.price! + 1).toString(),
            decoration: InputDecoration(
                hintText: ((widget.selectedArt.price! + 1).toString()),
                fillColor: Colors.white,
                icon: const Icon(Icons.monetization_on_rounded)),
            validator: (value) {
              int val = int.parse(value!);
              if (value.isEmpty || val <= widget.selectedArt.price!) {
                return context.strings.bidValidatorMessage;
              }
              return null;
            },
            onChanged: (value) {
              newBid = int.parse(value);
            },
          ),
          BlocBuilder<ArtBloc, ArtState>(
            builder: (context, state) {
              return state.status == ArtStatus.loading
                  ? const CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : CupertinoButton.filled(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final User user = context.read<AppBloc>().getUerData;
                          final bid = Bid(
                            bidderName: user.email,
                            timeStamp: DateTime.now(),
                            bidAmount: newBid,
                          );

                          context.read<ArtBloc>().add(PlaceBidRequested(
                              art: widget.selectedArt, bid: bid));
                        }
                      },
                      child: Text(context.strings.palaceBid),
                    );
            },
          ),
        ],
      ),
    );
  }
}
