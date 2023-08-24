import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_list.freezed.dart';
part 'gallery_list.g.dart';

@freezed
class GalleryListItem with _$GalleryListItem {
  const factory GalleryListItem({
    @JsonKey(name: 'galContentTypeId') required String contentTypeId,
    @JsonKey(name: 'galPhotographyMonth') required String photoMonth,
    @JsonKey(name: 'galPhotographyLocation') required String photoLocation,
    @JsonKey(name: 'galWebImageUrl') required String photoUrl,
    @JsonKey(name: 'galCreatedtime') required String createdTime,
    @JsonKey(name: 'galModifiedtime') required String modifiedTime,
    @JsonKey(name: 'galPhotographer') required String photographer,
    @JsonKey(name: 'galSearchKeyword') required String searchKeyword,
    @JsonKey(name: 'galContentId') required String contentId,
    @JsonKey(name: 'galTitle') required String title,
  }) = _GalleryListItem;

  factory GalleryListItem.fromJson(Map<String, Object?> json) =>
      _$GalleryListItemFromJson(json);
}

@freezed
class GalleryListBody with _$GalleryListBody {
  const factory GalleryListBody({
    @JsonKey(name: 'numOfRows') required int rows,
    @JsonKey(name: 'pageNo') required int page,
    @JsonKey(name: 'totalCount') required int total,
    @JsonKey(name: 'items') required GalleryListItems items,
  }) = _GalleryListBody;

  factory GalleryListBody.fromJson(Map<String, Object?> json) =>
      _$GalleryListBodyFromJson(json);
}

@freezed
class GalleryListItems with _$GalleryListItems {
  const factory GalleryListItems({
    @JsonKey(name: 'item') required GalleryListItem item,
  }) = _GalleryListItems;

  factory GalleryListItems.fromJson(Map<String, Object?> json) =>
      _$GalleryListItemsFromJson(json);
}

@freezed
class GalleryListHeader with _$GalleryListHeader {
  const factory GalleryListHeader({
    @JsonKey(name: 'resultMsg') required String message,
    @JsonKey(name: 'resultCode') required String code,
  }) = _GalleryListHeader;

  factory GalleryListHeader.fromJson(Map<String, Object?> json) =>
      _$GalleryListHeaderFromJson(json);
}

@freezed
class GalleryListResponse with _$GalleryListResponse {
  const factory GalleryListResponse({
    @JsonKey(name: 'header') required GalleryListHeader header,
    @JsonKey(name: 'body') required GalleryListBody body,
  }) = _GalleryListResponse;

  factory GalleryListResponse.fromJson(Map<String, Object?> json) =>
      _$GalleryListResponseFromJson(json);
}

@freezed
class GalleryListPayload with _$GalleryListPayload {
  const factory GalleryListPayload({
    @JsonKey(name: 'response') required GalleryListResponse header,
  }) = _GalleryListPayload;

  factory GalleryListPayload.fromJson(Map<String, Object?> json) =>
      _$GalleryListPayloadFromJson(json);
}
