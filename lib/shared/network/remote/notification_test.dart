import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/shared/components/components.dart';

class TestNotification extends StatefulWidget {
  const TestNotification({Key? key}) : super(key: key);

  @override
  State<TestNotification> createState() => _TestNotificationState();
}

class _TestNotificationState extends State<TestNotification> {
  var serverToken =
      'AAAA8sZZvNU:APA91bEpvVr1ujhOi6bteJMegccy6aQz1zdn6Tl9ZMX7Ky-IwaUx3KTTrViL7EB-Q7fNO6eReu5rddBOoTPEFsVUZptVKXcWNPFU7NGBC--WTmABGMptLkUEgmJaqjNleTKc6VOUM8DB';

  sentNotify({
    required String title,
    required String body,
  }) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await FirebaseMessaging.instance.getToken(),
        },
      ),
    );
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((message) {
      showToast(message: 'شغااال', state: ToastStates.success);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: defaultButton(
            function: () {
              sentNotify(
                title: 'Exclusive Offers Just for You!',
                body:
                    "Attention! Exciting new offers await. Don't miss out, explore now!",
              );
            },
            text: 'Send Notification',
          ),
        ),
      )),
    );
  }
}
