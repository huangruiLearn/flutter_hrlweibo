import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/pages/splash_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hrlweibo/public.dart';

void main() {
  runApp(new MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。
    /*   SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:    Colors.white,
    ) ;
   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:    Colors.white,
    ) ;*/
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffffffff),
      systemNavigationBarIconBrightness: Brightness.dark,
       systemNavigationBarDividerColor: Color(0xffffffff),
       statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,

    );

    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
/*if (Platform.isAndroid) {
SystemUiOverlayStyle systemUiOverlayStyle =
SystemUiOverlayStyle(statusBarColor: Colors.transparent,  statusBarBrightness: Brightness.light);
SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configureRoutes(router);
    Routes.router=router;


    return Container(
      child: MaterialApp(
          title: "HRL微博",
          debugShowCheckedModeBanner: false,

          theme: ThemeData(primaryColor: Colors.white),
          onGenerateRoute: Routes.router.generator,
          home:  SplashPage()
    ),
    );
  }
}
