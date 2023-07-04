import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:arttrader/domain/home/bloc/art_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Animatedimage extends StatefulWidget {
  final String imageUrl;
  final int pageIndex;
  final String artId;
  const Animatedimage({
    Key? key,
    required this.imageUrl,
    required this.pageIndex,
    required this.artId,
  }) : super(key: key);

  @override
  State<Animatedimage> createState() => _AnimatedimageState();
}

class _AnimatedimageState extends State<Animatedimage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animation = CurvedAnimation(
      curve: Curves.linear,
      parent: _animationController,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {}
      });
    _animationController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => const SecondPage()));

            debugPrint('tapped ${widget.imageUrl}');
            debugPrint('tapped ${widget.pageIndex}');
            context.read<ArtBloc>().add(GetSelectedArt(widget.artId));
            context
                .read<AppBloc>()
                .add(const AppPageChanged(AppStatus.details));
          },
          child: Hero(
            tag: widget.artId,
            //tag: 'tag-1',
            child: CachedNetworkImage(
              progressIndicatorBuilder: (_, url, download) {
                if (download.progress != null) {
                  final percent = download.progress! * 100;
                  return Text('$percent% done loading');
                }
                return const Text('Loaded Url');
              },
              imageUrl: widget.imageUrl,
              //alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: FractionalOffset((_animation.value), 0),
            ),
          ),
        );
      },
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HERO'),
      ),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: 'tag-1',
              child: Container(
                width: 100,
                height: 100,
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}