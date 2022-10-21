
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/widget/loadmore_error.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/widget/loadmore_loading.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/widget/loadmore_nodata.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/widget/refresh_empty.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/widget/refresh_error.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/widget/refresh_loading.dart';
import 'item_notifier.dart';

//通用下拉刷新上拉加载更多
class HrlSliverGrid<T> extends StatefulWidget {
  final int? pageSize;
  final PageRequest<T>? pageFuture;
  final ItemBuilder<T> itemBuilder;
  final double mGridItemHeight;
  final double mGridItemWidth;




  HrlSliverGrid({
    this.pageSize,
    this.pageFuture,
    Key? key,
    required this.itemBuilder,
    required this.mGridItemHeight,
     required this.mGridItemWidth,

  }) : super(key: key);

  @override
  HrlSliverGridState<T> createState() => HrlSliverGridState<T>();
}

class HrlSliverGridState<T> extends State<HrlSliverGrid<T>> {
  late ItemNotifier<T> itemNotifier;

  @override
  void initState() {
    super.initState();
     itemNotifier = ItemNotifier<T>(pageRequest: widget.pageFuture);
     itemNotifier.addListener(() => mounted ? setState(() {}) : null);
     itemNotifier.onRefresh(true);
  }

  @override
  void dispose() {
    super.dispose();
     itemNotifier.dispose();
  }

  @override
  void didUpdateWidget(HrlSliverGrid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
 /*   var size = MediaQuery.of(context).size;
    final double mGridItemHeight = 200;
    final double mGridItemWidth = size.width / 2;*/

    print("HrlListView开始---build");
    if (itemNotifier.isFirstLoading) {
      //第一次进入页面在中间显示loading
      return RefreshLoading();
    } else if (itemNotifier.isShowEmptyView) {
      //下拉刷新为空,显示空布局
      return RefreshEmpty(itemNotifier: itemNotifier);
    } else if (itemNotifier.isShowErrorView) {
      //第一次获取数据失败,
      return RefreshError(itemNotifier: itemNotifier);
    } else {
    //第一次进入获取到数据
    return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.extentAfter == 0) {
              if( itemNotifier.isLoadingMore ){
                print("正在加载中,不调用加载更多");
              }else if( !itemNotifier.hasMoreItems){
                print("没有更多数据,不调用加载更多");
              }else if( itemNotifier.loadMoreError){
                print("加载失败,不调用加载更多");
              }else{
                print("滑动到底部,调用加载更多");
                itemNotifier.onLoadMore();
              }
            }
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () => itemNotifier.onRefresh(false),
            child:  CustomScrollView(
                slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: (widget.mGridItemWidth / widget.mGridItemHeight),
                crossAxisCount: 2,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return  widget.itemBuilder(
                    context, this.itemNotifier.mDataList[index], index);
              }, childCount: itemNotifier.mDataList.length),
            ),
            SliverToBoxAdapter(
              child: LoadMore (),
            )
          ]),
        )) /* */;
    }
  }

  Widget LoadMore( ) {
    if (itemNotifier.loadMoreError == true) {
      return LoadMoreError(
        itemNotifier: itemNotifier,
        doLoadMore: true,
      );
    }
    if (this.itemNotifier.hasMoreItems) {
      return LoadMoreLoading();
    } else {
      return LoadMoreNoData();
    }
  }


}
