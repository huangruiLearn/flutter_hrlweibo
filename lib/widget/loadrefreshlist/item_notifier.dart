import 'package:flutter/material.dart';

typedef Widget ItemBuilder<T>(BuildContext context, T entry, int index);
typedef Future<List<T>> PageRequest<T>(int? pageIndex);

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
  bool _isLoadingMore = false;


  ItemNotifier({required this.pageRequest});

  List<T> get mDataList => this._mDataList;

  int get numberOfLoadedPages => this._mPageNumber;

  bool get hasMoreItems => this._hasMoreItems;

  bool get loadMoreError => this._loadMoreError;

  bool get isShowEmptyView => this._isShowEmptyView;

  bool get isShowErrorView => this._isShowErrorView;

  bool get isFirstLoading => this._isFirstLoading;

  bool get isLoadingMore => this._isLoadingMore;


  Future<void> onRefresh(bool isFirstLoading) async {
    print("执行onRefresh：$isFirstLoading");
    if(_isLoadingMore){
      return;
    }
    List<T> mResult;
    try {
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
      _mDataList = [];
      _mDataList.addAll(mResult);
      notifyListeners();
    } catch (error) {
      _hasMoreItems = false;
      _isFirstLoading = false;
      _isShowEmptyView = false;
      _isShowErrorView = true;
      _loadMoreError = false;
      this.notifyListeners();
    }
  }

  Future<void> onLoadMore() async {


    try {
      _isLoadingMore=true;
      this._mPageNumber++;
      print("掉用加载更多:" + _mPageNumber.toString());
      List<T> mResult = await this.pageRequest!(this._mPageNumber);
      if (mResult.length < this.pageSize) {
        this._hasMoreItems = false;
      } else {
        this._hasMoreItems = true;
      }
      print("掉用加载更多的返回值:"+mResult.length .toString() );
      _isLoadingMore=false;
       this._mDataList.addAll(mResult);
      notifyListeners();
    } catch (error) {
      _mPageNumber--;
       _loadMoreError = true;
      _isLoadingMore=false;

      this.notifyListeners();
      return;
    }
  }

  void refreshRetry() {
    _isFirstLoading = true;
    notifyListeners();
    onRefresh(true);
  }

  void loadmoreRetry(bool doLoadMore) {
    _loadMoreError = false;
    _hasMoreItems = true;
    notifyListeners();
    if(doLoadMore){
      onLoadMore();
    }

  }
}
