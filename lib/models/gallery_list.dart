import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_list.freezed.dart';

@freezed
class GalleryListItem with _$GalleryListItem {
  const factory GalleryListItem({
    required int contentTypeId,
    required DateTime photoMonth,
    required String photoLocation,
    required String photoUrl,
    required DateTime createdTime,
    required DateTime modifiedTime,
    required String photographer,
    required Iterable<String> searchKeywords,
    required int contentId,
    required String title,
  }) = _GalleryListItem;
}

@freezed
class GalleryListQuery with _$GalleryListQuery {
  const factory GalleryListQuery({
    @Default(10) int rows,
    required int page,
    @Default('A') String arrange,
  }) = _GalleryListQuery;
}
