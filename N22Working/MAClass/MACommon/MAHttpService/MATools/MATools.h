//
//  NITools.h
//  IosProject
//
//  Created by nwk on 16/9/1.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MATools : NSObject
//弹出提示框
void loadingForText(NSString *text);
MBProgressHUD *loadingInstanceForText(NSString *text);
void loadingNewTextForMB(MBProgressHUD *hud,NSString *text);
void loadingForTextToView(NSString *text,UIView *view);
void alertMBProgressHUD(NSString *text);
void alertMBProgressHUDShowError(NSError *error);
void alertMBProgressHUDToView(NSString *text,UIView *view);
void alertMBProgressHUDToViewShowError(NSError *error,UIView *view);
void closeHUD();
///关闭提示框
void closeHUDToView(UIView *view);

void downKeyBoard();
NSString *errorWithError(NSInteger errorCode);
@end

@interface NIDate : NSDate

@end

@interface NIString : NSString
NSString *getUUID();
NSString *convertStrToTime(NSString *timeStr,NSString *formater);
NSString *notNilWithString(NSString *str);
NSString *dateStringFormatter(NSString *dateStr,NSString *formater);
NSString *getCurrentDateString();
NSDate *dateFromString(NSString *dateStr);
NSString *dateFormatter(NSDate *date,NSString *formater);
NSDate *stringFormatterDate(NSString *dateStr,NSString *formatter);
//字符串补零操作
float addZero(float number);
NSString * nilWithString(id obj);
//工具方法
NSMutableAttributedString *attrStr(NSString *str,NSString *regularEx,NSDictionary *attrs);
/**
 *  NSRoundPlain 四舍五入
 *  NSRoundDown  只舍不入
 *  NSRoundUp    不舍只入
 */
NSString *numFormat(double num,int format, BOOL isRound);
//去掉小数点之后的0；
NSString* removeFloatAllZero(NSString*string);
BOOL isNewEmpty(id object);
BOOL isEqualToString(NSString *str,NSString *flag);
NSArray *arrayWithMemberIsOnly(NSArray *array);//去重
@end
