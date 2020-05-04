class HrlMessage {
  String uuid;
  HrlMessageState state;
  bool isSend;
  HrlUserInfo from;
  HrlUserInfo target;
  int createTime; // 发送消息时间
  HrlMessageType msgType;

  HrlMessage({this.uuid, this.state, this.isSend, this.from, this.target, this.createTime, this.msgType});


  Map toJson() {
    return {
      'uuid': uuid,
      'isSend': isSend,
      'from': from.toJson(),
      'createTime': createTime,
      'target': target.toJson(),
      'type': msgType.toString()
    };
  }

  HrlMessage.fromJson(Map<dynamic, dynamic> json)
      : uuid = json['uuid'],
        createTime = json['createTime'],
        isSend = json['isSend'],
        from = HrlUserInfo.fromJson(json['from']),
        target = HrlUserInfo.fromJson(json['target']),
        msgType = json['msgType'];

  static dynamic generateMessageFromJson(Map<dynamic, dynamic> json) {
    if (json == null) {
      return null;
    }

    HrlMessageType type =
        getEnumFromString(HrlMessageType.values, json['type']);
    switch (type) {
      case HrlMessageType.text:
        return HrlTextMessage.fromJson(json);
        break;
      case HrlMessageType.image:
        return HrlImageMessage.fromJson(json);
        break;
      case HrlMessageType.voice:
        return HrlVoiceMessage.fromJson(json);
        break;
    }
  }
}

enum HrlMessageState {
  sending, // 正在发送中
  send_succeed, // 发送成功
  send_failed, // 发送失败
}

enum HrlMessageType { text, image, voice }

class HrlUserInfo {
  String id;
  String username;
  String nick;
  String headurl;

  Map toJson() {
    return {
      'id': id,
      'username': username,
      'nick': nick,
      'headurl': headurl,
    };
  }

  HrlUserInfo.fromJson(Map<dynamic, dynamic> json)
      : username = json['username'],
        id = json['id'],
        headurl = json['headurl'],
        nick = json['nick'];
}

class HrlImageMessage extends HrlMessage {
  String thumbPath;
  String thumbUrl;

  HrlImageMessage({this.thumbPath,this.thumbUrl });
  Map toJson() {
    var json = super.toJson();
    json['thumbPath'] = thumbPath;
    json['thumbUrl'] = thumbUrl;

    return json;
  }

  HrlImageMessage.fromJson(Map<dynamic, dynamic> json)
      : thumbPath = json['thumbPath'],

  super.fromJson(json);
}

class HrlTextMessage extends HrlMessage {
     String text;


  HrlTextMessage({this.text });



  Map toJson() {
    var json = super.toJson();
    json['text'] = text;
    return json;
  }

  HrlTextMessage.fromJson(Map<dynamic, dynamic> json)
      : text = json['text'],
        super.fromJson(json);
}

class HrlVoiceMessage extends HrlMessage {
  String path; // 语音文件路径,如果为空需要调用相应下载方法，注意这是本地路径，不能是 url
  String remoteUrl;

  int duration; // 语音时长，单位秒



  HrlVoiceMessage( );

  Map toJson() {
    var json = super.toJson();
    json['path'] = path;
    json['duration'] = duration;
    json['remoteUrl'] = remoteUrl;

    return json;
  }

  HrlVoiceMessage.fromJson(Map<dynamic, dynamic> json)
      : path = json['path'],
        duration = json['duration'],
        remoteUrl = json['remoteUrl'],

      super.fromJson(json);
}

T getEnumFromString<T>(Iterable<T> values, String str) {
  return values.firstWhere((f) => f.toString().split('.').last == str,
      orElse: () => null);
}

String getStringFromEnum<T>(T) {
  if (T == null) {
    return null;
  }
  return T.toString().split('.').last;
}
