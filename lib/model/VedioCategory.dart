

class VedioCategory {
  int id;
  String cname;



  VedioCategory({this.id, this.cname});

  VedioCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cname = json['cname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cname'] = this.cname;
    return data;
  }

  @override
  String toString() {
    return 'VedioCategory{id: $id, cname: $cname}';
  }


}