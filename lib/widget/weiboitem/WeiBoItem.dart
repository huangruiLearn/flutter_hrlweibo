import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/http/service_method.dart';
import 'package:flutter_hrlweibo/model/WeiBoModel.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';
import 'package:flutter_hrlweibo/widget/video/video_widget.dart';
import 'package:flutter_hrlweibo/widget/weibo/match_text.dart';
import 'package:flutter_hrlweibo/widget/weibo/parsed_text.dart';
import '../../pages/home/weibo_retweet_page.dart';
import 'package:flutter_hrlweibo/widget/likebutton/like_button.dart';
import 'package:flutter_hrlweibo/widget/likebutton/utils/like_button_model.dart';
import 'package:flutter_hrlweibo/public.dart';
import "package:dio/dio.dart";

class WeiBoItemWidget extends StatelessWidget {
  WeiBoModel mModel;
  bool isDetail; //是否是详情界面

  WeiBoItemWidget(WeiBoModel data, bool isdetail) {
    mModel = data;
    isDetail = isdetail;
  }

  @override
  Widget build(BuildContext context) {
    return _wholeItemWidget(context, mModel, isDetail);
  }
}

//整个item布局
Widget _wholeItemWidget(
    BuildContext context, WeiBoModel weiboItem, bool isDetail) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _authorRow(context, weiboItem),
        textContent(weiboItem.content, context, isDetail),
        mVedioLayout(context, weiboItem.vediourl),
        _NineGrid(context, weiboItem.picurl),
        _RetWeetLayout(context, weiboItem, isDetail),
        Visibility(
          visible: !isDetail,
          child: Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                    top: weiboItem.containZf ? 0 : 12),
                height: 1,
                color: Color(0xffDBDBDB),
              ), //下划线
              _RePraCom(context, weiboItem),
              new Container(
                margin: EdgeInsets.only(top: 10),
                height: 12,
                color: Color(0xffEFEFEF),
              ),
            ],
          ),
        ) //下划线
      ],
    ),
  );
}

//发布者昵称头像布局
Widget _authorRow(BuildContext context, WeiBoModel weiboItem) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 2.0),
    child: Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            Routes.navigateTo(context, Routes.personinfoPage, params: {
              'userid': weiboItem.userInfo.id.toString(),
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 5),
            child: weiboItem.userInfo.isvertify == 0
                ? Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: NetworkImage(weiboItem.userInfo.headurl),
                          fit: BoxFit.cover),
                    ))
                : Stack(
                    children: <Widget>[
                      Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: NetworkImage(weiboItem.userInfo.headurl),
                                fit: BoxFit.cover),
                          )),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          child: Image.asset(
                            (weiboItem.userInfo.isvertify == 1)
                                ? Constant.ASSETS_IMG + 'home_vertify.webp'
                                : Constant.ASSETS_IMG + 'home_vertify2.webp',
                            width: 15.0,
                            height: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Center(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                      child: Text(weiboItem.userInfo.nick,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: weiboItem.userInfo.ismember == 0
                                  ? Colors.black
                                  : Color(0xffF86119)))),
                ),
                Center(
                  child: weiboItem.userInfo.ismember == 0
                      ? new Container()
                      : Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Image.asset(
                            Constant.ASSETS_IMG + 'home_memeber.webp',
                            width: 15.0,
                            height: 13.0,
                          ),
                        ),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 2.0, 0.0, 0.0),
                child: weiboItem.tail.isEmpty
                    ? Text(weiboItem.userInfo.decs,
                        style:
                            TextStyle(color: Color(0xff808080), fontSize: 11.0))
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              DateUtil.getFormatTime(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      weiboItem.createtime)),
                              style: TextStyle(
                                  color: Color(0xff808080), fontSize: 11.0)),
                          Container(
                            margin: EdgeInsets.only(left: 7, right: 7),
                            child: Text("来自",
                                style: TextStyle(
                                    color: Color(0xff808080), fontSize: 11.0)),
                          ),
                          Text(weiboItem.tail,
                              style: TextStyle(
                                  color: Color(0xff5B778D), fontSize: 11.0))
                        ],
                      )),
          ],
        ),
        Expanded(
          child: new Align(
              alignment: FractionalOffset.centerRight,
              child: GestureDetector(
                child: Container(
                  padding: new EdgeInsets.only(
                      top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.orange),
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    '+ 关注',
                    style: TextStyle(color: Colors.orange, fontSize: 12),
                  ),
                ),
              )),
        )
      ],
    ),
  );
}

