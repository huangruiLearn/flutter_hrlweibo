


class FindTopicModel {
    String img;
    String desc;


    FindTopicModel({this.img, this.desc });

    FindTopicModel.fromJson(Map<String, dynamic> json) {
      img = json['img'];
      img = json['desc'];

    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['img'] = this.img;
      data['desc'] = this.desc;

      return data;
    }
}




