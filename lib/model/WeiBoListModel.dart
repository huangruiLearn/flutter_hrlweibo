import 'WeiBoModel.dart';

class WeiBoListModel {
  int _status;
  Data _data;

  WeiBoListModel({int status, Data data}) {
    this._status = status;
    this._data = data;
  }

  int get status => _status;
  set status(int status) => _status = status;
  Data get data => _data;
  set data(Data data) => _data = data;

  WeiBoListModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class Data {
  int _pageNum;
  int _pageSize;
  int _size;
  Null _orderBy;
  int _startRow;
  int _endRow;
  int _total;
  int _pages;
  List<WeiBoModel> _list;
  int _firstPage;
  int _prePage;
  int _nextPage;
  int _lastPage;
  bool _isFirstPage;
  bool _isLastPage;
  bool _hasPreviousPage;
  bool _hasNextPage;
  int _navigatePages;

  Data(
      {int pageNum,
        int pageSize,
        int size,
        Null orderBy,
        int startRow,
        int endRow,
        int total,
        int pages,
        List<WeiBoModel> list,
        int firstPage,
        int prePage,
        int nextPage,
        int lastPage,
        bool isFirstPage,
        bool isLastPage,
        bool hasPreviousPage,
        bool hasNextPage,
        int navigatePages,
        }) {
    this._pageNum = pageNum;
    this._pageSize = pageSize;
    this._size = size;
    this._orderBy = orderBy;
    this._startRow = startRow;
    this._endRow = endRow;
    this._total = total;
    this._pages = pages;
    this._list = list;
    this._firstPage = firstPage;
    this._prePage = prePage;
    this._nextPage = nextPage;
    this._lastPage = lastPage;
    this._isFirstPage = isFirstPage;
    this._isLastPage = isLastPage;
    this._hasPreviousPage = hasPreviousPage;
    this._hasNextPage = hasNextPage;
    this._navigatePages = navigatePages;
   }

  int get pageNum => _pageNum;
  set pageNum(int pageNum) => _pageNum = pageNum;
  int get pageSize => _pageSize;
  set pageSize(int pageSize) => _pageSize = pageSize;
  int get size => _size;
  set size(int size) => _size = size;
  Null get orderBy => _orderBy;
  set orderBy(Null orderBy) => _orderBy = orderBy;
  int get startRow => _startRow;
  set startRow(int startRow) => _startRow = startRow;
  int get endRow => _endRow;
  set endRow(int endRow) => _endRow = endRow;
  int get total => _total;
  set total(int total) => _total = total;
  int get pages => _pages;
  set pages(int pages) => _pages = pages;
  List<WeiBoModel> get list => _list;
  set list(List<WeiBoModel> list) => _list = list;
  int get firstPage => _firstPage;
  set firstPage(int firstPage) => _firstPage = firstPage;
  int get prePage => _prePage;
  set prePage(int prePage) => _prePage = prePage;
  int get nextPage => _nextPage;
  set nextPage(int nextPage) => _nextPage = nextPage;
  int get lastPage => _lastPage;
  set lastPage(int lastPage) => _lastPage = lastPage;
  bool get isFirstPage => _isFirstPage;
  set isFirstPage(bool isFirstPage) => _isFirstPage = isFirstPage;
  bool get isLastPage => _isLastPage;
  set isLastPage(bool isLastPage) => _isLastPage = isLastPage;
  bool get hasPreviousPage => _hasPreviousPage;
  set hasPreviousPage(bool hasPreviousPage) =>
      _hasPreviousPage = hasPreviousPage;
  bool get hasNextPage => _hasNextPage;
  set hasNextPage(bool hasNextPage) => _hasNextPage = hasNextPage;
  int get navigatePages => _navigatePages;
  set navigatePages(int navigatePages) => _navigatePages = navigatePages;


  Data.fromJson(Map<String, dynamic> json) {
    _pageNum = json['pageNum'];
    _pageSize = json['pageSize'];
    _size = json['size'];
    _orderBy = json['orderBy'];
    _startRow = json['startRow'];
    _endRow = json['endRow'];
    _total = json['total'];
    _pages = json['pages'];
    if (json['list'] != null) {
      _list = new List<WeiBoModel>();
      json['list'].forEach((v) {
        _list.add(new WeiBoModel.fromJson(v));
      });
    }
    _firstPage = json['firstPage'];
    _prePage = json['prePage'];
    _nextPage = json['nextPage'];
    _lastPage = json['lastPage'];
    _isFirstPage = json['isFirstPage'];
    _isLastPage = json['isLastPage'];
    _hasPreviousPage = json['hasPreviousPage'];
    _hasNextPage = json['hasNextPage'];
    _navigatePages = json['navigatePages'];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNum'] = this._pageNum;
    data['pageSize'] = this._pageSize;
    data['size'] = this._size;
    data['orderBy'] = this._orderBy;
    data['startRow'] = this._startRow;
    data['endRow'] = this._endRow;
    data['total'] = this._total;
    data['pages'] = this._pages;

    data['firstPage'] = this._firstPage;
    data['prePage'] = this._prePage;
    data['nextPage'] = this._nextPage;
    data['lastPage'] = this._lastPage;
    data['isFirstPage'] = this._isFirstPage;
    data['isLastPage'] = this._isLastPage;
    data['hasPreviousPage'] = this._hasPreviousPage;
    data['hasNextPage'] = this._hasNextPage;
    data['navigatePages'] = this._navigatePages;
     return data;
  }
}


