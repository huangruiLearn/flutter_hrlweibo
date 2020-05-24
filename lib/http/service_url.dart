import 'package:flutter_hrlweibo/constant/constant.dart';

class ServiceUrl {

  // 请求成功
  static const API_CODE_SUCCESS = "200";
  static String getWeiBo = Constant.baseUrl + 'manage/hrlweibo/list.do'; // 获取首页微博列表
  static String login = Constant.baseUrl + 'manage/hrluser/login.do'; // 登录
  static String getVedioCategory =Constant.baseUrl + 'manage/hrlvedio/list.do'; // 获取视频分类
  static String feedback =Constant.baseUrl + 'manage/hrluser/uploadfile.do'; // 意见反馈
  static String updateHead =Constant.baseUrl + 'manage/hrluser/updateHead.do'; // 更新头像
  static String updateNick =Constant.baseUrl + 'manage/hrluser/updateNcik.do'; // 更新昵称
  static String updateIntroduce =Constant.baseUrl + 'manage/hrluser/updatePersonSign.do'; // 更新个性签名
  static String getUserInfo =Constant.baseUrl + 'manage/hrluser/get_user_info.do'; // 获取个人用户信息
  static String getFanFollowRecommend =Constant.baseUrl + 'manage/hrluser/getFanFollowRecommend.do'; // 获取粉丝关注页面推荐列表数据
  static String getFollowList =Constant.baseUrl + 'manage/hrluser/getFollowList.do'; //获取关注列表
  static String getFanList =Constant.baseUrl + 'manage/hrluser/getFanList.do'; //获取粉丝列表
  static String followCancelOther =Constant.baseUrl + 'manage/hrluser/followCancelOther.do'; //取消关注
  static String followOther =Constant.baseUrl + 'manage/hrluser/followOther.do'; //关注他人
  static String getFindHomeInfo =Constant.baseUrl + 'hrlfind/find.do'; //发现首页信息
  static String getWeiBoDetail =Constant.baseUrl + 'manage/hrlweibo/detail.do'; //微博详情(获取详情的评论和转发)
  static String getWeiBoDetailComment =Constant.baseUrl + 'hrlcomment/gainCommentsList.do'; //微博详情评论(分页获取评论)
  static String getWeiBoDetailForward =Constant.baseUrl + 'manage/hrlweibo/getWeiBoForwardList.do'; //微博详情转发(分页获取评论)
  static String getWeiBoAtUser =Constant.baseUrl + 'manage/hrlweibo/getWeiBoAtUserList.do'; //获取推荐人列表(发布微博选择@用户)
  static String getWeiBoTopicTypeList =Constant.baseUrl + 'manage/hrlweibo/getTopicTypeList.do'; //获取发布微博话题分类列表
  static String getWeiBoTopicList =Constant.baseUrl + 'manage/hrlweibo/getTopicList.do';  //获取发布微博话题分类对应的话题列表
  static String publishWeiBo =Constant.baseUrl + 'manage/hrlweibo/publish.do'; // 发布微博
  static String zanWeiBo =Constant.baseUrl + 'manage/hrlweibo/zan.do'; // 点赞微博
  static String forwardWeiBo =Constant.baseUrl + 'manage/hrlweibo/forward.do'; // 转发微博
  static String getWeiBoCommentReplyList =Constant.baseUrl + 'hrlcomment/gainCommentsReplyList.do'; //获取微博评论回复列表
  static String addComments =Constant.baseUrl + 'hrlcomment/addComments.do'; //评论微博
  static String addCommentsReply =Constant.baseUrl + 'hrlcomment/addCommentsReply.do'; //评论微博的评论
  static String getHotSearchList =Constant.baseUrl + 'hrlfind/getHotSearchList.do'; //热搜列表
  static String getMsgCommentList =Constant.baseUrl + 'hrlmessage/commentlist.do'; //消息-评论列表
  static String getMsgZanList =Constant.baseUrl + 'hrlmessage/zanlist.do'; //消息-赞列表
   static String getVideoRecommendList =Constant.baseUrl + 'manage/hrlvedio/recommendlist.do'; //视频-推荐列表
  static String getVideoHotList =Constant.baseUrl + 'manage/hrlvedio/hotlist.do'; //视频-热门列表
  static String getVideoHotBannerAdList =Constant.baseUrl + 'manage/hrlvedio/hotbannerad.do'; //视频-热门banner广告
   static String getVideoSmallList =Constant.baseUrl + 'manage/hrlvedio/smallVideolist.do'; //视频-小视频列表
  static String getVideoDetailRecommendList =Constant.baseUrl + 'manage/hrlvedio/videodetailrecommedlist.do'; //视频详情-推荐列表

}
