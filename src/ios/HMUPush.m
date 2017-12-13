/********* HMUPush.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface HMUPush : CDVPlugin {
  // Member variables go here.
}

- (void)getRemoteNotificationsDeviceId:(CDVInvokedUrlCommand*)command;
@end

@implementation HMUPush

- (void)getRemoteNotificationsDeviceId:(CDVInvokedUrlCommand*)command{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *deviceID  = [ud objectForKey:@"DEVICE_ID"] ;
    [self handleResultWithValue:deviceID command:command];
    
}
#pragma mark 将参数返回给js
-(void)handleResultWithValue:(id)value command:(CDVInvokedUrlCommand*)command {
    CDVPluginResult *result = nil;
    CDVCommandStatus status = CDVCommandStatus_OK;
    
    if ([value isKindOfClass:[NSString class]]) {
        value = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    } else if ([value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    
    if ([value isKindOfClass:[NSObject class]]) {
        result = [CDVPluginResult resultWithStatus:status messageAsString:value];//NSObject 类型都可以
    } else {
        NSLog(@"Cordova callback block returned unrecognized type: %@", NSStringFromClass([value class]));
        result = nil;
    }
    
    if (!result) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}
@end
