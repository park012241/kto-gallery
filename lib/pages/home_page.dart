import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kto_gallery/models/gallery_list.dart';
import 'package:kto_gallery/providers/gallery_list.dart';

@RoutePage<void>()
class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Check current page is last page
    // TODO: Add error handling
    // TODO: Add loading indicator
    // TODO: Add refresh feature
    final page = useState<int>(1);

    final query = useMemoized(
      () => GalleryListQuery(
        page: page.value,
        rows: 20,
      ),
      [page.value],
    );
    final itemList = useState<List<GalleryListItem>>([]);
    final items = ref.watch(getItemsProvider(query));

    final scrollController = useScrollController();

    items.whenData((data) {
      itemList.value = [...itemList.value, ...data];
    });

    useEffect(() {
      final controller = scrollController;

      void callback() {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          page.value++;
        }
      }

      controller.addListener(callback);

      return () {
        controller.removeListener(callback);
      };
    }, [scrollController]);

    final goToTopCallback = useCallback(() async {
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      itemList.value = [];
      page.value = 1;
    }, []);

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text('Title'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text(itemList.value[index].title),
                );
              },
              childCount: itemList.value.length,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToTopCallback,
        tooltip: 'Go To Top',
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
