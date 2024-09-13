#import "DingtalkSdkPlugin.h"
#import "ViewController.h"
#import <ADTOpenAuthSDK/ADTOpenAuthAPI.h>
#import <ADTOpenAuthSDK/ADTOpenAuthObject.h>

@interface DingtalkSdkPlugin ()<ADTOpenAuthAPIDelegate>{
    FlutterMethodChannel *_channel;
    NSString *_appId;
}
@end

@implementation DingtalkSdkPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"dingtalk_sdk"
                                     binaryMessenger:[registrar messenger]];
    DingtalkSdkPlugin* instance = [[DingtalkSdkPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    [instance setChannel:channel];
    [registrar addApplicationDelegate:instance];
}

-(void)setChannel:(FlutterMethodChannel *)channel{
    _channel=channel;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"registerAppWithIdentifierForOrgApp" isEqualToString:call.method]) {
      NSDictionary < NSString * , id > *args = (NSDictionary < NSString * , id > *)[call arguments];
      NSString *appId = (NSString *) args[@"appId"];
      _appId = appId;
      NSString *bundleId = (NSString *) args[@"bundleId"];
      BOOL registerResult2 = [ADTOpenAuthAPI registerApp:appId identifier:bundleId];
//      NSLog(@"[FlutterDDShareLog]:注册Auth API==>%@", registerResult2 ? @"YES" : @"NO");
      result(@(registerResult2));
  } else if ([@"sendAuthForOrgApp" isEqualToString:call.method]) {
      ViewController * vc = [[ViewController alloc] init];
      
      NSDictionary<NSString *,id> *args=(NSDictionary<NSString *,id> *)[call arguments];
      NSString* redirectUrl=(NSString*) args[@"redirectUrl"];
      NSString* responseType=(NSString*) args[@"responseType"];
      NSString* scope=(NSString*) args[@"scope"];
      NSString* prompt=(NSString*) args[@"prompt"];
      NSString* state=(NSString*) args[@"state"];
      NSString* nonce=(NSString*) args[@"nonce"];
      
      // send oauth request
      ADTOpenAuthReq *req = [ADTOpenAuthReq new]; // 必选参数
      req.redirectUrl = redirectUrl;
      req.responseType = responseType;
      req.scope = scope;
      req.prompt = prompt;
      req.state = state;
      req.nonce = nonce;
      
      result([NSNumber numberWithBool:[vc sendDingtalkAuth:req]]);
  } else if ([@"isDingtalkInstalled" isEqualToString:call.method]) {
      result(@([ADTOpenAuthAPI isDingTalkInstalled]));
  } else {
    result(FlutterMethodNotImplemented);
  }
}


//// 在app delegate链接处理回调中调用钉钉回调链接处理方法
-(BOOL)handleOpenURL:(NSURL*)url{
    // URL回调判断是钉钉回调
    if ([url.scheme isEqualToString:_appId]) {
//        if([DTOpenAPI handleOpenURL:url delegate:self]){
//            NSLog(@"[FlutterDDShareLog]onpenURL===>%@", url);
//        }
        if([ADTOpenAuthAPI handleOpenURL:url delegate:self]){
            NSLog(@"[FlutterADTOpenAuthLog]回调获得的uri===>%@", url);
        }
        return YES;
    }
    return NO;
}

// delegate实现回调处理方法 onResp:
- (void)onResp:(NSObject *)resp {
    //授权登录回调参数为ADTOpenAuthResp，authCode为授权码
    if([resp isKindOfClass:[ADTOpenAuthResp class]]) {
        ADTOpenAuthResp *authResp = (ADTOpenAuthResp *)resp;
        // 将授权码交给Flutter端
        NSDictionary * result = @{
                @"authCode":authResp.authCode,
                @"error": [[NSNumber numberWithLongLong:authResp.respCode] stringValue],
                @"errStr":authResp.respMessage,
                @"state":authResp.state,
        };
        [_channel invokeMethod:@"onAuthResp" arguments:result];
//    }else if([resp isKindOfClass:[DTSendMessageToDingTalkResp class]]){
//
//        DTSendMessageToDingTalkResp *authResp = (DTSendMessageToDingTalkResp *)resp;
//        // 将授权码交给Flutter端
//        NSLog(@"[FlutterDDShareLog]授权码回调=====>");
//        NSDictionary * result=@{
//                @"mTransaction":@"",
//                @"mErrCode":@(authResp.errorCode),
//                @"mErrStr":authResp.errorMessage,
//                @"type":@""
//        };
//        [_channel invokeMethod:@"onShareResponse" arguments:result];
    }
}

#pragma ApplicatioonLifeCycle
/**
 * Called if this has been registered for `UIApplicationDelegate` callbacks.
 *
 * @return `YES` if this handles the request.
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [self handleOpenURL:url];
}
/**
 * Called if this has been registered for `UIApplicationDelegate` callbacks.
 *
 * @return `YES` if this handles the request.
 */
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url{
    return [self handleOpenURL:url];
}
/**
 * Called if this has been registered for `UIApplicationDelegate` callbacks.
 *
 * @return `YES` if this handles the request.
 */
- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation{
    return [self handleOpenURL:url];
}
@end
