import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'environments.g.dart';

const String _etc = 'ETC';
const String _android = 'AND';
const String _ios = 'IOS';

@Riverpod(keepAlive: true)
String operatingSystemCode(OperatingSystemCodeRef ref) {
  return switch (kIsWeb) {
    true => _etc,
    _ when Platform.isAndroid => _android,
    _ when Platform.isIOS => _ios,
    _ => _etc,
  };
}

@Riverpod(keepAlive: true)
String appName(AppNameRef ref) => 'KTOGallery';

@Riverpod(keepAlive: true)
String serviceKey(ServiceKeyRef ref) {
  final key = dotenv.env['KTO_GALLERY_API_ENCODED_KEY'];
  if (key == null) {
    throw Error();
  }
  return key;
}

@Riverpod(keepAlive: true)
String basePath(BasePathRef ref) {
  final key = dotenv.env['KTO_GALLERY_API_BASE'];
  if (key == null) {
    throw Error();
  }
  return key;
}
