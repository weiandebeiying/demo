import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Controller extends GetxController{
  final t = Rx<String>('0');
  final msg = Rx<String>('msg');

  setT(String s){
    t.value = s;
  }

  setMsg(String s){
    msg.value = s;
  }
}