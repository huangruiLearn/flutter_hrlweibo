import 'package:event_bus/event_bus.dart';

class Constant {
  //  static const baseUrl ='http://192.168.56.1:8080/hrlweibo/';
  static const baseUrl = 'http://212.64.95.5:8080/hrlweibo/';

  static const String ASSETS_IMG = 'assets/images/';

  static const bool ISDEBUG = true;

  static const String SP_USER = 'sp_user';

  static const String SP_KEYBOARD_HEGIHT = 'sp_keyboard_hegiht'; //软键盘高度

  static const int PAGE_SIZE = 10;

  static final EventBus eventBus = new EventBus();
}
