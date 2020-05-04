 import 'package:flutter/material.dart';
 import 'package:flutter_hrlweibo/public.dart';

 import 'package:dio/dio.dart';
  import 'package:flutter_hrlweibo/util/toast_util.dart';
 import '../../model/WeiBoListModel.dart';
 import '../../widget/WeiBoItem.dart';



 class PageInfoWeiBo extends StatefulWidget {
   @override
   _PageInfoWeiBoState createState() => _PageInfoWeiBoState();
 }

 class _PageInfoWeiBoState extends State<PageInfoWeiBo> {

 
 


   @override
   Widget build(BuildContext context) {

     return Container(
         margin: EdgeInsets.only(top: 50),
         child:    new Text("暂无数据")
     );




   }

 }
 