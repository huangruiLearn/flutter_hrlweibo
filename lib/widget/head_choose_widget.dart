import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//选择头像底部弹出框
class HeadChooseWidget extends StatelessWidget {
  final ValueChanged<File> chooseImgCallBack;

  HeadChooseWidget({Key key, this.chooseImgCallBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min, //wrap_content
      children: <Widget>[
        Material(
          color: Colors.white,
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Future<File> imageFile =
                    ImagePicker.pickImage(source: ImageSource.camera);
                imageFile.then((result) {
                  chooseImgCallBack(result);
                });
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Center(
                  child: Text('立即拍照',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              )),
        ),
        Container(
          height: 1,
          color: Color(0xffEFF1F0),
          //  margin: EdgeInsets.only(left: 60),
        ),
        Material(
          color: Colors.white,
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Future<File> imageFile =
                    ImagePicker.pickImage(source: ImageSource.gallery);
                imageFile.then((result) {
                  chooseImgCallBack(result);
                });
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Center(
                  child: Text('从相册选择',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              )),
        ),
        Container(
          height: 1,
          color: Color(0xffEFF1F0),
          //  margin: EdgeInsets.only(left: 60),
        ),
        Material(
          color: Colors.white,
          child: InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Center(
                  child: Text('查看大图',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              )),
        ),
        Container(
          height: 10,
          color: Color(0xffEFF1F0),
          //  margin: EdgeInsets.only(left: 60),
        ),
        Material(
          color: Colors.white,
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Center(
                  child: Text('取消',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              )),
        ),
      ],
    ));
  }
}
