

class ComZanListModel {
  int pageNum;
  int pageSize;
  int size;
  Null orderBy;
  int startRow;
  int endRow;
  int total;
  int pages;
  List<ComZanModel> list;
  int firstPage;
  int prePage;
  int nextPage;
  int lastPage;
  bool isFirstPage;
  bool isLastPage;
  bool hasPreviousPage;
  bool hasNextPage;
  int navigatePages;

  ComZanListModel(
      {this.pageNum,
        this.pageSize,
        this.size,
        this.orderBy,
        this.startRow,
        this.endRow,
        this.total,
        this.pages,
        this.list,
        this.firstPage,
        this.prePage,
        this.nextPage,
        this.lastPage,
        this.isFirstPage,
        this.isLastPage,
        this.hasPreviousPage,
        this.hasNextPage,
        this.navigatePages,
      });

  ComZanListModel.fromJson(Map<String, dynamic> json) {
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    size = json['size'];
    orderBy = json['orderBy'];
    startRow = json['startRow'];
    endRow = json['endRow'];
    total = json['total'];
    pages = json['pages'];
    if (json['list'] != null) {
      list = new List<ComZanModel>();
      json['list'].forEach((v) {
        list.add(new ComZanModel.fromJson(v));
      });
    }
    firstPage = json['firstPage'];
    prePage = json['prePage'];
    nextPage = json['nextPage'];
    lastPage = json['lastPage'];
    isFirstPage = json['isFirstPage'];
    isLastPage = json['isLastPage'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    navigatePages = json['navigatePages'];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNum'] = this.pageNum;
    data['pageSize'] = this.pageSize;
    data['size'] = this.size;
    data['orderBy'] = this.orderBy;
    data['startRow'] = this.startRow;
    data['endRow'] = this.endRow;
    data['total'] = this.total;
    data['pages'] = this.pages;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['firstPage'] = this.firstPage;
    data['prePage'] = this.prePage;
    data['nextPage'] = this.nextPage;
    data['lastPage'] = this.lastPage;
    data['isFirstPage'] = this.isFirstPage;
    data['isLastPage'] = this.isLastPage;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['hasNextPage'] = this.hasNextPage;
    data['navigatePages'] = this.navigatePages;
     return data;
  }
}

class ComZanModel {
  String userid;
  String username;
  String userheadurl;
  int createtime;
  String content;
  String tail;
  String weiboid;
  String weibcontent;
  String weibousername;
  String weibopicurl;
  int ismember;
  int isvertify;

  ComZanModel(
      {this.userid,
        this.username,
        this.userheadurl,
        this.createtime,
        this.content,
        this.tail,
        this.weiboid,
        this.weibcontent,
        this.weibousername,
        this.weibopicurl,
        this.ismember,
        this.isvertify});

  ComZanModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    userheadurl = json['userheadurl'];
    createtime = json['createtime'];
    content = json['content'];
    tail = json['tail'];
    weiboid = json['weiboid'];
    weibcontent = json['weibcontent'];
    weibousername = json['weibousername'];
    weibopicurl = json['weibopicurl'];
    ismember = json['ismember'];
    isvertify = json['isvertify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['username'] = this.username;
    data['userheadurl'] = this.userheadurl;
    data['createtime'] = this.createtime;
    data['content'] = this.content;
    data['tail'] = this.tail;
    data['weiboid'] = this.weiboid;
    data['weibcontent'] = this.weibcontent;
    data['weibousername'] = this.weibousername;
    data['weibopicurl'] = this.weibopicurl;
    data['ismember'] = this.ismember;
    data['isvertify'] = this.isvertify;
    return data;
  }
}