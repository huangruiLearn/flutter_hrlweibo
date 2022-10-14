

import 'package:flutter/cupertino.dart';


class LoginBtnProvider with ChangeNotifier {
  String inputAccount = "";
  String inputPwd = "";

  void setInputAccount (content) {
    inputAccount = content;
    notifyListeners();
  }

  void setInputPwd(content) {
    inputPwd = content;
    notifyListeners();
  }
}