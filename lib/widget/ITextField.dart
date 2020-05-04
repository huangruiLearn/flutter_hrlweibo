import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';




typedef void ITextFieldCallBack(String content);

enum ITextInputType {
  text,
  multiline,
  number,
  phone,
  datetime,
  emailAddress,
  url,
  password
}

class ITextField extends StatefulWidget {
  final ITextInputType keyboardType;
  final int maxLines;
  final int maxLength;
  final String hintText;
  final TextStyle hintStyle;
  final ITextFieldCallBack fieldCallBack;
  final Icon deleteIcon;
  final InputBorder inputBorder;
  final Widget prefixIcon;
  final TextStyle textStyle;
  final FormFieldValidator<String> validator;

  ITextField({
    Key key,
    ITextInputType keyboardType: ITextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    this.hintStyle,
    this.fieldCallBack,
    this.deleteIcon,
    this.inputBorder,
    this.textStyle,
    this.prefixIcon, this.validator,
  })  : assert(maxLines == null || maxLines > 0),
        assert(maxLength == null || maxLength > 0),
        keyboardType = maxLines == 1 ? keyboardType : ITextInputType.multiline,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ITextFieldState();
}

class _ITextFieldState extends State<ITextField> {
  String _inputText = "";
  bool _hasdeleteIcon = false;
  bool _isNumber = false;
  bool _isPassword = false;

  ///输入类型
  TextInputType _getTextInputType() {
    switch (widget.keyboardType) {
      case ITextInputType.text:
        return TextInputType.text;
      case ITextInputType.multiline:
        return TextInputType.multiline;
      case ITextInputType.number:
        _isNumber = true;
        return TextInputType.number;
      case ITextInputType.phone:
        _isNumber = true;
        return TextInputType.phone;
      case ITextInputType.datetime:
        return TextInputType.datetime;
      case ITextInputType.emailAddress:
        return TextInputType.emailAddress;
      case ITextInputType.url:
        return TextInputType.url;
      case ITextInputType.password:
        _isPassword = true;
        return TextInputType.text;
    }
  }

  ///输入范围
  List<TextInputFormatter> _getTextInputFormatter() {
    return _isNumber
        ? <TextInputFormatter>[
      WhitelistingTextInputFormatter.digitsOnly,
    ]
        : null;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController.fromValue(
        TextEditingValue(
            text: _inputText,
            selection: new TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputText.length))));
    TextField textField = new TextField(
      controller: _controller,

      decoration: InputDecoration(
        hintStyle: widget.hintStyle,
        counterStyle: TextStyle(color: Colors.white),
        hintText: widget.hintText,
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightGreenAccent,width: 0.5),borderRadius: BorderRadius.only(
          topLeft: Radius.circular(1.0),
          topRight: Radius.circular(1.0),
        )),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellowAccent,width: 0.5),borderRadius: BorderRadius.only(
          topLeft: Radius.circular(1.0),
          topRight: Radius.circular(1.0),
        )),
        fillColor: Colors.transparent,
        filled: true,
       // prefixIcon: widget.prefixIcon,
        suffixIcon: _hasdeleteIcon
            ? new Container(
          width: 20.0,
          height: 20.0,
          child: new IconButton(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0.0),
            iconSize: 18.0,
            icon: widget.deleteIcon != null
                ? widget.deleteIcon
                : Image.asset(
              Constant.ASSETS_IMG + 'icon_close.png',
              width: 20.0,
              height: 20.0,
            ),
            onPressed: () {
              setState(() {
                _inputText = "";
                _hasdeleteIcon = (_inputText.isNotEmpty);
                widget.fieldCallBack(_inputText);
              });
            },
          ),
        )
            : new Text(""),
      ),
      onChanged: (str) {
        setState(() {
          _inputText = str;
          _hasdeleteIcon = (_inputText.isNotEmpty);
          widget.fieldCallBack(_inputText);
        });
      },
      keyboardType: _getTextInputType(),
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      inputFormatters: _getTextInputFormatter(),
      style: widget.textStyle,
      obscureText: _isPassword,
    );
    return textField;
  }
}