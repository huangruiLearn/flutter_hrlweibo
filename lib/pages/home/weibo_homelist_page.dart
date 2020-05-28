import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/http/service_url.dart';
import 'package:flutter_hrlweibo/model/WeiBoModel.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/widget/loading_container.dart';
import '../../http/service_method.dart';
import '../../model/WeiBoListModel.dart';
import '../../widget/weiboitem/WeiBoItem.dart';
import '../home/weibo_detail_page.dart';

class WeiBoHomeListPager extends StatefulWidget {
  String mCatId = "";

  WeiBoHomeListPager({Key key, @required this.mCatId}) : super(key: key);

  @override
  _WeiBoHomeListPagerState createState() => _WeiBoHomeListPagerState();
}

class _WeiBoHomeListPagerState extends State<WeiBoHomeListPager>
    with AutomaticKeepAliveClientMixin {
  bool isRefreshloading = true;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;
  ScrollController _scrollController = new ScrollController();
  List<WeiBoModel> hotContentList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    getSubDataRefresh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("调用加载更多");
        if (!isloadingMore) {
          if (ishasMore) {
            setState(() {
              isloadingMore = true;
              mCurPage += 1;
            });
            getSubDataLoadMore(mCurPage);
          } else {
            print('没有更多数据');
            setState(() {
              ishasMore = false;
            });
          }
        }
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future getSubDataRefresh() async {
    isloadingMore = false;
    ishasMore = true;
    mCurPage = 1;

    FormData formData = FormData.fromMap({
      "catid": widget.mCatId,
      "pageNum": "1",
      "pageSize": Constant.PAGE_SIZE,
      "userId": UserUtil.getUserInfo().id,
    });

    DioManager.getInstance().post(ServiceUrl.getWeiBo, formData, (data) {
      WeiBoListModel category = WeiBoListModel.fromJson(data);
      hotContentList.clear();
      hotContentList.addAll(category.data.list);
      setState(() {
        isRefreshloading = false;
      });
    }, (error) {
      print("接口异常：" + error);
      //  ToastUtil.show(error);
      setState(() {
        isRefreshloading = false;
      });
    });
  }

  Future getSubDataLoadMore(int page) async {
    FormData formData = FormData.fromMap({
      "catid": widget.mCatId,
      "pageNum": page,
      "pageSize": Constant.PAGE_SIZE,
      "userId": UserUtil.getUserInfo().id,
    });
    List<WeiBoModel> mListRecords = new List();
    await DioManager.getInstance().post(ServiceUrl.getWeiBo, formData, (data) {
      WeiBoListModel category = WeiBoListModel.fromJson(data);
      mListRecords = category.data.list;
      setState(() {
        hotContentList.addAll(mListRecords);
        isloadingMore = false;
        ishasMore = mListRecords.length >= Constant.PAGE_SIZE;
      });
    }, (error) {
      setState(() {
        isloadingMore = false;
        ishasMore = false;
      });
    });
  }

  Widget _buildLoadMore() {
    return isloadingMore
        ? Container(
            child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    height: 12.0,
                    width: 12.0,
                  ),
                ),
                Text("加载中..."),
              ],
            )),
          ))
        : new Container(
            child: ishasMore
                ? new Container()
                : Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "没有更多数据",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ))),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: isRefreshloading,
        child: RefreshIndicator(
          // key: _refreshIndicatorKey,

          onRefresh: getSubDataRefresh,
          child: new ListView.builder(
            itemCount: hotContentList.length + 1,
            itemBuilder: (context, index) {
              if (index == hotContentList.length) {
                return _buildLoadMore();
              } else {
                return getContentItem(context, index, hotContentList);
              }
            },
            controller: _scrollController,
          ),
        ),
      ),
    );
  }

  getContentItem(BuildContext context, int index, List<WeiBoModel> mList) {
    WeiBoModel model = mList[index];
    // return model.momentType == 0 ? getItemTextContainer(model, index) : getItemImageContainer(model, index);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return WeiBoDetailPage(
            mModel: model,
          );
        }));
      },
      child: WeiBoItemWidget(model, false),
    );
  }
}
