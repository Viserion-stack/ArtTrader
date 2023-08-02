import 'dart:io';

import 'package:arttrader/export.dart';

class AddArtSheetForm extends StatelessWidget {
  final XFile? image;
  const AddArtSheetForm({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddArtCubit, AddArtState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ??
                    AppLocalizations.of(context)!.addingFailed),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                splashColor: Colors.amber,
                onPressed: () {
                  Navigator.of(context).pop();
                  context
                      .read<AppBloc>()
                      .add(const AppPageChanged(AppStatus.add));
                },
                icon: const Icon(
                  Icons.close,
                ),
              ),
            ),
            //SizedBox(height: 500, child: Image.memory(imageString)),
            SizedBox(height: 500, child: Image.file(File(image!.path))),
            const SizedBox(height: 16),
            _NameInput(),
            const SizedBox(height: 8),
            _PriceInput(),
            const SizedBox(height: 8),
            _AddArtButton(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddArtCubit, AddArtState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('AddArtForm_nameInput_textField'),
          onChanged: (name) => context.read<AddArtCubit>().nameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Name',
            helperText: '',
            errorText: state.name.displayError != null ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}

class _PriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddArtCubit, AddArtState>(
        buildWhen: (previous, current) => previous.price != current.price,
        builder: (context, state) {
          return TextField(
            key: const Key('AddArtForm_priceInput_textField'),
            onChanged: (price) =>
                context.read<AddArtCubit>().priceChanged(price),
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            decoration: InputDecoration(
                labelText: 'Price',
                helperText: '',
                errorText:
                    state.price.displayError != null ? 'invalid price' : null),
          );
        });
  }
}

class _AddArtButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddArtCubit, AddArtState>(builder: (context, state) {
      return state.status.isInProgress
          ? const CircularProgressIndicator.adaptive()
          : ElevatedButton(
              key: const Key('loginForm_continue_raisedButton'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: const Color(0xFFFFD600),
              ),
              onPressed: () {
                if (state.isValid) {
                  final imageUrl = context.read<CameraBloc>().state.image;
                  context.read<AddArtCubit>().addArt(imageUrl!).then((value) {
                    SnackbarHelper.showSnackBar(
                        context, AppLocalizations.of(context)!.addingSuccess);
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Text(AppLocalizations.of(context)!.add),
            );
    });
  }
}
