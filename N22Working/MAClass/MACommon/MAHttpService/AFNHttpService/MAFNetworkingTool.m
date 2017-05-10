//
//  AFNHttpHelp.m
//  IosProject
//
//  Created by nwk on 16/8/9.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "MAFNetworkingTool.h"
#import "CommendConfig.h"
#import "AFNetworking.h"
#import "MAInstance.h"
#import "MJExtension.h"

#define NetWorkNotReachableErrorInfo @"网络连线错误，请检查网络连线设定！"

@interface MAFNetworkingTool()

@property (strong, nonatomic) NSMutableArray *operations;
@end

@implementation MAFNetworkingTool

static MAFNetworkingTool *afnHttp;

+ (instancetype)sharedAFNHttp{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        afnHttp = [[MAFNetworkingTool alloc] init];
    });
    return afnHttp;
}
NSString * getContentTypeForPath(NSURL *url){
    NSString *extension = [url pathExtension];
#ifdef __UTTYPE__
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    if (!contentType) {
        return @"application/octet-stream";
    } else {
        return contentType;
    }
#else
#pragma unused (extension)
    return @"application/octet-stream";
#endif
}


+ (void)POST:(NSString *)name parameters:(id)parameters successBlock:(void (^)(id responesObj))successBlock failedBlock:(void (^)(NSError *error))failedBlock{
    NSString *netStatus = [MASessionTimeOut getNetStatus];
    if ([MASessionTimeOut getNetStatus] == NetworkOfflineStatus || netStatus == NetworkDefaultStatus) {
        NSError *error = [NSError errorWithDomain:NetWorkNotReachableErrorInfo code:NSURLErrorNotConnectedToInternet userInfo:nil];
        failedBlock(error);
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer *httpRequest = [AFHTTPRequestSerializer serializer];
    [httpRequest willChangeValueForKey:@"timeoutInterval"];
    httpRequest.timeoutInterval = REQUESTTIMEOUT;
    [httpRequest didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer = httpRequest;
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    //设置是否信任服务端返回的证书
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    //根据HttpTag 查找 请求url
    NSString *urlStr = getHttpServiceUrlWithTag(name);
    
    if ([[MAInstance getInstance] getSessionId]) {
        urlStr = [NSString stringWithFormat:@"%@;JSESSIONID=%@",urlStr ,[[MAInstance getInstance] getSessionId]];
    }
        
    NSURLSessionDataTask *dataTask = [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock)
            successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock)
            failedBlock(error);
    }];
    
    if (dataTask) {
        [[MAFNetworkingTool sharedAFNHttp].operations addObject:@{name:dataTask}];
    }
    
}

+ (void)newsPOST:(NSString *)url parameters:(id)parameters successBlock:(void (^)(id responesObj))successBlock failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *netStatus = [MASessionTimeOut getNetStatus];
    if ([MASessionTimeOut getNetStatus] == NetworkOfflineStatus || netStatus == NetworkDefaultStatus) {
        NSError *error = [NSError errorWithDomain:NetWorkNotReachableErrorInfo code:NSURLErrorNotConnectedToInternet userInfo:nil];
        failedBlock(error);
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer *httpRequest = [AFHTTPRequestSerializer serializer];
    [httpRequest willChangeValueForKey:@"timeoutInterval"];
    httpRequest.timeoutInterval = REQUESTTIMEOUT;
    [httpRequest didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer = httpRequest;
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    //设置是否信任服务端返回的证书
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock)
            successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock)
            failedBlock(error);
    }];
    
    if (dataTask) {
        [[MAFNetworkingTool sharedAFNHttp].operations addObject:@{@"news":dataTask}];
    }
    
}

/**
 *  判断是否有网络
 *  @return 网络状态
 */
BOOL whetherNetworkWithOnline(){
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //网络只有在startMonitoring完成后才可以使用检查网络状态
    [manager startMonitoring];  //开启网络监视器；
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"网络不通");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"网络通过WIFI连接");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"网络通过无线连接");
                break;
            }
            default:
                break;
        }
        
        NSLog(@"网络状态数字返回：%zd", status);
        NSLog(@"网络状态返回: %@", AFStringFromNetworkReachabilityStatus(status));
        
    }];
    
    return manager.networkReachabilityStatus == AFNetworkReachabilityStatusUnknown;
}

+ (void)cancleOperationWithHttpMark:(NSString *)name{
    if (afnHttp) {
        for (NSDictionary *dic in afnHttp.operations) {
            NSURLSessionDataTask *task = dic[name];
            [task cancel];
            NSLog(@"%@",dic[name]);
        }
    }
}
+ (void)cancelAllHttp
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.operationQueue cancelAllOperations];
}


-(NSMutableArray *)operations{
    if (!_operations) {
        _operations = [NSMutableArray array];
    }
    
    return _operations;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    NSLog(@"%@",dic);
    return dic;
}
@end
