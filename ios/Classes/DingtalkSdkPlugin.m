#import "DingtalkSdkPlugin.h"
#import "ViewController.h"
#import <ADTOpenAuthSDK/ADTOpenAuthAPI.h>
#import <ADTOpenAuthSDK/ADTOpenAuthObject.h>

@implementation DingtalkSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"dingtalk_sdk"
            binaryMessenger:[registrar messenger]];
  DingtalkSdkPlugin* instance = [[DingtalkSdkPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"registerAppWithIdentifierForOrgApp" isEqualToString:call.method]) {
      NSDictionary < NSString * , id > *args = (NSDictionary < NSString * , id > *)
      [call arguments];
      NSString *appId = (NSString *) args[@"appId"];
      NSString *bundleId = (NSString *) args[@"bundleId"];
      BOOL registerResult2 = [ADTOpenAuthAPI registerApp:appId identifier:bundleId];
      NSLog(@"[FlutterDDShareLog]:注册Auth API==>%@", registerResult2 ? @"YES" : @"NO");
      result(@(registerResult2));
  } else if ([@"sendAuthForOrgApp" isEqualToString:call.method]) {
//      ViewController* vc = [[ViewController alloc] init];
//      [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:vc animated:true completion:nil];
//      dispatch_async(dispatch_get_main_queue(), ^{
//          ViewController* vc = [[ViewController alloc] init];
////          UIViewController *yourViewController = [[UIViewController alloc] init];
////          yourViewController.view.backgroundColor = [UIColor redColor];  // 设置背景色
////          yourViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//          [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:vc animated:true completion:nil];
//      });
      
      
      
//      [[[ViewController alloc] init] fuckDingtalk];
      NSDictionary<NSString *,id> *args=(NSDictionary<NSString *,id> *)[call arguments];
      NSString* redirectUri=(NSString*) args[@"redirectUri"];
      NSString* responseType=(NSString*) args[@"responseType"];
      NSString* scope=(NSString*) args[@"scope"];
      NSString* prompt=(NSString*) args[@"prompt"];
      NSString* state=(NSString*) args[@"state"];
      NSString* nonce=(NSString*) args[@"nonce"];
      // send oauth request
      ADTOpenAuthReq *req = [ADTOpenAuthReq new]; // 必选参数
      req.redirectUrl = redirectUri;
      req.responseType = responseType;
      req.scope = scope;
      req.prompt = prompt;
      req.state = state;
      req.nonce = nonce;

//      NSLog(@"看看这是个啥%@", [[[UIApplication sharedApplication] keyWindow] rootViewController] pre);
      //当H5授权时，会使用此viewController做present一个网页；如果传nil，会导致无法打开授权H5网页.
      BOOL authResult = [ADTOpenAuthAPI sendReq:req onViewController:[[[UIApplication sharedApplication] keyWindow] rootViewController]];

      NSLog(@"看看这是个啥%hhd", authResult);
      result([NSNumber numberWithBool:authResult]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
