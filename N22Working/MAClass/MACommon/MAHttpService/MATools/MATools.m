//
//  NITools.m
//  IosProject
//
//  Created by nwk on 16/9/1.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import "MATools.h"
#import "UIView+MAExpand.h"

@implementation MATools
void loadingForText(NSString *text)
{
    loadingForTextToView(text, FirstViewForProject);
}
void loadingForTextToView(NSString *text,UIView *view)
{
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progress.mode = MBProgressHUDModeIndeterminate;
    progress.label.text = text;
}
MBProgressHUD *loadingInstanceForText(NSString *text)
{
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:FirstViewForProject animated:YES];
    progress.mode = MBProgressHUDModeIndeterminate;
    progress.label.text = text;
    
    return progress;
}
void loadingNewTextForMB(MBProgressHUD *hud,NSString *text){
    if (hud) {
        hud.label.text = text;
    }
}
///关闭提示框
void closeHUD()
{
    closeHUDToView(FirstViewForProject);
}
///关闭提示框
void closeHUDToView(UIView *view)
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
//弹出提示框
void alertMBProgressHUD(NSString *text)
{
    alertMBProgressHUDToView(text, FirstViewForProject);
}


//弹出提示框
void alertMBProgressHUDToView(NSString *text,UIView *view)
{
    closeHUDToView(view);
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progress.mode = MBProgressHUDModeText;
    progress.label.text = text;
    [progress hideAnimated:YES afterDelay:1.5];
}
/**
 *  弹出错误信息提示框
 *
 *  @param error 错误信息
 */
void alertMBProgressHUDShowError(NSError *error)
{
    alertMBProgressHUDToViewShowError(error, FirstViewForProject);
    
}
void alertMBProgressHUDToViewShowError(NSError *error,UIView *view)
{
    if (!isNewEmpty(error)) {
        alertMBProgressHUDToView(errorWithError(error.code), view);
    }else{
        alertMBProgressHUDToView(@"数据返回异常！", view);
    }
    
}

NSString *errorWithError(NSInteger errorCode){
    switch (errorCode) {
        case NSURLErrorCannotConnectToHost:
        case NSURLErrorCannotFindHost:
        case NSURLErrorNotConnectedToInternet:
            return @"网络未连接，请检查网络！";
        case NSURLErrorTimedOut:
            return @"网络请求超时！";
        case NSURLErrorCannotLoadFromNetwork:
            return @"当前网络不佳，请稍后重试！";
        case NSURLErrorCancelled:
            return @"当前网络请求已取消！";
        case NSURLErrorBadServerResponse:
        case NSURLErrorResourceUnavailable:
            return @"服务器错误！";
        case NSURLErrorServerCertificateHasBadDate:
        case NSURLErrorCannotDecodeRawData:
        case NSURLErrorCannotDecodeContentData:
            return @"服务器返回异常！";
        case NSURLErrorNetworkConnectionLost:
            return @"失去连接，请重试！";
        case NSURLErrorDownloadDecodingFailedMidStream:
        case NSURLErrorDownloadDecodingFailedToComplete:
            return @"下载失败！";
        case NSURLErrorBadURL:
        case NSURLErrorUnsupportedURL:
            return @"非法url！";
        default:
            return @"数据返回异常！";
    }
}
/**
 *  全局放下键盘 仅限当前keyWindow
 */
void downKeyBoard(){
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end

@implementation NIDate

@end

@implementation NIString

NSString *getUUID(){
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString *securityID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    return [securityID stringByReplacingOccurrencesOfString:@"-" withString:@""];
}


NSString *notNilWithString(id object){
    if ([object isKindOfClass:[NSString class]]) {
        return !isNewEmpty(object)?object:@"";
    }else{
        if (!object) return @"";
    }
    return object;
}
NSString *dateStringFormatter(NSString *dateStr,NSString *formater){
    
    if (isNewEmpty(dateStr)) return nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (dateStr.length > 10 && dateStr.length < 20) {
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    } else if (dateStr.length > 20) {
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SSS"];
        
    } else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    [dateFormatter setDateFormat:formater];
    
    return [dateFormatter stringFromDate:date];
}

NSDate *dateFromString(NSString *dateStr){
    
    if (isNewEmpty(dateStr)) return nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter dateFromString:dateStr];
}

