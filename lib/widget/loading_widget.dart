import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

///四种视图状态
enum LoadState { State_Success, State_Error, State_Loading, State_Empty }

class LoadingWidget extends StatefulWidget {
  final LoadState state; //页面状态
  final Widget successWidget;//成功视图
  final VoidCallback errorRetry; //错误事件处理

  LoadingWidget(
      {Key key,
        this.state = LoadState.State_Loading,//默认为加载状态
        this.successWidget,
        this.errorRetry})
      : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //宽高都充满屏幕剩余空间
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget,
    );
  }

  ///根据不同状态来显示不同的视图
  Widget get _buildWidget {
    switch (widget.state) {
      case LoadState.State_Success:
        return widget.successWidget;
        break;
      case LoadState.State_Error:
        return _errorView;
        break;
      case LoadState.State_Loading:
        return _loadingView;
        break;
      case LoadState.State_Empty:
        return _emptyView;
        break;
      default:
        return null;
    }
  }

  ///加载中视图
  Widget get _loadingView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.transparent),
      alignment: Alignment.center,
      child: Container(
        height: 80,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0x88000000), borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[CircularProgressIndicator(), Text('正在加载')],
        ),
      ),
    );
  }

  ///错误视图
  Widget get _errorView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/img/ic_error_page.png',
            height: 80,
            width: 100,
          ),
          Text("加载失败，请重试"),
          RaisedButton(
            color: Color(0xffbc2929),
            onPressed: widget.errorRetry,
            child: Text(
              '重新加载',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  ///数据为空的视图
  Widget get _emptyView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/img/ic_empty.png',
            height: 100,
            width: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('暂无数据'),
          )
        ],
      ),
    );
  }
}