Widget mVedioLayout(BuildContext context, String vedioUrl) {
/*return
  Container(


    height: 100,
    width: 100,
    color: Colors.deepOrangeAccent,
  )
  ;*/

  return Container(
    child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: (vedioUrl.isEmpty || "null" == vedioUrl)
            ? new Container()
            : Container(
                constraints: BoxConstraints(
                    maxHeight: 250,
                    maxWidth: MediaQuery.of(context).size.width,
                    //    maxWidth: 200,
                    minHeight: 150,
                    minWidth: 150),
                child: VideoWidget(
                  vedioUrl,
                ))),
  );
}

Widget textContent(String mTextContent, BuildContext context, bool isDetail) {
  if (!isDetail) {
    //如果字数过长
    if (mTextContent.length > 150) {
      mTextContent = mTextContent.substring(0, 148) + ' ... ' + '全文';
    }
  }
  mTextContent = mTextContent.replaceAll("\\n", "\n");
  return Container(
      alignment: FractionalOffset.centerLeft,
      margin: EdgeInsets.only(top: 5.0, left: 15, right: 15, bottom: 5),
      child: ParsedText(
        text: mTextContent,
        style: TextStyle(
          height: 1.5,
          fontSize: 15,
          color: Colors.black,
        ),
        parse: <MatchText>[
          MatchText(
              pattern: r"\[(@[^:]+):([^\]]+)\]",
              style: TextStyle(
                color: Color(0xff5B778D),
                fontSize: 15,
              ),
              renderText: ({String str, String pattern}) {
                Map<String, String> map = Map<String, String>();
                RegExp customRegExp = RegExp(pattern);
                Match match = customRegExp.firstMatch(str);
                map['display'] = match.group(1);
                map['value'] = match.group(2);
                print("正则:" + match.group(1) + "---" + match.group(2));
                return map;
              },
              onTap: (content, contentId) {
                /*  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Mentions clicked"),
                      content: new Text("$url clicked."),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                );*/

                Routes.navigateTo(context, Routes.personinfoPage, params: {
                  'userid': contentId,
                });
              }),
          MatchText(
              pattern: '#.*?#',
              //       pattern: r"\B#+([\w]+)\B#",
              //   pattern: r"\[(#[^:]+):([^#]+)\]",
              style: TextStyle(
                color: Color(0xff5B778D),
                fontSize: 15,
              ),
              renderText: ({String str, String pattern}) {
                Map<String, String> map = Map<String, String>();

                String idStr =
                    str.substring(str.indexOf(":") + 1, str.lastIndexOf("#"));
                String showStr = str
                    .substring(str.indexOf("#"), str.lastIndexOf("#") + 1)
                    .replaceAll(":" + idStr, "");
                map['display'] = showStr;
                map['value'] = idStr;
                //   print("正则:"+str+"---"+idStr+"--"+startIndex.toString()+"--"+str.lastIndexOf("#").toString());

                return map;
              },
              onTap: (String content, String contentId) async {
                print("id是:" + contentId.toString());
                Routes.navigateTo(
                  context,
                  Routes.topicDetailPage,
                  params: {
                    'mTitle': content.replaceAll("#", ""),
                    'mImg': "",
                    'mReadCount': "123",
                    'mDiscussCount': "456",
                    'mHost': "测试号",
                  },
                );
              }),
          MatchText(
            pattern: '(\\[/).*?(\\])',
            //       pattern: r"\B#+([\w]+)\B#",
            //   pattern: r"\[(#[^:]+):([^#]+)\]",
            style: TextStyle(
              fontSize: 15,
            ),
            renderText: ({String str, String pattern}) {
              Map<String, String> map = Map<String, String>();
              print("表情的正则:" + str);
              String mEmoji2 = "";
              try {
                String mEmoji = str.replaceAll(RegExp('(\\[/)|(\\])'), "");
                int mEmojiNew = int.parse(mEmoji);
                mEmoji2 = String.fromCharCode(mEmojiNew);
              } on Exception catch (_) {
                mEmoji2 = str;
              }
              map['display'] = mEmoji2;

              return map;
            },
          ),
          MatchText(
              pattern: '全文',
              //       pattern: r"\B#+([\w]+)\B#",
              //   pattern: r"\[(#[^:]+):([^#]+)\]",
              style: TextStyle(
                color: Color(0xff5B778D),
                fontSize: 15,
              ),
              renderText: ({String str, String pattern}) {
                Map<String, String> map = Map<String, String>();
                map['display'] = '全文';
                map['value'] = '全文';
                return map;
              },
              onTap: (display, value) async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Mentions clicked"),
                      content: new Text("点击全文了"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                );
              }),
        ],
      ));
}

