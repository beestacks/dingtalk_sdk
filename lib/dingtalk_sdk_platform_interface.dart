import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dingtalk_sdk_method_channel.dart';

abstract class DingtalkSdkPlatform extends PlatformInterface {
  /// Constructs a DingtalkSdkPlatform.
  DingtalkSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static DingtalkSdkPlatform _instance = MethodChannelDingtalkSdk();

  /// The default instance of [DingtalkSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelDingtalkSdk].
  static DingtalkSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DingtalkSdkPlatform] when
  /// they register themselves.
  static set instance(DingtalkSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> registerAppWithIdentifierForOrgApp(String appId, String bundleId) {
    throw UnimplementedError('registerAppWithIdentifierForOrgApp() has not been implemented.');
  }

  Future<bool?> sendAuthForOrgApp(String redirectUrl, {String responseType = 'code', String scope = 'openid', String prompt = 'consent', String state = '', String nonce = ''}) {
    throw UnimplementedError('sendAuthForOrgApp() has not been implemented.');
  }
}
