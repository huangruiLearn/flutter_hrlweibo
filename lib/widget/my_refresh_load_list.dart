import 'package:flutter/material.dart';

import '../constant/constant.dart';

typedef Widget ItemBuilder<T>(BuildContext context, T entry, int index);
typedef Future<List<T>> PageRequest<T>(int? pageIndex);

//通用下拉刷新上拉加载更多
class HrlListView<T> extends StatefulWidget {
  final int? pageSize;
  final PageRequest<T>? pageFuture;
  final ItemBuilder<T> itemBuilder;

  HrlListView({
    this.pageSize,
    this.pageFuture,
    Key? key,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  HrlListViewState<T> createState() => HrlListViewState<T>();
}

class HrlListViewState<T> extends State<HrlListView<T>> {
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
  void didUpdateWidget(HrlListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print("开始重新构建：");
    if (itemNotifier.isFirstLoading) {
      //第一次进入页面在中间显示loading
      return Container(
         // margin: EdgeInsets.only( top: 100),
           width: 50.0,
          height: 50.0,
          child: Center(
             child: CircularProgressIndicator(),
          )) ;
    } else if (itemNotifier.isShowEmptyView) {
      //下拉刷新为空,显示空布局
      return RefreshIndicator(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: Center(
                child: Text('没有任何数据'),
              ),
              height: MediaQuery.of(context).size.height,
            ),
          ),
          onRefresh: () => itemNotifier.onRefresh(true));
    } else if (itemNotifier.isShowErrorView) {
      //第一次获取数据失败,
      return InkWell(
        onTap:  itemNotifier.refreshRetry ,
       child: Container(
          child:Column(
            children: [
              Container(
                margin: EdgeInsets.only( top: 100),
                child: Image.asset(
                  Constant.ASSETS_IMG + 'load_error.png',
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5, top:20),
                child: Text("加载失败,点击重试",style: TextStyle(fontSize: 14, color: Colors.grey),)
              )
            ],
          )),
      );
    } else {
      //第一次进入获取到数据
      return RefreshIndicator(
          child: ListView.builder(
            itemCount: itemNotifier.mDataList.length + 1,
            itemBuilder: _itemBuilder,
            physics: const AlwaysScrollableScrollPhysics(),
          ),
          onRefresh: () => itemNotifier.onRefresh(false));
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final total = itemNotifier.mDataList.length + 1;
    print("开始构建total：" + total.toString() + "index:" + index.toString());
    if (index == total - 1) {
      //如果加载到最后一个数据
      if (itemNotifier.loadMoreError==true) {
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[300],
            shape: CircleBorder(),
          ),
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: this.itemNotifier.retry,
        );
      }

      if (this.itemNotifier.hasMoreItems) {
        this.itemNotifier.onLoadMore(false);
        return CircularProgressIndicator();
      } else {
        return Container(
          child: Text('没有更多数据了'),
        );
      }
    } else {

      return widget.itemBuilder(
          context, this.itemNotifier.mDataList[index], index);

    }
  }

}

class ItemNotifier<T> extends ChangeNotifier {
  List<T> _mDataList = <T>[];
  late final PageRequest<T>? pageRequest;
  int _mPageNumber = 1;
  final int pageSize = 10;
  bool _isFirstLoading = true;
  bool _isShowErrorView = false;
  bool _isShowEmptyView = false;
  bool _hasMoreItems = true;
  bool _loadMoreError = false;

  ItemNotifier({required this.pageRequest});

  List<T> get mDataList => this._mDataList;

  int get numberOfLoadedPages => this._mPageNumber;

  bool get hasMoreItems => this._hasMoreItems;

  bool get loadMoreError => this._loadMoreError;

  bool get isShowEmptyView => this._isShowEmptyView;

  bool get isShowErrorView => this._isShowErrorView;

  bool get isFirstLoading => this._isFirstLoading;

  Future<void> onRefresh(bool isFirstLoading) async {
    print("执行onRefresh：$isFirstLoading");
    List<T> mResult;
    try {
      _mDataList = [];
      _mPageNumber = 1;
      _hasMoreItems = true;
      _isFirstLoading = isFirstLoading;
      _isShowEmptyView = false;
      _isShowErrorView = false;
      _loadMoreError = false;
      mResult = await this.pageRequest!(this._mPageNumber);
      final int length = mResult.length;
      if (length == 0) {
        _hasMoreItems = false;
        _isFirstLoading = false;
        _isShowEmptyView = true;
        _isShowErrorView = false;
        _loadMoreError = false;
      } else if (length < this.pageSize) {
        _hasMoreItems = true;
        _isFirstLoading = false;
        _isShowEmptyView = false;
        _isShowErrorView = false;
        _loadMoreError = false;
      } else {
        _hasMoreItems = true;
        _isFirstLoading = false;
        _isShowEmptyView = false;
        _isShowErrorView = false;
        _loadMoreError = false;
      }
      _mDataList.addAll(mResult);
      print("执行onRefresh-isFirstLoading：$isFirstLoading成功");
      notifyListeners();
    } catch (error) {
      print("执行onRefresh-isFirstLoading：$isFirstLoading失败");
      _hasMoreItems = false;
      _isFirstLoading = false;
      _isShowEmptyView = false;
      _isShowErrorView = true;
      _loadMoreError = false;
      this.notifyListeners();
    }
  }

  Future<void> onLoadMore(bool isRetry) async {
    print("掉用加载更多");
    try {
      if (!isRetry) {
        this._mPageNumber++;
      }
      List<T> mResult = await this.pageRequest!(this._mPageNumber);
      if (mResult.length < this.pageSize) {
        this._hasMoreItems = false;
      } else {
        this._hasMoreItems = true;
      }
      this._mDataList.addAll(mResult);
      notifyListeners();
    } catch (error) {
      _loadMoreError = true;
      this.notifyListeners();
      return;
    }
  }

  void refreshRetry() {
    _isFirstLoading = true;
    notifyListeners();
    onRefresh(true);
  }

  void retry() {
    _loadMoreError = false;
    onLoadMore(true);
    // this.notifyListeners();
  }
}
