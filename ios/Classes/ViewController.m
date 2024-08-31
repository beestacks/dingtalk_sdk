#import "ViewController.h"
#import <ADTOpenAuthSDK/ADTOpenAuthAPI.h>
#import <ADTOpenAuthSDK/ADTOpenAuthObject.h>
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) UILabel *resultLabel;
@end

@implementation ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(authResponse:) name:@"ADTOpenAuthResponseNotification" object:nil];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self
                                                  name:@"ADTOpenAuthResponseNotification"
                                                object:nil];
}

- (void)authResponse:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    self.resultLabel.text = [NSString stringWithFormat:@"respCode: %@\nrespMsg: %@\nauthCode: %@\nstate: %@", userInfo[@"respCode"], userInfo[@"respMsg"], userInfo[@"authCode"], userInfo[@"state"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fuckDingtalk];
    // Do any additional setup after loading the view.
//    NSLog(@"开始执行测试");
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIStackView *stackView = [[UIStackView alloc] init];
//    stackView.axis = UILayoutConstraintAxisVertical;
//    stackView.spacing = 30;
//    [self.view addSubview:stackView];
//
//    [stackView mas_makeConstraints:^(MASConstraintMaker * _Nonnull make) {
//        make.center.equalTo(self.view);
//        make.width.mas_equalTo(350);
//    }];
//
//    UILabel *openLabel = [[UILabel alloc] init];
//    openLabel.text = @"======AppId======\n======BundleId======\n";
//    openLabel.numberOfLines = 0;
//    openLabel.textAlignment = NSTextAlignmentCenter;
//    [stackView addArrangedSubview:openLabel];
//
//    [stackView setCustomSpacing:100 afterView:openLabel];
//
//    [stackView addArrangedSubview:self.resultLabel];
//
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button addTarget:self action:@selector(fuckDingtalk) forControlEvents:UIControlEventTouchUpInside];
//    button.layer.cornerRadius = 5;
//    button.layer.borderColor = UIColor.grayColor.CGColor;
//    button.layer.borderWidth = 1;
//    [button setTitle:@"吊起授权登录" forState:UIControlStateNormal];
//    [stackView addArrangedSubview:button];
//
//
//    [button mas_makeConstraints:^(MASConstraintMaker * _Nonnull make) {
//        make.height.mas_equalTo(50);
//    }];
    
    
}

- (void)fuckDingtalk  {
    NSLog(@"点击了%hhd", [ADTOpenAuthAPI isDingTalkInstalled]);
    ADTOpenAuthReq *req = [ADTOpenAuthReq new];
        // 必选参数
    req.redirectUrl = @"http://master.test.andodo.net/admin/login/callback";
    req.responseType = @"code";
    req.scope = @"openid corpid";
    req.prompt = @"consent";
    // 建议添加一个随机数，作用见下面文档
    req.state = @"";
    req.nonce = @"123";
    
    //当H5授权时，会使用此viewController做present一个网页；如果传nil，会导致无法打开授权H5网页.
    BOOL result = [ADTOpenAuthAPI sendReq:req onViewController:self];
    NSLog(@"[FlutterDDShareLog]:注册Auth API==>%@",result?@"YES":@"NO");
    if (result) {
        NSLog(@"授权登录 发送成功.");
    } else {
        NSLog(@"授权登录 发送失败.");
    }
}

@end
