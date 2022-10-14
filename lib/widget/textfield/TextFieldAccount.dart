import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';

typedef void ITextFieldCallBack(String content);

//登陆注册界面edittext输入框
class AccountEditText extends StatefulWidget {


  final ITextFieldCallBack contentStrCallBack;


  AccountEditText({
    Key? key,
    required this.contentStrCallBack,
  }) : super(key: key);

  @override
  _AccountEditTextState createState() => _AccountEditTextState();
}

String _inputAccount = "";

class _AccountEditTextState extends State<AccountEditText> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController.fromValue(
        TextEditingValue(
            text: _inputAccount,
            selection: new TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputAccount.length))));
    return new Container(
        child: new Theme(
      data: new ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent), //去除水波纹效果
      child: new TextField(
        controller: _controller,
        style: TextStyle(color: Color(0xff333333), fontSize: 14),
        decoration: InputDecoration(
          counterText: "",
          hintText: "手机号或者邮箱",
          contentPadding: EdgeInsets.only(left: 0, top: 14, bottom: 14),
          hintStyle: TextStyle(color: Color(0xff8C8C8C), fontSize: 14),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDADADA))),
          fillColor: Colors.transparent,
          filled: true,
          // prefixIcon: widget.prefixIcon,
          suffixIcon: _controller.text.length>0
              ? new Container(
                  width: 14.0,
                  height: 14.0,
                  child: new IconButton(
                    padding: const EdgeInsets.all(0.0),
                    iconSize: 14.0,
                    icon: Image.asset(
                      Constant.ASSETS_IMG + 'icon_et_delete.png',
                      width: 14.0,
                      height: 14.0,
                    ),
                    onPressed: () {
                      setState(() {
                        _inputAccount = "";
                         widget.contentStrCallBack(_inputAccount);
                      });
                    },
                  ),
                )
              : Text(''),
         ),
        onChanged: (str) {
          setState(() {
            _inputAccount = str;
             widget.contentStrCallBack(_inputAccount);
          });
        },
        keyboardType: TextInputType.text,
        maxLength: 20,
        maxLines: 1,
        //inputFormatters: _getTextInputFormatter(),
        // style: widget.textStyle,
        //  obscureText: _isPassword,
      ),
    ));
  }
}
