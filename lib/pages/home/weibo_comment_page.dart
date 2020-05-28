import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/public.dart';

//微博详情评论界面
class CommentDialogPage extends StatefulWidget {
  String mWeiBoOrCommentId;
  bool isReplyWeiBo; //评论微博或者评论微博的回复
  Function() notifyParent;

  CommentDialogPage(
      this.mWeiBoOrCommentId, this.isReplyWeiBo, this.notifyParent);

  @override
  _CommentDialogPageState createState() => _CommentDialogPageState();
}

class _CommentDialogPageState extends State<CommentDialogPage> {
  bool _checkValue = false;
  TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff8C333333),
        body: Align(
            //对齐底部
            alignment: Alignment.bottomCenter,
            child: Container(
                child: Container(
                    color: Color(0xffF8F8F8),
                    height: 140,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      //  mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start, //主轴从上到下
                          children: <Widget>[
                            buildTextField(context),
                            buildEtRight(),
                          ],
                        ),
                        buildEtBottom(),
                      ],
                    )))));
  }

  //输入框布局
  Widget buildTextField(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 15, top: 15),
        //padding: const EdgeInsets.all(8.0),
        //    alignment: Alignment.center,
        // color: Colors.blue,
        width: ((MediaQuery.of(context).size.width / 5) * 4),
        child: TextField(
          style: TextStyle(color: Colors.black, fontSize: 13),
          cursorColor: Colors.orange,
          maxLines: 5,
          controller: _inputController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
            ),
            /*     disabledBorder:const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),

          ),*/

            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
            ),
            hintText: "写评论...",
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        )
        /* child: Text('aaa'),*/
        );
  }

  //输入框右侧发送按钮所在布局
  Widget buildEtRight() {
    return Container(
        margin: EdgeInsets.only(top: 15, left: 15),
        child: Align(
          alignment: Alignment.topRight,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Image.asset(
                  Constant.ASSETS_IMG + 'icon_comment_zhankai.png',
                  width: 20.0,
                  height: 20.0,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 40),
                  child: InkWell(
                    child: Text('发送'),
                    onTap: () {
                      if (_inputController.text.isEmpty) {
                        ToastUtil.show('评论内容不能为空!');
                        return;
                      }

                      if (widget.isReplyWeiBo) {
                        //如果是评论微博
                        FormData formData = FormData.fromMap({
                          "userId": UserUtil.getUserInfo().id,
                          "content": _inputController.text.toString(),
                          "weiboId": widget.mWeiBoOrCommentId
                        });
                        DioManager.getInstance()
                            .post(ServiceUrl.addComments, formData, (data) {
                          _inputController.clear();
                          ToastUtil.show('评论成功!');
                          widget.notifyParent();
                        }, (error) {
                          ToastUtil.show('评论失败:' + error);
                        });
                      } else {
                        //如果是评论微博的回复
                        FormData formData = FormData.fromMap({
                          "userId": UserUtil.getUserInfo().id,
                          "content": _inputController.text.toString(),
                          "commentid": widget.mWeiBoOrCommentId
                        });
                        DioManager.getInstance().post(
                            ServiceUrl.addCommentsReply, formData, (data) {
                          _inputController.clear();
                          ToastUtil.show('评论成功!');
                          widget.notifyParent();
                        }, (error) {
                          ToastUtil.show('评论失败:' + error);
                        });
                      }
                    },
                  ))
            ],
          ),
        ));
  }

  //输入框底部布局
  Widget buildEtBottom() {
    return Container(
        margin: EdgeInsets.only(left: 15, right: 5, bottom: 5, top: 10),
        child: Row(
          /* mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,*/
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  _checkValue = !_checkValue;
                });
              },
              child: Container(
                // decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: _checkValue
                      ? Image.asset(
                          Constant.ASSETS_IMG + 'guide_checkbox_checked.png',
                          width: 20.0,
                          height: 20.0,
                        )
                      : Image.asset(
                          Constant.ASSETS_IMG + 'guide_checkbox.png',
                          width: 20.0,
                          height: 20.0,
                        ),
                ),
              ),
            ),
            Text('同时转发'),
            new Expanded(
              child: InkWell(
                child: Image.asset(
                  Constant.ASSETS_IMG + 'icon_picture.png',
                  width: 20.0,
                  height: 20.0,
                ),
                onTap: () {},
              ),
              flex: 1,
            ),
            new Expanded(
              child: InkWell(
                child: Image.asset(
                  Constant.ASSETS_IMG + 'icon_mention.png',
                  width: 20.0,
                  height: 20.0,
                ),
                onTap: () {},
              ),
              flex: 1,
            ),
            new Expanded(
              child: InkWell(
                child: Image.asset(
                  Constant.ASSETS_IMG + 'icon_gif.png',
                  width: 20.0,
                  height: 20.0,
                ),
                onTap: () {},
              ),
              flex: 1,
            ),
            new Expanded(
              child: InkWell(
                child: Image.asset(
                  Constant.ASSETS_IMG + 'icon_emotion.png',
                  width: 20.0,
                  height: 20.0,
                ),
                onTap: () {},
              ),
              flex: 1,
            ),
            new Expanded(
              child: InkWell(
                child: Image.asset(
                  Constant.ASSETS_IMG + 'icon_add.png',
                  width: 20.0,
                  height: 20.0,
                ),
                onTap: () {},
              ),
            ),
          ],
        ));
  }
}
