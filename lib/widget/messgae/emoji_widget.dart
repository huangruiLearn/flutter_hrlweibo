
import 'package:flutter/material.dart';

import 'emoji_util.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'circle_page_indicator.dart';

typedef void OnEmojiClick(int text);


 var _pageController = new PageController(initialPage: 0);

class EmojiWidget extends StatefulWidget {

  final OnEmojiClick onEmojiClockBack;

  const EmojiWidget({
    Key key,
    this.onEmojiClockBack,
  }) : super(key: key);


  @override
  _EmojiWidgetState createState() => _EmojiWidgetState();
}

class _EmojiWidgetState extends State<EmojiWidget> {

  Widget getEveryPage(int index) {
    switch(index){
      case 0:
         return getWrapByPage(EmojiUtil.emojiPage1);
         break;
      case 1:
         return getWrapByPage(EmojiUtil.emojiPage2);
         break;
      case 2:
         return getWrapByPage(EmojiUtil.emojiPage3);
         break;
    }
   }


  Widget getWrapByPage(Map<int, int> emojiPage) {
    List<Widget> emojis = new List();
    emojiPage.forEach((key, value) {
      print('key: $key, value:$value');
      Widget item = getItem(key, value);
      emojis.add(item);
    });
    Widget  page=Container(
      alignment: Alignment.center,
      child: GridView.count(
      //垂直子Widget之间间距
      mainAxisSpacing: 10.0,
      //GridView内边距
      padding: EdgeInsets.all(10.0),
      //一行的Widget数量
      crossAxisCount: 7,
      //子Widget宽高比例
      childAspectRatio: 1.0,
      //子Widget列表
      children: emojis.toList(),
    ),);
     return page;
  }






  Widget getItem(int key, int emoji) {
    Widget item = GestureDetector(
      onTap: () {
        widget.onEmojiClockBack?.call(emoji  );
      },
      child:key!=0?Container(
         alignment: Alignment.center,
         child:  Text( String.fromCharCode(emoji),style: TextStyle(fontSize: 20),),
      ):
      new Container(
           alignment: Alignment.center,
           child: Container(
              height: 25.0,
             width: 25.0,
             child: Image.asset(
               Constant.ASSETS_IMG+"icon_emoji_delete.png",
             ),
           )),
     );
    return item;
  }

  final _currentPageNotifier = ValueNotifier<int>(0);



  @override
  Widget build(BuildContext context) {
       return new Container(
      color: Color(0xffF6F6F6),
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            child:
            new PageView.builder(
              onPageChanged: (int index) {
                _currentPageNotifier.value = index;
              },
              itemCount: 3,
              controller: _pageController,
              itemBuilder: (BuildContext context,int index){
                return   getEveryPage(index);
              },

            ),


          ),
           Container(

             child:  Padding(
               padding: const EdgeInsets.all(8.0),
               child: CirclePageIndicator(
                 itemCount: 3,
                 currentPageNotifier: _currentPageNotifier,
               ),
             )
           )
        ],
      ));
  }
}
