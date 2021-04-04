import 'dart:io' show Platform;

T selectByPlatform<T>(T iosValue, T androidValue) {
  return Platform.isIOS == true ? iosValue : androidValue;
}
