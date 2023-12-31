import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uri/uri.dart';

import '../models/gallery_list.dart';
import '../models/json_models/json_models.dart' hide GalleryListItem;
import 'environments.dart';

part 'gallery_list.g.dart';

@Riverpod(
  keepAlive: false,
  dependencies: [
    basePath,
    operatingSystemCode,
    appName,
    serviceKey,
    httpClient,
  ],
)
Future<GalleryListPayload> _getPayload(
  _GetPayloadRef ref,
  GalleryListQuery query,
) async {
  final operatingSystemCode = ref.watch(operatingSystemCodeProvider);
  final appName = ref.watch(appNameProvider);
  final serviceKey = ref.watch(serviceKeyProvider);

  final baseUrl = ref.watch(basePathProvider);
  final httpClient = ref.watch(httpClientProvider);

  const endpoint = 'galleryList1';

  final apiUri = Uri.parse('$baseUrl/$endpoint');

  final builder = UriBuilder.fromUri(apiUri);

  builder.queryParameters.addAll({
    'serviceKey': serviceKey,
    'MobileApp': appName,
    'MobileOS': operatingSystemCode,
    'numOfRows': query.rows.toString(),
    'pageNo': query.page.toString(),
    'arrange': query.arrange,
    '_type': 'json',
  });

  final uri = builder.build();

  final request = await httpClient.getUrl(uri);
  request.headers.add('Accept', 'application/json');

  final response = await request.close();

  final stringData = await response.transform(utf8.decoder).join();

  final payload = GalleryListPayload.fromJson(jsonDecode(stringData));

  return payload;
}

@Riverpod(keepAlive: false, dependencies: [_getPayload])
Future<Iterable<GalleryListItem>> getItems(
  GetItemsRef ref,
  GalleryListQuery query,
) async {
  final payload = await ref.watch(_getPayloadProvider(query).future);

  if (int.parse(payload.response.header.code) != 0) {
    throw Error();
  }

  return payload.response.body.items.item.map((e) {
    final photoMonthInt = int.parse(e.photoMonth);
    final createTimeInt = int.parse(e.createdTime);
    final modifyTimeInt = int.parse(e.modifiedTime);

    return GalleryListItem(
      contentTypeId: int.parse(e.contentTypeId),
      photoMonth: DateTime(photoMonthInt ~/ 100, photoMonthInt % 100),
      photoLocation: e.photoLocation,
      photoUrl: e.photoUrl,
      createdTime: DateTime(
        (createTimeInt ~/ 10000000000),
        (createTimeInt % 10000000000) ~/ 100000000,
        (createTimeInt % 100000000) ~/ 1000000,
        (createTimeInt % 1000000) ~/ 10000,
        (createTimeInt % 10000) ~/ 100,
        createTimeInt % 100,
      ),
      modifiedTime: DateTime(
        (modifyTimeInt ~/ 10000000000),
        (modifyTimeInt % 10000000000) ~/ 100000000,
        (modifyTimeInt % 100000000) ~/ 1000000,
        (modifyTimeInt % 1000000) ~/ 10000,
        (modifyTimeInt % 10000) ~/ 100,
        modifyTimeInt % 100,
      ),
      photographer: e.photographer,
      searchKeywords: e.searchKeyword.split(', '),
      contentId: int.parse(e.contentId),
      title: e.title,
    );
  }).toList();
}
