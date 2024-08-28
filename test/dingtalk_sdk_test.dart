import 'package:flutter_test/flutter_test.dart';
import 'package:dingtalk_sdk/dingtalk_sdk.dart';
import 'package:dingtalk_sdk/dingtalk_sdk_platform_interface.dart';
import 'package:dingtalk_sdk/dingtalk_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDingtalkSdkPlatform
    with MockPlatformInterfaceMixin
    implements DingtalkSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DingtalkSdkPlatform initialPlatform = DingtalkSdkPlatform.instance;

  test('$MethodChannelDingtalkSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDingtalkSdk>());
  });

  test('getPlatformVersion', () async {
    DingtalkSdk dingtalkSdkPlugin = DingtalkSdk();
    MockDingtalkSdkPlatform fakePlatform = MockDingtalkSdkPlatform();
    DingtalkSdkPlatform.instance = fakePlatform;

    expect(await dingtalkSdkPlugin.getPlatformVersion(), '42');
  });
}
