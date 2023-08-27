import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kto_gallery/models/gallery_list.dart';

CloseContainerBuilder galleryCardClosedBuilder(item) {
  return (context, action) => GalleryCardClosed(item: item, onTap: action);
}

class GalleryCardClosed extends StatelessWidget {
  const GalleryCardClosed({
    super.key,
    required this.item,
    required this.onTap,
  });

  final GalleryListItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labelBaseStyle = Theme.of(context).textTheme.labelSmall;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                margin: const EdgeInsets.all(4.0),
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
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      item.photoLocation,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        '${item.photoMonth.year}-${item.photoMonth.month.toString().padLeft(2, '0')}, ${item.photographer}',
                        overflow: TextOverflow.ellipsis,
                        style: labelBaseStyle?.copyWith(
                          color: labelBaseStyle.color?.withOpacity(0.85),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
