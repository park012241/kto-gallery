import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../models/gallery_list.dart';
import 'gallery_card_closed.dart';
import 'gallery_card_open.dart';

class GalleryCard extends StatelessWidget {
  const GalleryCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final GalleryListItem item;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      clipBehavior: Clip.antiAlias,
      transitionDuration: const Duration(milliseconds: 200),
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      closedElevation: 4,
      closedColor: Theme.of(context).cardColor,
      openColor: Colors.transparent,
      openBuilder: galleryCardOpenedBuilder(item),
      closedBuilder: galleryCardClosedBuilder(item),
    );
  }
}
