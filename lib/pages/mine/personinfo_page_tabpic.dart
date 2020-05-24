import 'package:flutter/material.dart';

class PageInfoPic extends StatefulWidget {
  @override
  _PageInfoPicState createState() => _PageInfoPicState();
}

class _PageInfoPicState extends State<PageInfoPic> {
  //https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_top1.jpg

  Widget mPicTop() {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 75) / 4,
                    height: (MediaQuery.of(context).size.width - 75) / 4 + 50,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width - 75) / 4,
                          height: (MediaQuery.of(context).size.width - 75) / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_top1.jpg'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text('全部图片',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 75) / 4,
                    height: (MediaQuery.of(context).size.width - 75) / 4 + 50,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width - 75) / 4,
                          height: (MediaQuery.of(context).size.width - 75) / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_top2.jpg'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text('头像图片',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 75) / 4,
                    height: (MediaQuery.of(context).size.width - 75) / 4 + 50,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width - 75) / 4,
                          height: (MediaQuery.of(context).size.width - 75) / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_top3.jpg'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text('赞过的图',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 75) / 4,
                    height: (MediaQuery.of(context).size.width - 75) / 4 + 50,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width - 75) / 4,
                          height: (MediaQuery.of(context).size.width - 75) / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_top4.jpg'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text('更多图片',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget mPicNormal(List<String> mList) {
    List<Widget> mListWidget = new List();
    for (int i = 0; i < mList.toSet().length; i++) {
      mListWidget.add(
        Container(
          width: (MediaQuery.of(context).size.width - 30) / 3,
          height: (MediaQuery.of(context).size.width - 30) / 3 - 20,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(mList[i]),
                fit: BoxFit.cover,
              )),
        ),
      );
    }

    Widget chipDesign(String label, Color color) => Container(
          child: Chip(
            label: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: color,
            elevation: 4,
            shadowColor: Colors.grey[50],
            padding: EdgeInsets.all(4),
          ),
          margin: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
        );

    return Container(
        child: Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Wrap(
                  spacing: 5, //主轴上子控件的间距
                  runSpacing: 5, //交叉轴上子控件之间的间距
                  children: mListWidget),
            )),
      ],

      /*Align(

          alignment:  Alignment.centerLeft,
        //  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Wrap(

           */ /*alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            textDirection:TextDirection.rtl,*/ /*
*/ /*
            crossAxisAlignment: WrapCrossAlignment.start,
*/ /*  */ /*alignment: WrapAlignment.end, //沿主轴方向居中
            runAlignment: WrapAlignment.start,*/ /*
            //verticalDirection: VerticalDirection.down,
            spacing: 5,//主轴上子控件的间距
            runSpacing: 5,//交叉轴上子控件之间的间距
            children:  [
              */ /*Container(
                width: (MediaQuery.of(context).size.width - 30) / 3,
                height: (MediaQuery.of(context).size.width - 30) / 3 - 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_top4.jpg'),
                      fit: BoxFit.cover,
                    )),
              ),*/ /*

            */ /*  Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('AH')),
                label: Text('Hamilton'),
              ),*/ /*
          */ /* chipDesign("Food", Color(0xFF4fc3f7)),
              chipDesign("Lifestyle", Color(0xFFffb74d)),
              chipDesign("Health", Color(0xFFff8a65)),
              chipDesign("Sports", Color(0xFF9575cd)),
            chipDesign("Nature", Color(0xFF4db6ac)),
              chipDesign("Fashion", Color(0xFFf06292)),
              chipDesign("Heritage", Color(0xFFa1887f)),
              chipDesign("City Life", Color(0xFF90a4ae)),

              chipDesign("Entertainment", Color(0xFFba68c8)),*/ /*


       */ /*   Container(
            height: 100,
          width: 200,
          color: Colors.red,

          margin: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
        ),*/ /*
            ],*/ /* mListWidget,*/ /*
          ),
        ),
      ],*/
    ));
  }

  List<List<String>> blockList = [];

  @override
  Widget build(BuildContext context) {
    blockList.clear();
    for (int i = 0; i < 3; i++) {
      List<String> mPicList = new List();
      if (i == 0) {
        mPicList.add(
            "https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_bottom1.jpg");
        mPicList.add(
            "https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_bottom2.jpg");
        mPicList.add(
            "https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_bottom3.jpg");
        mPicList.add(
            "https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_bottom4.jpg");
      } else if (i == 1) {
        mPicList.add(
            "https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_bottom5.jpg");
        mPicList.add(
            "https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_bottom6.jpg");
        mPicList.add(
            "https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_bottom7.jpg");
      } else if (i == 2) {
        mPicList.add(
            "https://hrlweibo-1259131655.cos.ap-beijing.myqcloud.com/uinfo_pic_bottom1.jpg");
      }
      blockList.add(mPicList);
    }

    return Container(
        color: Color(0xffEFEEEC),
        margin: EdgeInsets.only(top: 50),
        child: ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? mPicTop()
                  : new Container(
                      child: new Column(
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, bottom: 5, left: 15),
                            alignment: Alignment.centerLeft,
                            child: Text(index.toString() + "月",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                          ),
                          mPicNormal(blockList[index - 1])
                        ],
                      ),
                    );
            }));
  }
}
