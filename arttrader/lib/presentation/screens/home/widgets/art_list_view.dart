import 'package:arttrader/export.dart';
import 'animated_photo.dart';

class ArtList extends StatelessWidget {
  final CarouselController _carouselController = CarouselController();
  final List<Art> artList;
  ArtList({
    Key? key,
    required this.artList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return artList.isEmpty
        ? const CircularProgressIndicator.adaptive(semanticsValue: 'asdasds')
        : RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<ArtBloc>().add(const GetArtsRequested());
            },
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: artList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return Container(
                  color: const Color(0xFF303030),
                  child: Center(
                    child: Animatedimage(
                      imageUrl: artList[itemIndex].imageUrl!,
                      pageIndex: pageViewIndex,
                      artId: artList[itemIndex].id!,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  context.read<ArtBloc>().add(SetListIndex(index));
                },
                height: double.infinity,
                enableInfiniteScroll: false,
                initialPage: context.read<ArtBloc>().state.lastListIndex,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlay: true,
                scrollDirection: Axis.vertical,
                enlargeCenterPage: false,
                viewportFraction: 1,
              ),
            ),
          );
  }
}
