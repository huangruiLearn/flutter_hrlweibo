import 'package:flutter/material.dart';
import 'weibo_homelist_page.dart';


class WeiBoFollowPage extends StatefulWidget {
  @override
  _WeiBoFollowPageState createState() => _WeiBoFollowPageState();
}

class _WeiBoFollowPageState extends State<WeiBoFollowPage> {
  @override
  Widget build(BuildContext context) {
    return   new WeiBoHomeListPager(mCatId: "0");
  }
}
