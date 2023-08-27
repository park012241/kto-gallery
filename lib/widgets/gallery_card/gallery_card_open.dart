import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kto_gallery/models/gallery_list.dart';

OpenContainerBuilder galleryCardOpenedBuilder(item) {
  return (context, action) => GalleryCardOpened(item: item, onTap: action);
}

class GalleryCardOpened extends StatelessWidget {
  const GalleryCardOpened({
    super.key,
    required this.item,
    required this.onTap,
  });

  final GalleryListItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Details'),
          ),
          SliverToBoxAdapter(
            child: Image(
              image: CachedNetworkImageProvider(item.photoUrl),
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
