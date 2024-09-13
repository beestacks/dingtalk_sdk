import 'package:dingtalk_sdk/response.dart';

import 'dingtalk_sdk_method_channel.dart';
import 'dingtalk_sdk_platform_interface.dart';

class DingtalkSdk {
  static Stream<BaseResponse> get dingtalkResponseEventHandler => MethodChannelDingtalkSdk.dingtalkResponseEventHandler;

  static Future<bool?> registerAppWithIdentifierForOrgApp({required String appId, required String bundleId}) {
    return DingtalkSdkPlatform.instance.registerAppWithIdentifierForOrgApp(appId, bundleId);
  }

  static Future<bool?> sendAuthForOrgApp({required String redirectUrl, String responseType = 'code', String scope = 'openid', String prompt = 'consent', String state = '', String nonce = ''}) {
    return DingtalkSdkPlatform.instance.sendAuthForOrgApp(redirectUrl, responseType: responseType, scope: scope, prompt: prompt, state: state, nonce: nonce);
  }

  static Future<bool?> isDingtalkInstalled() {
    return DingtalkSdkPlatform.instance.isDingtalkInstalled();
  }
}
