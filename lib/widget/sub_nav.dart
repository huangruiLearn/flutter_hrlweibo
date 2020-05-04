import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/find_topic.dart';


class SubNav extends StatelessWidget {
  final List<FindTopicModel> subNavList;

  const SubNav({
    Key key,
    @required this.subNavList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    /*  decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),*/
      child:  _items(context),

    );
  }

  Widget _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
   /* subNavList.forEach((model) {
      items.add(_item(context, model));
    });*/
   return   Container(
     color: Colors.green,
     height: 200,
   );/*GridView(
       padding: EdgeInsets.all(1.0),
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 3,
           mainAxisSpacing: 2.0,
           crossAxisSpacing: 2.0,
           childAspectRatio: 0.75),
       children: <Widget>[
         Text("aaaaaa"),
         Text("aaaaaa"),
         Text("aaaaaa"),
         Text("aaaaaa"),
         Text("aaaaaa"),
       ]);*/
      /*return Container(
      child:
        *//*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, 6),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(6, 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.sublist(12, subNavList.length),
          ),
        )*//*
   *//*   GridView(
      padding: EdgeInsets.all(1.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 2.0,
    crossAxisSpacing: 2.0,
    childAspectRatio: 0.75),
    children: <Widget>[
    Image.network(
    "http://img5.mtime.cn/mt/2019/02/21/095918.47882172_270X405X4.jpg",
    fit: BoxFit.cover),
    Image.network(
    "http://img5.mtime.cn/mt/2019/01/25/100901.82440600_270X405X4.jpg",
    fit: BoxFit.cover),
    Image.network(
    "http://img5.mtime.cn/mg/2019/02/19/095714.33859824_270X405X4.jpg",
    fit: BoxFit.cover),
    Image.network(
    "http://img5.mtime.cn/mt/2019/01/25/105549.53627008_270X405X4.jpg",
    fit: BoxFit.cover),
    Image.network(
    "http://img5.mtime.cn/mt/2019/03/01/142658.85498591_270X405X4.jpg",
    fit: BoxFit.cover),
    Image.network(
    "http://img5.mtime.cn/mt/2019/01/09/171109.88229500_270X405X4.jpg",
    fit: BoxFit.cover),
    Image.network(
    "http://img5.mtime.cn/mg/2019/02/26/103754.10526344_270X405X4.jpg",
    fit: BoxFit.cover)
    ],
    )*//*
 //  Text("aaaaaa"),

    GridView(
    padding: EdgeInsets.all(1.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 2.0,
    crossAxisSpacing: 2.0,
    childAspectRatio: 0.75),
    children: <Widget>[
      Text("aaaaaa"),
      Text("aaaaaa"),
      Text("aaaaaa"),
      Text("aaaaaa"),
      Text("aaaaaa"),
      ]),
    );*/
  }

  Widget _item(BuildContext context,FindTopicModel model ) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
         /* NavigatorUtil.push(
              context,
              WebView(
                url: model.url,
                statusBarColor: model.statusBarColor,
                hideAppBar: model.hideAppBar,
                title: model.title,
              ));*/
        },
        child: Column(
          children: <Widget>[
            /*CachedNetworkImage(
              imageUrl: model.icon,
              width: 18,
              height: 18,
            ),*/
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text("aa", style: TextStyle(fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
