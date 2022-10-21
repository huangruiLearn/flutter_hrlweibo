import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/http/service_url.dart';
import 'package:flutter_hrlweibo/model/WeiBoModel.dart';
import 'package:flutter_hrlweibo/public.dart';
import '../../widget/loadrefreshlist/my_refresh_load_listview.dart';
import '../../widget/weiboitem/WeiBoItem.dart';
import '../home/weibo_detail_page.dart';

class WeiBoListPage extends StatefulWidget {
  String mCatId;

  WeiBoListPage({Key? key, required this.mCatId}) : super(key: key);

  @override
  _WeiBoListPageState createState() => _WeiBoListPageState();
}

class _WeiBoListPageState extends State<WeiBoListPage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  Future<List<WeiBoModel>> getListData(pageNum) async {
    FormData formData = FormData.fromMap({
      "catid": widget.mCatId,
      "pageNum": pageNum,
      "pageSize": Constant.PAGE_SIZE,
      "userId": UserUtil.getUserInfo().id,
    });
    Map<String, dynamic> json = await DioManager.instance.post(ServiceUrl.getWeiBo, formData);
    List<WeiBoModel> list = [];
    json['list'].forEach((data) {
      list.add(WeiBoModel.fromJson(data));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HrlListView<WeiBoModel>(
          pageSize: 10,
          itemBuilder: _itemBuilder,
          pageFuture: (pageIndex) => getListData(pageIndex)),
    );
  }

  Widget _itemBuilder(context, WeiBoModel entry, _) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return WeiBoDetailPage(
            mModel: entry,
          );
        }));
      },
      child: WeiBoItemWidget(entry, false),
    );
  }
}
