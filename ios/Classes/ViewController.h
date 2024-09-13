#import <UIKit/UIKit.h>
#import <ADTOpenAuthSDK/ADTOpenAuthObject.h>

@interface ViewController : UIViewController

- (BOOL)sendDingtalkAuth:(ADTOpenAuthReq*)req;

@end

