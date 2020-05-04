import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'extra_item.dart';


typedef void OnImageSelect(File mImg);


class DefaultExtraWidget extends StatefulWidget {

  final OnImageSelect onImageSelectBack;

  const DefaultExtraWidget({
    Key key,
    this.onImageSelectBack,
  }) : super(key: key);




  @override
  _DefaultExtraWidgetState createState() => _DefaultExtraWidgetState();
}

class _DefaultExtraWidgetState extends State<DefaultExtraWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
         //mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new Flexible(
            child: createPicitem(),
            flex: 1,
          ),
          new Flexible(
            child: createVediotem(),
            flex: 1,
          ),
          new Flexible(
            child: createFileitem(),
            flex: 1,
          ),
          new Flexible(
            child: createLocationitem(),
            flex: 1,
          ),
         ],
      ),
    );
  }

  ExtraItemContainer createPicitem() => ExtraItemContainer(
        leadingIconPath: Constant.ASSETS_IMG + "ic_ctype_file.png",
        leadingHighLightIconPath: Constant.ASSETS_IMG + "ic_ctype_file_pre.png",
        text: "相册",
        onTab: () {
          Future<File> imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
          imageFile.then((result) {
             widget.onImageSelectBack?.call(result);


          });
        },
      );

  ExtraItemContainer createVediotem() => ExtraItemContainer(
        leadingIconPath: Constant.ASSETS_IMG + "ic_ctype_video.png",
        leadingHighLightIconPath:
            Constant.ASSETS_IMG + "ic_ctype_video_pre.png",
        text: "视频",
        onTab: () {
          print("添加");
        },
      );

  ExtraItemContainer createFileitem() => ExtraItemContainer(
        leadingIconPath: Constant.ASSETS_IMG + "ic_ctype_file.png",
        leadingHighLightIconPath: Constant.ASSETS_IMG + "ic_ctype_file_pre.png",
        text: "文件",
        onTab: () {
          print("添加");
        },
      );

  ExtraItemContainer createLocationitem() => ExtraItemContainer(
        leadingIconPath: Constant.ASSETS_IMG + "ic_ctype_location.png",
        leadingHighLightIconPath:
            Constant.ASSETS_IMG + "ic_ctype_loaction_pre.png",
        text: "位置",
        onTab: () {
          print("添加");
        },
      );
}
