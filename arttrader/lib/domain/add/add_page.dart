// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:typed_data';

import 'package:arttrader/domain/add/bloc/camera_bloc.dart';
import 'package:arttrader/domain/add/extension/xfile_extension.dart';
import 'package:arttrader/domain/add/widgets/art_camera.dart';
import 'package:arttrader/domain/home/bloc/art_bloc.dart';
import 'package:arttrader/domain/models/art/art.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AddPage());

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    CameraController? cameraController;
    Future<String?> takePhoto() async {
      try {
        if (cameraController != null &&
            !cameraController!.value.isTakingPicture) {
          final photo = await cameraController!.takePicture();

          return await photo.imageBase64();
        }
      } on Exception catch (_) {
        Navigator.of(context).pop();
      }
      return null;
    }

    return BlocListener<CameraBloc, CameraState>(
      listener: (context, state) {
        if (state.isModalOpen!) {
          showModalSheet(context, state);
        }
      },
      child: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: ArtCamera(
                  onReady: (controller) {
                    cameraController = controller;
                  },
                  onError: (error) {
                    context.read<CameraBloc>().add(CameraError(error));
                    //Navigator.of(context).pop();
                  },
                ),
              ),
              CupertinoButton(
                alignment: Alignment.bottomCenter,
                onPressed: () {},
                child: SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.read<CameraBloc>().add(const TakePhotoRequest());
                      final photoData = await takePhoto();
                      if (photoData != null) {
                        // ignore: use_build_context_synchronously
                        context.read<CameraBloc>().add(PhotoTaken(photoData));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0.0),
                      backgroundColor: Colors.transparent,
                      shape: const CircleBorder(),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 31,
                    ),
                  ),
                ),
              ),
              CupertinoButton(
                alignment: Alignment.bottomLeft,
                onPressed: () async {
                  context.read<CameraBloc>().add(const TakePhotoRequest());
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  final imageAsString = await image!.imageBase64();
                  // ignore: use_build_context_synchronously
                  context.read<CameraBloc>().add(PhotoTaken(imageAsString!));
                },
                child: const Icon(
                  Icons.photo_library_sharp,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}

void showModalSheet(BuildContext context, CameraState state) async {
  bool? isModalOpen = state.isModalOpen;
  if (isModalOpen!) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        isScrollControlled: true,
        builder: (context) {
          Uint8List _bytesImage;
          String? _imgString = state.image;
          _bytesImage = const Base64Decoder().convert(_imgString!);

          return SingleChildScrollView(
            child: Container(
              //: 500,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.memory(_bytesImage),
                  TextField(
                    onChanged: (name) {},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      helperText: '',
                    ),
                  ),
                  TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      helperText: '',
                    ),
                  ),
                  CupertinoButton(
                    color: Colors.amber,
                    onPressed: () {
                      const Art artToAdd = Art(
                          id: '1234',
                          name: 'test',
                          imageUrl: 'testImageUrl',
                          price: 123);
                      context.read<ArtBloc>().add(
                          const AddItemToCollectionRequested(
                              artToAdd: artToAdd));
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          );
        }).whenComplete(() {
      context.read<CameraBloc>().add(const CloseModal());
    });
  }
}
