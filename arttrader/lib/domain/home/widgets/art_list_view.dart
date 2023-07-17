import 'package:arttrader/domain/models/art/art.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
        : CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: artList.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Container(
//TODO app Insets
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
              initialPage: 0,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlay: true,
              scrollDirection: Axis.vertical,
              enlargeCenterPage: false,
              viewportFraction: 1,
            ),
          );
  }
}