NSDate *stringFormatterDate(NSString *dateStr,NSString *formatter){
    
    if (isNewEmpty(dateStr)) return nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (!formatter) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        [dateFormatter setDateFormat:formatter];
    }
    
    return [dateFormatter dateFromString:dateStr];
}

NSString *dateFormatter(NSDate *date,NSString *formater){
    
    if (isNewEmpty(date)) return nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (!formater) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        [dateFormatter setDateFormat:formater];
    }
    
    
    return [dateFormatter stringFromDate:date];
}

//字符串补零操作
float addZero(float number){
    
    NSString *str = [NSString stringWithFormat:@"%0.f",number];
    NSString *hightStr;
    NSInteger index = 0 ;
    int hight;
    if (str.length > 2) {
        index = str.length-1;
        hightStr = [str substringToIndex:index];
        hight = [hightStr intValue];
        hight += 1;
    } else {
//        index = 1;
//        hightStr = [str substringToIndex:index];
//        hight = [hightStr intValue];
//        hight += 1;
        return number;
    }
    
    NSString *string = [NSString stringWithFormat:@"%d",hight];
    NSString *numberStr;
    for (NSInteger i=0;i< str.length; i++) {
        if (i < index-1) {
            continue;
        }else if (i == index-1){
            numberStr = [NSString stringWithFormat:@"%@",string];
        }else{
            numberStr = [NSString stringWithFormat:@"%@0",numberStr];
        }
        
    }
    return [numberStr floatValue];
}
//工具方法
NSMutableAttributedString *attrStr(NSString *str,NSString *regularEx,NSDictionary *attrs){
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:regularEx options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        [attrStr setAttributes:attrs range:range];
    }
    return attrStr;
}
/**
 *  NSRoundPlain 四舍五入
 *  NSRoundDown  只舍不入
 *  NSRoundUp    不舍只入
 */
NSString *numFormat(double num,int format, BOOL isRound)
{
    format = format>=0&&format<=5?format:2;
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:isRound?NSRoundPlain:NSRoundDown scale:format raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *sourceNum = [[NSDecimalNumber alloc] initWithDouble:num];
    NSDecimalNumber *resultNum = [sourceNum decimalNumberByRoundingAccordingToBehavior:behavior];
    NSArray *formatArr = [NSArray arrayWithObjects:@"%.lf",@"%.1lf",@"%.2lf",@"%.3lf",@"%.4lf",@"%.5lf", nil];
    NSString *number = [NSString stringWithFormat:formatArr[format],[resultNum doubleValue]];
    
    return removeFloatAllZero(number);
}
//去掉小数点之后的0；
NSString* removeFloatAllZero(NSString*string)
{
    if ([string doubleValue] == 0) return string;
    
    NSArray *pointArray = [string componentsSeparatedByString:@"."];
    NSString *lastStr = [NSString stringWithFormat:@"%@",@([pointArray.lastObject floatValue])];
    if ([lastStr floatValue] > 0 && pointArray.count > 1) {
        return [pointArray.firstObject stringByAppendingFormat:@".%@",lastStr];
    }
    return pointArray.firstObject;
}
/**
 *  去重
 */
NSArray *arrayWithMemberIsOnly(NSMutableArray *array){
    NSMutableArray *categoryArray = [NSMutableArray array];
    
    for (unsigned i = 0; i < [array count]; i++) {
        @autoreleasepool {
            if ([categoryArray containsObject:[array objectAtIndex:i]] == NO) {
                
                [categoryArray addObject:[array objectAtIndex:i]];
            }
        }
    }
    return categoryArray;
}
#pragma mark - Check
NSString *nilWithString(id obj){
    
    return (obj==nil)?@"":[NSString stringWithFormat:@"%@",obj];
}
BOOL isNewEmpty(id object){
    if ([object isKindOfClass:[NSString class]]) {
        if (!object || [object isEqualToString:@""]) {
            return YES;
        }
    } else {
        if (!object) return YES;
    }
    
    return NO;
}
BOOL isEqualToString(NSString *str,NSString *flag){
    if ([str isEqualToString:flag]) {
        return YES;
    }
    return NO;
}
@end
