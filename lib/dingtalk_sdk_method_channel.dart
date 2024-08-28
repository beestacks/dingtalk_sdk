import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dingtalk_sdk_platform_interface.dart';

/// An implementation of [DingtalkSdkPlatform] that uses method channels.
class MethodChannelDingtalkSdk extends DingtalkSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dingtalk_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
