import 'WeiBoModel.dart';



class FindHomeModel {
  List<Findkind> findkind;
  List<Findhottop> findhottop;
  Findhotcenter findhotcenter;
  Findtopic findtopic;
   List<WeiBoModel> findhot;
  List<WeiBoModel> findlocal;
  List<WeiBoModel> findsupertopic;


  FindHomeModel({this.findkind, this.findhottop, this.findhotcenter, this.findtopic, this.findhot, this.findlocal,this.findsupertopic});

  FindHomeModel.fromJson(Map<String, dynamic> json) {
    if (json['findkind'] != null) {
      findkind = new List<Findkind>();
      json['findkind'].forEach((v) {
        findkind.add(new Findkind.fromJson(v));
      });
    }
    if (json['findhottop'] != null) {
      findhottop = new List<Findhottop>();
      json['findhottop'].forEach((v) {
        findhottop.add(new Findhottop.fromJson(v));
      });
    }
    findhotcenter = json['findhotcenter'] != null
        ? new Findhotcenter.fromJson(json['findhotcenter'])
        : null;
    findtopic = json['findtopic'] != null
        ? new Findtopic.fromJson(json['findtopic'])
        : null;
    if (json['findhot'] != null) {
      findhot = new List<WeiBoModel>();
      json['findhot'].forEach((v) {
        findhot.add(new WeiBoModel.fromJson(v));
      });
    }
    if (json['findlocal'] != null) {
      findlocal = new List<WeiBoModel>();
      json['findlocal'].forEach((v) {
        findlocal.add(new WeiBoModel.fromJson(v));
      });
    }
    if (json['findsupertopic'] != null) {
      findsupertopic = new List<WeiBoModel>();
      json['findsupertopic'].forEach((v) {
        findsupertopic.add(new WeiBoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.findkind != null) {
      data['findkind'] = this.findkind.map((v) => v.toJson()).toList();
    }
    if (this.findhottop != null) {
      data['findhottop'] = this.findhottop.map((v) => v.toJson()).toList();
    }
    if (this.findhotcenter != null) {
      data['findhotcenter'] = this.findhotcenter.toJson();
    }
    if (this.findtopic != null) {
      data['findtopic'] = this.findtopic.toJson();
    }
    if (this.findhot != null) {
      data['findhot'] = this.findhot.map((v) => v.toJson()).toList();
    }
    if (this.findlocal != null) {
      data['findlocal'] = this.findlocal.map((v) => v.toJson()).toList();
    }
    if (this.findsupertopic != null) {
      data['findsupertopic'] = this.findsupertopic.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Findkind {
  int id;
  String name;
  String img;

  Findkind({this.id, this.name, this.img});

  Findkind.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    return data;
  }
}

class Findhottop {
  String hotid;
  String hotdesc;
  String hottype;
  String hotread;
  int hotattitude;
  String hotdiscuss;
  String hothost;
  String recommendcoverimg;

  Findhottop(
      {this.hotid,
        this.hotdesc,
        this.hottype,
        this.hotread,
        this.hotattitude,
        this.hotdiscuss,
        this.hothost,
        this.recommendcoverimg});

  Findhottop.fromJson(Map<String, dynamic> json) {
    hotid = json['hotid'];
    hotdesc = json['hotdesc'];
    hottype = json['hottype'];
    hotread = json['hotread'];
    hotattitude = json['hotattitude'];
    hotdiscuss = json['hotdiscuss'];
    hothost = json['hothost'];
    recommendcoverimg = json['recommendcoverimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotid'] = this.hotid;
    data['hotdesc'] = this.hotdesc;
    data['hottype'] = this.hottype;
    data['hotread'] = this.hotread;
    data['hotattitude'] = this.hotattitude;
    data['hotdiscuss'] = this.hotdiscuss;
    data['hothost'] = this.hothost;
    data['recommendcoverimg'] = this.recommendcoverimg;
    return data;
  }
}

class Findhotcenter {
  List<Findhottop> page1;
  List<Findhottop> page2;
  List<Findhottop> page3;
  List<Findhottop> page4;
  List<Findhottop> page5;

  Findhotcenter({this.page1, this.page2, this.page3, this.page4, this.page5});

  Findhotcenter.fromJson(Map<String, dynamic> json) {
    if (json['page1'] != null) {
      page1 = new List<Findhottop>();
      json['page1'].forEach((v) {
        page1.add(new Findhottop.fromJson(v));
      });
    }
    if (json['page2'] != null) {
      page2 = new List<Findhottop>();
      json['page2'].forEach((v) {
        page2.add(new Findhottop.fromJson(v));
      });
    }
    if (json['page3'] != null) {
      page3 = new List<Findhottop>();
      json['page3'].forEach((v) {
        page3.add(new Findhottop.fromJson(v));
      });
    }
    if (json['page4'] != null) {
      page4 = new List<Findhottop>();
      json['page4'].forEach((v) {
        page4.add(new Findhottop.fromJson(v));
      });
    }
    if (json['page5'] != null) {
      page5 = new List<Findhottop>();
      json['page5'].forEach((v) {
        page5.add(new Findhottop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.page1 != null) {
      data['page1'] = this.page1.map((v) => v.toJson()).toList();
    }
    if (this.page2 != null) {
      data['page2'] = this.page2.map((v) => v.toJson()).toList();
    }
    if (this.page3 != null) {
      data['page3'] = this.page3.map((v) => v.toJson()).toList();
    }
    if (this.page4 != null) {
      data['page4'] = this.page4.map((v) => v.toJson()).toList();
    }
    if (this.page5 != null) {
      data['page5'] = this.page5.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Findtopic {
  List<Topic1> topic1;
  List<Topic1> topic2;
  List<Topic1> topic3;
  List<WeiBoModel> topiclist;

  Findtopic({this.topic1, this.topic2, this.topic3, this.topiclist});

  Findtopic.fromJson(Map<String, dynamic> json) {
    if (json['topic1'] != null) {
      topic1 = new List<Topic1>();
      json['topic1'].forEach((v) {
        topic1.add(new Topic1.fromJson(v));
      });
    }
    if (json['topic2'] != null) {
      topic2 = new List<Topic1>();
      json['topic2'].forEach((v) {
        topic2.add(new Topic1.fromJson(v));
      });
    }
    if (json['topic3'] != null) {
      topic3 = new List<Topic1>();
      json['topic3'].forEach((v) {
        topic3.add(new Topic1.fromJson(v));
      });
    }
    if (json['topiclist'] != null) {
      topiclist = new List<WeiBoModel>();
      json['topiclist'].forEach((v) {
        topiclist.add(new WeiBoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topic1 != null) {
      data['topic1'] = this.topic1.map((v) => v.toJson()).toList();
    }
    if (this.topic2 != null) {
      data['topic2'] = this.topic2.map((v) => v.toJson()).toList();
    }
    if (this.topic3 != null) {
      data['topic3'] = this.topic3.map((v) => v.toJson()).toList();
    }
    if (this.topiclist != null) {
      data['topiclist'] = this.topiclist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topic1 {
  String topicid;
  String topictype;
  String topicdesc;
  String topicread;
  String topicdiscuss;
  String topichost;
  String topicattitude;
  String topicimg;
  String topicintro;

  Topic1(
      {this.topicid,
        this.topictype,
        this.topicdesc,
        this.topicread,
        this.topicdiscuss,
        this.topichost,
        this.topicattitude,
        this.topicimg,
        this.topicintro});

  Topic1.fromJson(Map<String, dynamic> json) {
    topicid = json['topicid'];
    topictype = json['topictype'];
    topicdesc = json['topicdesc'];
    topicread = json['topicread'];
    topicdiscuss = json['topicdiscuss'];
    topichost = json['topichost'];
    topicattitude = json['topicattitude'];
    topicimg = json['topicimg'];
    topicintro= json['topicintro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicid'] = this.topicid;
    data['topictype'] = this.topictype;
    data['topicdesc'] = this.topicdesc;
    data['topicread'] = this.topicread;
    data['topicdiscuss'] = this.topicdiscuss;
    data['topichost'] = this.topichost;
    data['topicattitude'] = this.topicattitude;
    data['topicimg'] = this.topicimg;
    data['topicintro'] = this.topicintro;

    return data;
  }
}
