class RecordResponse {
  bool success;
  String path;
  String msg;
  String key;
  double audioTimeLength;

  RecordResponse(
      {this.success, this.path, this.msg, this.key, this.audioTimeLength});
//  RecordResponse({this.success, this.path,this.msg,this.key});

}
