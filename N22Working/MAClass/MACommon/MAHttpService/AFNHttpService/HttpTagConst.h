//
//  HttpTagConst.h
//  IosProject
//
//  Created by nwk on 16/9/7.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HttpTagConst : NSObject

#define HttpRootUrl @"http://www.n22.com.cn:8080/n22server"

// extern,外部的意思,表明这个全局变量,不是自己的,是别人的,请在其他文件里找这个全局变量

/** 登录 */
UIKIT_EXTERN NSString *const HttpTagLogin;
/** 全年列表 */
UIKIT_EXTERN NSString *const HttpTagAllList;
/** 某一天的工时详情列表 */
UIKIT_EXTERN NSString *const HttpTagDetailList;
/** 获取所有项目 */
UIKIT_EXTERN NSString *const HttpTagAllProjectList;
/** 获取用户列表 */
UIKIT_EXTERN NSString *const HttpTagUsertList;
/** 获取项目下的任务列表 */
UIKIT_EXTERN NSString *const HttpTagTaskList;
/** 提交工时 */
UIKIT_EXTERN NSString *const HttpTagAddWorking;
/**
 *  获取serviceUrl
 */
NSString *getHttpServiceUrlWithTag(NSString *name);

@end
