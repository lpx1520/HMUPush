//
//  AppDelegate+HMUPush.m
//  MyApp
//
//  Created by LiPengXuan on 2017/12/6.
//

#import "AppDelegate+HMUPush.h"
#import <UserNotifications/UserNotifications.h>
#import <objc/runtime.h>

@implementation AppDelegate (HMUPush)
+(void)load{
    Method origin1;
    Method swizzle1;
    origin1  = class_getInstanceMethod([self class],@selector(init));
    swizzle1 = class_getInstanceMethod([self class], @selector(init_plus));
    method_exchangeImplementations(origin1, swizzle1);
}

-(instancetype)init_plus{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidLaunch:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    return [self init_plus];
}

NSDictionary *_launchOptions;
-(void)applicationDidLaunch:(NSNotification *)notification{
    [self UMessageConfigWithOptions:nil];
}

-(void)UMessageConfigWithOptions:(NSDictionary *)launchOptions{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UpushConfig" ofType:@"plist"];
    if (plistPath == nil) {
        NSLog(@"error: UpushConfig.plist not found");
        assert(0);
    }
    NSMutableDictionary *plistData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *appkey       = [plistData valueForKey:@"UPushAppkey"];

    
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:appkey launchOptions:launchOptions];
    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
    [UMessage registerForRemoteNotifications];
    //for log
    [UMessage setLogEnabled:YES];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *deviceID  = [ud objectForKey:@"DEVICE_ID"] ;
    if (deviceID)return;//保存过就返回
    deviceID =[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                stringByReplacingOccurrencesOfString:@">" withString:@""]
               stringByReplacingOccurrencesOfString:@" " withString:@""];
    [ud setObject:deviceID forKey:@"DEVICE_ID"];
    [ud synchronize];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [UMessage setAutoAlert:NO];//关闭友盟对话框
    [UMessage didReceiveRemoteNotification:userInfo];
}

@end
