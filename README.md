# 工时App
工时的功能点

```
1、登录
2、本年每个月填写工时列表
3、获取某一天的工时详情列表
4、获取所有项目名称列表
5、获取项目下的任务列表
6、新增某一天的工时
```
### 一.客户端登录
-------
* 登录页面用左右滑动的动画展示背景图片
* 客户端登录，登录采用http接口，http://xxxx:xx/xxx/login 
* 登录成功，进行首页
* `参数是如下json`

```
请求示例：
参数：
{
    "opt":
       "{
           "username":"niwenkang",
           "browser":"Safari",
           "os":"iPhone",
           "password":"nwk123"
        }"
}
响应参数示例：
{
    "success":true,
    "message":"登陆成功!",
    "className":"BaseModel",
    "code":"200",
    "data":[
        {
            "staff":Object{...},
            "sessionid":"4ac9308e-63bf-41c7-9508-d67253a12a06",
            "roles":Array[1],
            "leaderProjects":Array[1],
            "is_admin":false,
            "user":Object{...}
        }
    ]
}

```
### 二.骨架
-------
* 采用UITabBarController标签控制器
* 采用UINavigationController导航控制器

`未完待续`

###三.工时列表
-------
* 采用第三方的日历控件
* 调用接口，查询全年的工时信息
* 日历中展示对应时间的工时信息
* 上下滚动可以查询对应日期的工时信息
* `代码片段`

```
* 通过CocoaPods集成FSCalendar

target '<Your Target Name>' do
	pod 'FSCalendar'
end

```

* `获取指定日期的工时列表`

```
请求示例：
参数：
{
    "opt":"{
            "endtime":"2017-04-30 23:59:59",
            "starttime":"2017-04-01 00:00:00",
            "type":"1"
            }"
}
响应参数示例：
{
    "className":"BaseModel",
    "success":true,
    "message":"查询成功！",
    "code":"200",
    "data":[
        {
            "month":"2017-04",
            "itemBos":[
                {
                    "item_date":"2017-04-01",
                    "msg":"8.0"
                },
                Object{...},
                Object{...}
            ]
        }
    ]
}
```
### 四.日工时详情-(列表形式）
* 当天参与多个项目
* UITableView 展示
* 定制cell,内容不固定，导致cell的高度是动态的
* 调用查询日工时详情接口
* `接口入参出参`

```
请求示例
入参：
{"opt":
    "{
        "item_time":"2017-03-30"
    }"
}
出参：
{
    "className":"BaseModel",
    "success":true,
    "message":"查询成功！",
    "code":"200",
    "data":[
        {
            "approval_man":"倪文康",
            "approval_status":1,
            "tid":"a4c1a645968143058f69d2017f5bdc05",
            "item_id":"18564a7dbf4f420b80e29086e31dba0d",
            "item_time":"2017-03-30",
            "projectId":"4efd117d308e4283beec1814b0fc6e1a",
            "content":"["添加极光推送插件 50%"]",
            "duration":"4",
            "type":"ce5eb99185ca4468ae9e5eb4373d386a",
            "approval_content":null,
            "score":"4"
        },
        Object{...}
    ]
}
```

###五.新增或修改工时






