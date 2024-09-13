#import "ViewController.h"
#import <ADTOpenAuthSDK/ADTOpenAuthAPI.h>
#import <ADTOpenAuthSDK/ADTOpenAuthObject.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)sendDingtalkAuth:(ADTOpenAuthReq*)req  {
    //当H5授权时，会使用此viewController做present一个网页；如果传nil，会导致无法打开授权H5网页.
    BOOL result = [ADTOpenAuthAPI sendReq:req onViewController:self];
    if (result) {
        NSLog(@"授权登录 跳转成功.");
        return true;
    } else {
        NSLog(@"授权登录 跳转失败.");
        return false;
    }
}
@end