//转发内容的布局
Widget _RetWeetLayout(
    BuildContext context, WeiBoModel weiboItem, bool isDetail) {
  if (weiboItem.containZf) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Container(
          padding: EdgeInsets.only(bottom: 12),
          margin: EdgeInsets.only(top: 5),
          color: Color(0xffF7F7F7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              textContent(
                  '[@' +
                      weiboItem.zfNick +
                      ':' +
                      weiboItem.zfUserId +
                      ']' +
                      ":" +
                      weiboItem.zfContent,
                  context,
                  isDetail),
              /*   Text(,
                    style: TextStyle(color: Colors.black, fontSize: 12)),*/
              mVedioLayout(context, weiboItem.zfVedioUrl),
              _NineGrid(context, weiboItem.zfPicurl),
            ],
          )),
    );
  } else {
    return Container(
      height: 0,
    );
  }
}

//转发收藏点赞布局
Widget _RePraCom(BuildContext context, WeiBoModel weiboItem) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      new Flexible(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return RetWeetPage(
                mModel: weiboItem,
              );
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Constant.ASSETS_IMG + 'ic_home_reweet.png',
                width: 22.0,
                height: 22.0,
              ),
              Container(
                child: Text(weiboItem.zhuanfaNum.toString() + "",
                    style: TextStyle(color: Colors.black, fontSize: 13)),
                margin: EdgeInsets.only(left: 4.0),
              ),
            ],
          ),
        ),
        flex: 1,
      ),
      new Flexible(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return RetWeetPage(
                mModel: weiboItem,
              );
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Constant.ASSETS_IMG + 'ic_home_comment.webp',
                width: 22.0,
                height: 22.0,
              ),
              Container(
                child: Text(weiboItem.commentNum.toString() + "",
                    style: TextStyle(color: Colors.black, fontSize: 13)),
                margin: EdgeInsets.only(left: 4.0),
              ),
            ],
          ),
        ),
        flex: 1,
      ),
      new Flexible(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return RetWeetPage(
                mModel: weiboItem,
              );
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              LikeButton(
                isLiked: weiboItem.zanStatus == 1,
                onTap: (bool isLiked) {
                  return onLikeButtonTapped(isLiked, weiboItem);
                },
                size: 21,
                circleColor:
                    CircleColor(start: Colors.orange, end: Colors.deepOrange),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Colors.orange,
                  dotSecondaryColor: Colors.deepOrange,
                ),
                likeBuilder: (bool isLiked) {
                  return /*Icon(
                    Icons.home,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    size: 20,
                  )*/
                      Image.asset(
                    isLiked
                        ? Constant.ASSETS_IMG + 'ic_home_liked.webp'
                        : Constant.ASSETS_IMG + 'ic_home_like.webp',
                    width: 21.0,
                    height: 21.0,
                  );
                },
                likeCount: weiboItem.likeNum,
                countBuilder: (int count, bool isLiked, String text) {
                  var color = isLiked ? Colors.orange : Colors.black;
                  Widget result;
                  if (count == 0) {
                    result = Text(
                      "",
                      style: TextStyle(color: color, fontSize: 13),
                    );
                  } else
                    result = Text(
                      text,
                      style: TextStyle(color: color, fontSize: 13),
                    );
                  return result;
                },
              ),
            ],
          ),
        ),
        flex: 1,
      ),
    ],
  );
}

