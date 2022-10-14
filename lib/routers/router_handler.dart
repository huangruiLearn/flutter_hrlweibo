import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/VideoModel.dart';
import 'package:flutter_hrlweibo/model/WeiBoDetail.dart';
import 'package:flutter_hrlweibo/pages/find/find_hot_search.dart';
import 'package:flutter_hrlweibo/pages/find/topic_detail.dart';
import 'package:flutter_hrlweibo/pages/home/weibo_comment_detail_page.dart';
import 'package:flutter_hrlweibo/pages/home/weibo_publish_page.dart';
import 'package:flutter_hrlweibo/pages/home/weibo_publish_speople_page.dart';
import 'package:flutter_hrlweibo/pages/home/weibo_publish_stopic_page.dart';
import 'package:flutter_hrlweibo/pages/message/msg_comment.dart';
import 'package:flutter_hrlweibo/pages/message/msg_zan.dart';
import 'package:flutter_hrlweibo/pages/mine/personinfo_page.dart';
import 'package:flutter_hrlweibo/public.dart';


var indexPageHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return IndexPage();
});

var loginPageHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return LoginPage();
});

var settingPageHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SettingPage();
});

var feedbackPageHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return FeedBackPage();
});

var changenickHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNickNamePage();
});

var changedescHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeDescPage();
});

var personMyFollowHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return FollowPage();
});

var personFanHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return FanPage();
});

var chatHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChatPage();
});

var personinfoHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  String userid = params["userid"]?.first;

  return new PersonInfoPage(userid);
});

var weiboPublishHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return WeiBoPublishPage();
});

var weiboPublishAtUsrHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return WeiBoPublishAtUserPage();
});

var weiboPublishTopicHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return WeiBoPublishTopicPage();
});

var weiBoCommentDetailHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  Comment comment = Comment.fromJson(convert.jsonDecode(params['comment'][0]));
  return WeiBoCommentDetailPage(comment);
});

var topicDetailHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  String mTitle = params['mTitle']?.first;
  String mImg = params['mImg']?.first;
  String mReadCount = params['mReadCount']?.first;
  String mDiscussCount = params['mDiscussCount']?.first;
  String mHost = params['mHost']?.first;

  return TopicDetailPage(mTitle, mImg, mReadCount, mDiscussCount, mHost);
});

var hotSearchHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return HotSearchPage();
});

var msgZanHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return MsgZanPage();
});

var msgCommentHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return MsgCommentPage();
});

var videoetailHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  VideoModel mVideo =
      VideoModel.fromJson(convert.jsonDecode(params['video'][0]));
  return VideoDetailPage(mVideo);
});
