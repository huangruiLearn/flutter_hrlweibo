import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/toast_util.dart';

//修改个性签名界面
class ChangeDescPage extends StatefulWidget {
  @override
  _ChangeDescPageState createState() => _ChangeDescPageState();
}

class _ChangeDescPageState extends State<ChangeDescPage> {
  TextEditingController _mEtController = new TextEditingController();

  String mInputName = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          '编辑简介',
          style: TextStyle(fontSize: 16),
        ),
        elevation: 0.5,
        centerTitle: true,
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 15),
              child: InkWell(
                child: Center(
                  child: Text('完成'),
                ),
                onTap: () {
                  if (_mEtController.text.isEmpty) {
                    ToastUtil.show('内容不能为空!');
                    return;
                  }
                  FormData params = FormData.fromMap({
                    'userId': UserUtil.getUserInfo().id,
                    'personSign': _mEtController.text
                  });
                  DioManager.getInstance()
                      .post(ServiceUrl.updateIntroduce, params, (data) {
                    ToastUtil.show('修改个性签名成功!');
                    UserUtil.saveUserDesc(_mEtController.text);
                    Constant.eventBus.fire(ChangeInfoEvent());
                    Navigator.pop(context);
                  }, (error) {
                    ToastUtil.show(error);
                  });
                },
              )),
        ],
      ),
      body: Container(
          color: Color(0xffF3F1F4),
          child: new Column(
            children: <Widget>[
              Container(
                height: 1,
                color: Color(0xfffefefe),
              ),
              Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                  ),
                  height: 50,
                  color: Color(0xffffffff),
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: _mEtController,
                      maxLength: 50,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "介绍下自己",
                        hintStyle:
                            TextStyle(color: Color(0xff999999), fontSize: 15),
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
            ],
          )),
    ));
  }
}