Future<bool> onLikeButtonTapped(bool isLiked, WeiBoModel weiboItem) async {
  final Completer<bool> completer = new Completer<bool>();

  FormData formData = FormData.fromMap({
    "weiboId": weiboItem.weiboId,
    "userId": UserUtil.getUserInfo().id,
    "status": weiboItem.zanStatus == 0 ? 1 : 0, //1点赞,0取消点赞
  });
  DioManager.getInstance().post(ServiceUrl.zanWeiBo, formData, (data) {
    if (weiboItem.zanStatus == 0) {
      //点赞成功
      weiboItem.zanStatus = 1;
      weiboItem.likeNum++;
      completer.complete(true);
    } else {
      //取消点赞成功
      weiboItem.zanStatus = 0;
      weiboItem.likeNum--;

      completer.complete(false);
    }
  }, (error) {
    if (weiboItem.zanStatus == 0) {
      completer.complete(false);
    } else {
      completer.complete(true);
    }
  });

  return completer.future;
}

//九宫格图片布局
Widget _NineGrid(BuildContext context, List<String> picUrlList) {
  List<String> picList = picUrlList;
  //如果包含九宫格图片
  if (picList != null && picList.length > 0) {
    //一共有几张图片
    num len = picList.length;
    //算出一共有几行
    int rowlength = 0;
    //一共有几列
    int conlength = 0;
    if (len <= 3) {
      conlength = len;
      rowlength = 1;
    } else if (len <= 6) {
      conlength = 3;
      rowlength = 2;
      if (len == 4) {
        conlength = 2;
      }
    } else {
      conlength = 3;
      rowlength = 3;
    }
    //一行的组件
    List<Widget> imgList = [];
    //一行包含三个图片组件
    List<List<Widget>> rows = [];
    //遍历行数和列数,计算出宽高生成每个图片组件,
    for (var row = 0; row < rowlength; row++) {
      List<Widget> rowArr = [];
      for (var col = 0; col < conlength; col++) {
        num index = row * conlength + col;
        num screenWidth = MediaQuery.of(context).size.width;
        double cellWidth = (screenWidth - 40) / 3;
        double itemW = 0;
        double itemH = 0;
        if (len == 1) {
          itemW = cellWidth;
          itemH = cellWidth;
        } else if (len <= 3) {
          itemW = cellWidth;
          itemH = cellWidth;
        } else if (len <= 6) {
          itemW = cellWidth;
          itemH = cellWidth;
          if (len == 4) {
            itemW = cellWidth;
            itemH = cellWidth;
          }
        } else {
          itemW = cellWidth;
          itemH = cellWidth;
        }
        if (len == 1) {
          rowArr.add(Container(
            constraints: BoxConstraints(
                maxHeight: 250, maxWidth: 250, minHeight: 200, minWidth: 200),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.network(picList[index], fit: BoxFit.cover),
            ),
          ));
        } else {
          if (index < len) {
            EdgeInsets mMargin;
            if (len == 4) {
              if (index == 0) {
                mMargin = const EdgeInsets.only(right: 2.5, bottom: 5);
              } else if (index == 1) {
                mMargin = const EdgeInsets.only(left: 2.5, bottom: 5);
              } else if (index == 2) {
                mMargin = const EdgeInsets.only(right: 2.5);
              } else if (index == 3) {
                mMargin = const EdgeInsets.only(left: 2.5);
              }
            } else {
              if (index == 1 || index == 4 || index == 7) {
                mMargin =
                    const EdgeInsets.only(left: 2.5, right: 2.5, bottom: 5);
              } else if (index == 0 || index == 3 || index == 6) {
                mMargin = const EdgeInsets.only(right: 2.5, bottom: 5);
              } else if (index == 2 || index == 5 || index == 8) {
                mMargin = const EdgeInsets.only(left: 2.5, bottom: 5);
              }
            }

            rowArr.add(Container(
              child: Container(
                margin: mMargin,
                child: Image.network(
                  picList[index],
                  fit: BoxFit.cover,
                  width: itemW,
                  height: itemH,
                ),
              ),
            ));
          }
        }
      }
      rows.add(rowArr);
    }
    for (var row in rows) {
      imgList.add(Row(
        children: row,
      ));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
      child: Column(
        children: imgList,
      ),
    );
  } else {
    return Container(
      height: 0,
    );
  }
}
