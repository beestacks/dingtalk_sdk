package com.atishoo.dingtalk.dingtalk_sdk

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.android.dingtalk.openauth.AuthLoginParam
import com.android.dingtalk.openauth.DDAuthApiFactory
import com.android.dingtalk.openauth.IDDAuthApi
import com.atishoo.dingtalk.dingtalk_sdk.constant.CallbackResult
import com.atishoo.dingtalk.dingtalk_sdk.handlers.Auth
import com.atishoo.dingtalk.dingtalk_sdk.handlers.Responser
import com.atishoo.dingtalk.dingtalk_sdk.handlers.Share

/** DingtalkSdkPlugin */
class DingtalkSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "dingtalk_sdk")
    channel.setMethodCallHandler(this)
    Responser.setMethodChannel(channel)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "registerAppWithIdentifierForOrgApp") {
      val appId: String? = call.argument<String>("appId")
      if (appId.isNullOrBlank()) {
        result.error(CallbackResult.Result_APPID_NULL, "not set AppId, you should register your appid first", null)
        return
      }
      val bundleId: String? = call.argument<String>("bundleId")
      if (bundleId.isNullOrBlank()) {
        result.error(CallbackResult.Result_BUNDLEID_NULL, "not set BundleId, you should register your appid first", null)
        return
      }
      result.success(Auth.registApp(appId, bundleId))
      return
    } else if (call.method == "sendAuthForOrgApp") {
      val redirectUrl: String? = call.argument<String>("redirectUrl")
      if (redirectUrl.isNullOrBlank()) {
        result.error(CallbackResult.Result_REDIRECT_URL_NULL, "not set redirectUrl", null)
        return
      }
      val scope: String? = call.argument<String>("scope")
      if (scope.isNullOrBlank()) {
        result.error(CallbackResult.Result_SCOPE_NULL, "not set scope", null)
        return
      }

      result.success(Auth.sendAuth(redirectUrl, scope, call.argument<String>("responseType"), call.argument<String>("nonce"), call.argument<String>("state"), call.argument<String>("prompt")))
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    Auth.setRegister(null)
    Share.setRegister(null)
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    Auth.setRegister(binding.activity)
    Share.setRegister(binding.activity)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Auth.setRegister(binding.activity)
    Share.setRegister(binding.activity)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    Auth.setRegister(null)
    Share.setRegister(null)
  }
}
