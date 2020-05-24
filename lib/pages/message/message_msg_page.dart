import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/public.dart';

class MessageMsgPage extends StatefulWidget {
  @override
  _MessageMsgPageState createState() => _MessageMsgPageState();
}

class _MessageMsgPageState extends State<MessageMsgPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffffffff),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              child: Center(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15, top: 8, right: 15),
                padding: EdgeInsets.only(top: 6, bottom: 6),
                decoration: BoxDecoration(
                  color: Color(0xffE4E2E8),
                  borderRadius: BorderRadius.all(
                    //圆角
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                    child: Container(
                        child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5, top: 2),
                      child: Image.asset(
                        Constant.ASSETS_IMG + 'find_top_search.png',
                        width: 12.0,
                        height: 15.0,
                      ),
                    ),
                    Text(
                      "搜索",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 14, color: Color(0xffee565656)),
                    ),
                  ],
                ))),
              )),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'message_at.webp',
                      width: 40.0,
                      height: 40.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "@我的",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                child: Image.asset(
                                  Constant.ASSETS_IMG + 'icon_right_arrow.png',
                                  width: 12.0,
                                  height: 15.0,
                                ),
                                margin: EdgeInsets.only(right: 20),
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(top: 12),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 18),
                          height: 0.5,
                          color: Color(0xffE5E5E5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                Routes.navigateTo(context, Routes.msgCommentPage,
                    transition: TransitionType.fadeIn);
              },
              child: Container(
                //  margin: EdgeInsets.only( bottom: 10),

                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                      child: Image.asset(
                        Constant.ASSETS_IMG + 'message_comments.png',
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "评论",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                Spacer(),
                                Container(
                                  child: Image.asset(
                                    Constant.ASSETS_IMG +
                                        'icon_right_arrow.png',
                                    width: 12.0,
                                    height: 15.0,
                                  ),
                                  margin: EdgeInsets.only(right: 20),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 12),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18),
                            height: 0.5,
                            color: Color(0xffE5E5E5),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                Routes.navigateTo(context, Routes.msgZanPage,
                    transition: TransitionType.fadeIn);
              },
              child: Container(
                //  margin: EdgeInsets.only( bottom: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                      child: Image.asset(
                        Constant.ASSETS_IMG + 'message_good.webp',
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "赞",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                Spacer(),
                                Container(
                                  child: Image.asset(
                                    Constant.ASSETS_IMG +
                                        'icon_right_arrow.png',
                                    width: 12.0,
                                    height: 15.0,
                                  ),
                                  margin: EdgeInsets.only(right: 20),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 12),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18),
                            height: 0.5,
                            color: Color(0xffE5E5E5),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          //消息布局
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                Routes.navigateTo(context, Routes.chatPage,
                    transition: TransitionType.fadeIn);
              },
              child: Container(
                height: 65,
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://c-ssl.duitang.com/uploads/item/201208/30/20120830173930_PBfJE.thumb.700_0.jpeg"),
                        radius: 20.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "测试号001",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                child: Text(
                                  "19:22",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                margin: EdgeInsets.only(right: 15),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "明天几点吃完饭?",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  width: 15,
                                  height: 15,
                                  decoration: new BoxDecoration(
                                    border: new Border.all(
                                        color: Colors.red, width: 0.5),
                                    // 边色与边宽度
                                    color: Colors.red,
                                    // 底色
                                    //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                                    shape: BoxShape.circle, // 默认值也是矩形
                                    //    borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                                  ),
                                  child: Center(
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 0.5,
                                color: Color(0xffE5E5E5),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                Routes.navigateTo(context, Routes.chatPage,
                    transition: TransitionType.fadeIn);
              },
              child: Container(
                height: 65,
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://uploadfile.huiyi8.com/up/a2/e3/83/a2e3832e52216b846c80313049591938.jpg"),
                        radius: 20.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "测试号002",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                child: Text(
                                  "10:26",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                margin: EdgeInsets.only(right: 15),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "可以啊,做的太好了",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 0.5,
                                color: Color(0xffE5E5E5),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
