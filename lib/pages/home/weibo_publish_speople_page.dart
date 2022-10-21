import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/WeiboAtUser.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:lpinyin/lpinyin.dart';

class WeiBoPublishAtUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _WeiBoPublishAtUserPageState();
  }
}

class _WeiBoPublishAtUserPageState extends State<WeiBoPublishAtUserPage> {
  List<WeiboAtUser> mNormalList =[];
  List<WeiboAtUser> mRecommendList =[];

  int _suspensionHeight = 30;
  int _itemHeight = 60;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    DioManager.instance.post(ServiceUrl.getWeiBoAtUser, null, (data) {
      // List<WeiboAtUser> listRecommend =[];
      //  List<WeiboAtUser> listNormal=[];

      data['hotusers'].forEach((data) {
        mRecommendList.add(WeiboAtUser.fromJson(data));
      });
      data['normalusers'].forEach((data) {
        mNormalList.add(WeiboAtUser.fromJson(data));
      });

      mRecommendList.forEach((value) {
        value.tagIndex = "★";
      });
      _handleList(mNormalList);
      setState(() {
        _suspensionTag = mRecommendList[0].getSuspensionTag();
      });
    }, (error) {});
  }

  void _handleList(List<WeiboAtUser> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].nick);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(mNormalList);
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  Widget _buildSusWidget(String susTag) {
    susTag = (susTag == "★" ? "推荐联系人" : susTag);
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(WeiboAtUser mModel) {
    String susTag = mModel.getSuspensionTag();
    susTag = (susTag == "1" ? "热门城市" : susTag);
    return Column(
      children: <Widget>[
        Offstage(
          offstage: mModel.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 15),
                    child: CircleAvatar(
                      //头像半径
                      radius: 15,
                      //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                      backgroundImage: NetworkImage('${mModel.headurl}'),
                    )),
                Container(
                  child: Text(
                    '${mModel.nick}',
                    style: TextStyle(
                        letterSpacing: 0, color: Colors.black, fontSize: 14),
                  ),
                ),
              ],
            ),
            onTap: () {
              print("OnItemClick: $mModel");
              Navigator.of(context).pop(mModel);
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Color(0xffffffff),
            leading: IconButton(
                iconSize: 30,
                icon: Image.asset(
                  Constant.ASSETS_IMG + 'icon_back.png',
                  width: 23.0,
                  height: 23.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              '联系人',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            elevation: 0,
            centerTitle: true,
          ),
          preferredSize: Size.fromHeight(50)),
      body: Column(
        children: <Widget>[
          Container(
              child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
                padding: EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Color(0xffE4E2E8),
                  borderRadius: BorderRadius.all(
                    //圆角
                    Radius.circular(5.0),
                  ),
                ),
                child: Center(
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
                  ),
                )),
          )),
        /*  Expanded(
              flex: 1,
              child: AzListView(
                data: mNormalList,
                //topData: mRecommendList,
                itemBuilder: (context, model) => _buildListItem(model as WeiboAtUser),
               // susItemHeight: susItemHeight,

                //  suspensionWidget: _buildSusWidget(_suspensionTag),
              //  isUseRealIndex: true,
              //  itemHeight: _itemHeight,
             //   suspensionHeight: _suspensionHeight,
              //  onSusTagChanged: _onSusTagChanged,
                //showCenterTip: false,
              )),*/
          Expanded(
            flex: 1,
            child: AzListView(
              data: mNormalList,
              itemCount: mNormalList.length,
              itemBuilder: (BuildContext context, int index) {

                 return  _buildListItem(mNormalList[index] );
              },
              susItemHeight: 20,
              susItemBuilder: (BuildContext context, int index) {

                return _buildListItem(mRecommendList[index] );
              },
              indexBarData: SuspensionUtil.getTagIndexList(mNormalList),

            ),
          ),
          ],
      ),
    ));
  }
}
