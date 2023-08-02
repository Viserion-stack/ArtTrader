// ignore_for_file: unnecessary_null_comparison
import 'package:arttrader/export.dart';
import 'package:flutter/cupertino.dart';

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
    Future takePhoto() async {
      try {
        if (cameraController != null &&
            !cameraController!.value.isTakingPicture) {
          final photo = await cameraController!.takePicture();

          //return await photo.imageBase64();
          return photo;
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
            // alignment: Alignment.center,
            //fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: ArtCamera(
                  onReady: (controller) {
                    cameraController = controller;
                  },
                  onError: (error) {
                    context.read<CameraBloc>().add(CameraError(error));
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: CupertinoButton(
                  alignment: Alignment.bottomLeft,
                  onPressed: () async {
                    context.read<CameraBloc>().add(const TakePhotoRequest());
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    //final imageAsString = await image!.imageBase64();
                    // ignore: use_build_context_synchronously
                    context.read<CameraBloc>().add(PhotoTaken(image!));
                  },
                  child: const Icon(
                    Icons.photo_library_sharp,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CupertinoButton(
                  onPressed: () {},
                  child: SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        context
                            .read<CameraBloc>()
                            .add(const TakePhotoRequest());
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
        useSafeArea: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        isScrollControlled: true,
        builder: (context) {
          //Uint8List bytesImage;
          //String? imgString = state.image;
          //bytesImage = const Base64Decoder().convert(imgString!);

          return AddArtSheetForm(image: state.image);
        }).whenComplete(() {
      context.read<CameraBloc>().add(const CloseModal());
    });
  }
}
