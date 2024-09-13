import 'dart:async';

import 'package:dingtalk_sdk/response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dingtalk_sdk_platform_interface.dart';

/// An implementation of [DingtalkSdkPlatform] that uses method channels.
class MethodChannelDingtalkSdk extends DingtalkSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dingtalk_sdk')..setMethodCallHandler(_handler);

  static StreamController<BaseResponse> _dingtalkResponseEventHandler = new StreamController.broadcast();

  static Stream<BaseResponse> get dingtalkResponseEventHandler => _dingtalkResponseEventHandler.stream;

  static Future<dynamic> _handler(MethodCall methodCall) {
    _dingtalkResponseEventHandler.add(BaseResponse.create(methodCall.method, methodCall.arguments));

    return Future.value(true);
  }

  @override
  Future<bool?> registerAppWithIdentifierForOrgApp(String appId, String bundleId) async {
    return await methodChannel.invokeMethod<bool>('registerAppWithIdentifierForOrgApp', {'appId': appId, 'bundleId': bundleId});
  }

  @override
  Future<bool?> sendAuthForOrgApp(String redirectUrl, {String responseType = 'code', String scope = 'openid', String prompt = 'consent', String state = '', String nonce = ''}) async {
    return await methodChannel.invokeMethod<bool>('sendAuthForOrgApp', {
      'redirectUrl': redirectUrl,
      'responseType': responseType,
      'scope': scope,
      'prompt': prompt,
      'state': state,
      'nonce': nonce,
    });
  }

  @override
  Future<bool?> isDingtalkInstalled() async {
    return await methodChannel.invokeMethod<bool>('isDingtalkInstalled');
  }
}
