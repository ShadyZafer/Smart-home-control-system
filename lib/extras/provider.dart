import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gdp/extras/mqtt.dart';
import 'package:provider/provider.dart';

class change extends ChangeNotifier {
  List<bool> btn = [false, false, false, false];
  late String temp = '20';

  void btn1() {
    if (!btn[0]) {
      btn[0] = true;
      btn[1] = false;
      btn[2] = false;
      btn[3] = false;
    } else {
      btn[0] = false;
    }
    notifyListeners();
  }

  void btn2() {
    if (!btn[1]) {
      btn[1] = true;
      btn[0] = false;
      btn[2] = false;
      btn[3] = false;
    } else {
      btn[1] = false;
    }
    notifyListeners();
  }

  void btn3() {
    if (!btn[2]) {
      btn[2] = true;
      btn[0] = false;
      btn[1] = false;
      btn[3] = false;
    } else {
      btn[2] = false;
    }
    notifyListeners();
  }

  void btn4() {
    if (!btn[3]) {
      btn[3] = true;
      btn[0] = false;
      btn[1] = false;
      btn[2] = false;
    } else {
      btn[3] = false;
    }
    notifyListeners();
  }

  String temp_fetch({required String msg}) {
    try {
      final Map<String, dynamic> jsonData = json.decode(msg);
      temp = jsonData['temperature'].toString();
      notifyListeners();
    } catch (e) {
      print('Error parsing JSON: $e');
    }
    return temp;
  }

  void subscribe(BuildContext context) {
    Provider.of<MqttProvider>(context, listen: false).subscribeToTopic("home/temperature");
    Provider.of<MqttProvider>(context, listen: false).subscribeToTopic("home/flame");
    Provider.of<MqttProvider>(context, listen: false).subscribeToTopic("home/control");
    Provider.of<MqttProvider>(context, listen: false).subscribeToTopic("home/ldr");
  }

  void motion() {}
}
