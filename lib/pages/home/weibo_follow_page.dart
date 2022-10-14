import 'package:flutter/material.dart';
import 'weibo_list_page.dart';


class WeiBoFollowPage extends StatelessWidget {
  const WeiBoFollowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeiBoListPage(mCatId: "0");
  }
}


