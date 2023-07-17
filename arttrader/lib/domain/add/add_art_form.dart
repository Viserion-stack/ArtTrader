import 'dart:typed_data';

import 'package:arttrader/domain/add/bloc/camera_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'cubit/add_art_cubit.dart';

class AddArtSheetForm extends StatelessWidget {
  final Uint8List imageString;
  const AddArtSheetForm({
    Key? key,
    required this.imageString,
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
                content: Text(state.errorMessage ?? 'Adding Failure'),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.memory(imageString),
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
          key: const Key('loginForm_nameInput_textField'),
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
            key: const Key('LoginForm_priceInput_textField'),
            onChanged: (price) =>
                context.read<AddArtCubit>().priceChanged(price),
            obscureText: true,
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
                  context.read<AddArtCubit>().addArt(imageUrl!);
                }  
                
              },
              child: const Text('Add'),
            );
    });
  }
}
