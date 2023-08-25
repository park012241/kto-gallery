import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kto_gallery/models/gallery_list.dart';
import 'package:kto_gallery/providers/environments.dart';
import 'package:kto_gallery/providers/gallery_list.dart';

@RoutePage<void>()
class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useMemoized(() => const GalleryListQuery(page: 1), []);
    final items = ref.watch(getItemsProvider(query));

    final counter = useState(0);
    final incrementCounter = useCallback(() {
      counter.value++;
    });

    items.whenData((value) {
      if (kDebugMode) {
        print(value.first);
      }
    });

    final operatingSystemCode = ref.watch(operatingSystemCodeProvider);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Title'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current OS Code: $operatingSystemCode'),
            Text('First Item Title: ${items.when(
              data: (data) => data.first.title,
              error: (error, trace) => 'Error: ${error.toString()}',
              loading: () => 'Loading...',
            )}'),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
