import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

import 'controller.dart';
import 'logic.dart';

class First_pagePage extends StatelessWidget {
  final logic = Get.put(First_pageLogic());
  final state = Get.find<First_pageLogic>().state;
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    pushyRegister();
    Pushy.setNotificationListener(backgroundNotificationListener);
    return Scaffold(
      appBar: AppBar(
        title: const Text('pushy_flutter_demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() {
              return Text(c.t.string);
            }),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: '${c.t}'));
              },
              child: const Text('复制'),
            ),
            Obx(() {
              return Text(c.msg.string);
            }),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }

  Future pushyRegister() async {

    try {
      // Register the user for push notifications
      String deviceToken = await Pushy.register();

      // Print token to console/logcat
      print('Device token: $deviceToken');

      c.setT(deviceToken);

      try {
        // print('172.16.104.19:8888/device/$deviceToken');
        // var response = await Dio().get('http://172.16.104.19:8888/device/$deviceToken');
        // print(response);
      } catch (e) {
        print(e);
      }

      // Display an alert with the device token
      // Get.defaultDialog(
      //     title: 'Pushy',
      //     content: Text('Pushy device token: $deviceToken'),
      //     actions: [
      //       FlatButton(
      //           child: Text('OK'),
      //           onPressed: () {
      //             Get.back();
      //           })
      //     ]);
    } on PlatformException catch (error) {
      // Display an alert with the error message
      c.setT(error.message.toString());
      Get.defaultDialog(
          title: 'Error',
          content: Text(error.message.toString()),
          actions: [
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Get.back();
                })
          ]);
    }
  }

  void backgroundNotificationListener(Map<String, dynamic> data) {
    // Print notification payload data
    print('Received notification: $data');

c.setMsg(data.toString());

    // Notification title
    String notificationTitle = '112354';

    // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
    String notificationText = data['message'] ?? 'Hello World!';

    // Android: Displays a system notification
    // iOS: Displays an alert dialog
    Pushy.notify(notificationTitle, notificationText, data);

    // Clear iOS app badge number
    Pushy.clearBadge();
  }
}
