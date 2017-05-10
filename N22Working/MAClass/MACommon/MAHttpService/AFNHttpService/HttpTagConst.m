//
//  HttpTagConst.m
//  IosProject
//
//  Created by nwk on 16/9/7.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import "HttpTagConst.h"
#import "MATools.h"

@implementation HttpTagConst

/** 登录 */
NSString *const HttpTagLogin = @"login";
/** 全年列表 */
NSString *const HttpTagAllList = @"item/list";
/** 某一天的工时详情列表 */
NSString *const HttpTagDetailList = @"attendance/detail/list";
/** 获取所有项目 */
NSString *const HttpTagAllProjectList = @"project/all";
/** 获取用户列表 */
NSString *const HttpTagUsertList = @"project/user/list";
/** 获取项目下的任务列表 */
NSString *const HttpTagTaskList = @"item_type/list";
/** 提交工时 */
NSString *const HttpTagAddWorking = @"attendance/add";
/**
 *  定义所有请求的url与serviceId
 *  @return dic
 */
static NSDictionary *interfaceConfigWithHttpTag(){
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[HttpTagLogin] = HttpTagLogin;
    dic[HttpTagAllList] = HttpTagAllList;
    dic[HttpTagDetailList] = HttpTagDetailList;
    dic[HttpTagAllProjectList] = HttpTagAllProjectList;
    dic[HttpTagUsertList] = HttpTagUsertList;
    dic[HttpTagTaskList] = HttpTagTaskList;
    dic[HttpTagAddWorking] = HttpTagAddWorking;
    return dic;
}
/**
 *  获取serviceUrl
 */
NSString *getHttpServiceUrlWithTag(NSString *name){
    NSString *server = interfaceConfigWithHttpTag()[name];
    return [NSString stringWithFormat:@"%@/%@",HttpRootUrl ,server];
}
@end
