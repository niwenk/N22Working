//
//  ViewController.m
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "LoginViewController.h"
#import "MAFNetworkingTool.h"
#import "MATools.h"
#import "LoginRequest.h"
#import "MJExtension.h"
#import "MABaseModel.h"
#import "MAInstance.h"
#import "MAMainViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) UIImageView *bg_image;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBgImage];
    
//    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activity.center = self.loginBtn.center;
//    [self.view addSubview:activity];
//    
//    [activity startAnimating];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)addBgImage {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"login_bg.png" ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    self.bg_image = [[UIImageView alloc] initWithImage:image];
    self.bg_image.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    [self.view addSubview:self.bg_image];
    
    [self.view sendSubviewToBack:self.bg_image];
    
//    [self downAnimate];
//    
//    [self leftAnimate];
}

#define MADuration 30

- (void)leftAnimate {
    [UIView animateWithDuration:MADuration animations:^{
        CGRect rect = self.bg_image.frame;
        rect.origin.x = CGRectGetWidth(self.view.frame)-rect.size.width;
        self.bg_image.frame = rect;
    } completion:^(BOOL finished) {
        [self rightAnimate];
    }];
    
}

- (void)rightAnimate {
    [UIView animateWithDuration:MADuration animations:^{
        CGRect rect = self.bg_image.frame;
        rect.origin.x = 0;
        self.bg_image.frame = rect;
    } completion:^(BOOL finished) {
        [self leftAnimate];
    }];
    
}

- (void)downAnimate {
    [UIView animateWithDuration:MADuration animations:^{
        CGRect rect = self.bg_image.frame;
        rect.origin.y = CGRectGetHeight(self.view.frame)-rect.size.height;
        self.bg_image.frame = rect;
    } completion:^(BOOL finished) {
        [self upAnimate];
    }];
    
}

- (void)upAnimate {
    [UIView animateWithDuration:MADuration animations:^{
        CGRect rect = self.bg_image.frame;
        rect.origin.y = 0;
        self.bg_image.frame = rect;
    } completion:^(BOOL finished) {
        [self downAnimate];
    }];
}

- (IBAction)loginBtnPressed:(id)sender {
    
    downKeyBoard();
    
    [self blowUpView:sender block:^(BOOL finish) {
        [self login];
    }];
}


- (void)blowUpView:(UIView *)view block:(void(^)(BOOL finish))finish {
    CGPoint center = view.center;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect = view.frame;
        rect.size.width += 20;
        rect.size.height += 20;
        view.frame = rect;
        view.center = center;
    } completion:finish];
}

- (void)shrinkView:(UIView *)view block:(void(^)(BOOL finish))finish  {
    CGPoint center = view.center;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect = view.frame;
        rect.size.width -= 20;
        rect.size.height -= 20;
        view.frame = rect;
        view.center = center;
    } completion:finish];
}

- (void)login {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    LoginRequest *login = [[LoginRequest alloc] init];
    login.os = @"iPhone";
    login.browser = @"Safari";
    login.username = self.usernameText.text;
    login.password = self.passwordText.text;
    
    NSString *jsonText = [login mj_JSONString];
//    @"{\"os\":\"iPhone\",\"browser\":\"Safari\",\"username\":\"niwenkang\",\"password\":\"nwk123\"}"
    [params setObject:jsonText forKey:@"opt"];

//    loadingForTextToView(@"正在登录", self.view);
    
    [MAFNetworkingTool POST:HttpTagLogin parameters:params successBlock:^(id responesObj) {
        [MABaseModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"LoginResponse"};
        }];
        MABaseModel *response = [MABaseModel mj_objectWithKeyValues:responesObj];
        NSLog(@"---%@",[response mj_JSONString]);
        [[MAInstance getInstance] setCacheInfo:response.data.firstObject];
        
        NSLog(@"----%@",response?@"登录成功":@"登录失败");
        
//        alertMBProgressHUDToView(response?@"登录成功":@"登录失败", self.view);
        
        response?[self loginSuccess] : nil ;
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
//        closeHUDToView(self.view);
        [self shrinkView:self.loginBtn block:^(BOOL finish) {
            alertMBProgressHUDToViewShowError(error, MAWindowView);
        }];
        
    }];
}

- (void)loginSuccess {
    [self shrinkView:self.loginBtn block:^(BOOL finish) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    downKeyBoard();
}
-(int)getRandomNumber:(int)from to:(int)to

{
    
    return (int)(from + (arc4random() % (to - from + 1)));
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self blowUpView:textField block:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self shrinkView:textField block:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
