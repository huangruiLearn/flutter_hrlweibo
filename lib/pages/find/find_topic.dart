import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/model/FindHomeModel.dart';

class FindTopicPage extends StatefulWidget {
  final Findtopic mModel;

  FindTopicPage({Key key, this.mModel}) : super(key: key);

  @override
  _FindTopicPageState createState() => _FindTopicPageState();
}

class _FindTopicPageState extends State<FindTopicPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey<String>("aa"),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            //padding: EdgeInsets.only(top: 15,bottom: 15),
            child: Row(
              children: <Widget>[
                new Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Column(
                      children: <Widget>[
                        Image.asset(
                          Constant.ASSETS_IMG + "find_topic1.png",
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          "火热参与",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                new Container(
                  width: 1,
                  height: 60,
                  color: Color(0xffE5E5E5),
                ),
                new Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Column(
                      children: <Widget>[
                        Image.asset(
                          Constant.ASSETS_IMG + "find_topic2.png",
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          "正在热议",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                new Container(
                  width: 1,
                  height: 60,
                  color: Color(0xffE5E5E5),
                ),
                new Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Column(
                      children: <Widget>[
                        Image.asset(
                          Constant.ASSETS_IMG + "find_topic3.png",
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          "兴趣话题",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                new Container(
                  width: 1,
                  height: 60,
                  color: Color(0xffE5E5E5),
                ),
                new Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Column(
                      children: <Widget>[
                        Image.asset(
                          Constant.ASSETS_IMG + "find_topic4.png",
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          "话题精选",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                new Container(
                  width: 1,
                  height: 60,
                  color: Color(0xffE5E5E5),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 10,
            color: Color(0xffEEEEEE),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 26,
                      width: 3,
                      margin: EdgeInsets.only(top: 8, bottom: 8, right: 15),
                      color: Colors.orange,
                    ),
                    Expanded(
                      child: Text(
                        "今日话题榜",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff888888)),
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        Constant.ASSETS_IMG + "find_hs_more.png",
                        width: 15,
                        height: 15,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 1,
            color: Color(0xffEEEEEE),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // This builder is called for each child.
              // In this example, we just number each list item.
              return mTopic1(index);
            },
            childCount: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 26,
                      width: 3,
                      margin: EdgeInsets.only(top: 8, bottom: 8, right: 15),
                      color: Colors.orange,
                    ),
                    Expanded(
                      child: Text(
                        "火热参与",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff888888)),
                      ),
                    ),
                    Text(
                      "更多",
                      style: TextStyle(fontSize: 13, color: Color(0xff888888)),
                    ),
                    Container(
                      child: Image.asset(
                        Constant.ASSETS_IMG + "find_hs_more.png",
                        width: 15,
                        height: 15,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 1,
            color: Color(0xffEEEEEE),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.8,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.0),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${widget.mModel.topic2[index].topicimg}'),
                                    fit: BoxFit.fill))),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: new Text(
                          widget.mModel.topic2[index].topicdesc,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        child: new Text(
                          widget.mModel.topic2[index].topicdiscuss + "参与",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff595959)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        margin: EdgeInsets.only(top: 3, right: 15),
                      ),
                    ],
                  ),
                );
              },
              childCount: 3,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 5),
            height: 10,
            color: Color(0xffEEEEEE),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 26,
                      width: 3,
                      margin: EdgeInsets.only(top: 8, bottom: 8, right: 15),
                      color: Colors.orange,
                    ),
                    Expanded(
                      child: Text(
                        "正在热议",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff888888)),
                      ),
                    ),
                    Text(
                      "更多",
                      style: TextStyle(fontSize: 13, color: Color(0xff888888)),
                    ),
                    Container(
                      child: Image.asset(
                        Constant.ASSETS_IMG + "find_hs_more.png",
                        width: 15,
                        height: 15,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 1,
            color: Color(0xffEEEEEE),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // This builder is called for each child.
              // In this example, we just number each list item.
              return Column(
                children: <Widget>[
                  new Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                          width: 75,
                          height: 75,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1.0),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${widget.mModel.topic3[index].topicimg}'),
                                          fit: BoxFit.cover))),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                widget.mModel.topic3[index].topicdesc,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                child: new Text(
                                  widget.mModel.topic3[index].topicintro,
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff595959)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                margin: EdgeInsets.only(top: 3, right: 15),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3, right: 15),
                                child: new Text(
                                  widget.mModel.topic3[index].topicdiscuss +
                                      "讨论  " +
                                      widget.mModel.topic3[index].topicread +
                                      "阅读",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 1,
                    color: Color(0xffEEEEEE),
                  ),
                ],
              );
            },
            childCount: 3,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "查看更多议题",
                  style: TextStyle(fontSize: 14, color: Color(0xff797979)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  child: Image.asset(
                    Constant.ASSETS_IMG + 'icon_right_arrow.png',
                    width: 15.0,
                    height: 13.0,
                  ),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 10,
            color: Color(0xffEEEEEE),
          ),
        ),
      ],
    );
  }

  Widget mTopic1(int index) {
    if (index % 2 == 0) {
      return new Container(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              width: 75,
              height: 75,
              child: Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${widget.mModel.topic1[index].topicimg}'),
                              fit: BoxFit.cover))),
                  Container(
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'find_topic_red.webp',
                      fit: BoxFit.fill,
                      width: 20.0,
                      height: 20.0,
                    ),
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    child: Center(
                      child: Text(
                        ((index + 2) / 2).floor().toString() + "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    widget.mModel.topic1[index].topicdesc,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    child: new Text(
                      widget.mModel.topic1[index].topicintro,
                      style: TextStyle(fontSize: 12, color: Color(0xff595959)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    margin: EdgeInsets.only(top: 3, right: 15),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3, right: 15),
                    child: new Text(
                      widget.mModel.topic1[index].topicdiscuss +
                          "讨论  " +
                          widget.mModel.topic1[index].topicread +
                          "阅读",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            height: 1,
            color: Color(0xffEEEEEE),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, right: 10),
                  child: Image.asset(
                    Constant.ASSETS_IMG + 'find_topic_red2.png',
                    width: 5.0,
                    height: 5.0,
                  ),
                ),
                Expanded(
                  child: new Text(widget.mModel.topic1[index].topicdesc,
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                ),
                new Text(widget.mModel.topic1[index].topicdiscuss + "讨论",
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  child: Image.asset(
                    Constant.ASSETS_IMG + 'icon_right_arrow.png',
                    width: 15.0,
                    height: 13.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            color: Color(0xffEEEEEE),
          ),
        ],
      );
    }
  }
}
