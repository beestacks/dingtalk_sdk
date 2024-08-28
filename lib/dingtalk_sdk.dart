
import 'dingtalk_sdk_platform_interface.dart';

class DingtalkSdk {
  Future<String?> getPlatformVersion() {
    return DingtalkSdkPlatform.instance.getPlatformVersion();
  }
}
