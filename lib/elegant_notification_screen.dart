import 'dart:convert';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ElegantNotificationScreen extends StatefulWidget {
  const ElegantNotificationScreen({super.key});

  @override
  State<ElegantNotificationScreen> createState() =>
      _ElegantNotificationScreenState();
}

class _ElegantNotificationScreenState extends State<ElegantNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              _showSuccessNotification();
            },
            child: const Text("Show Notification1"),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _showErrorNotification();
            },
            child: const Text("Show Notification1"),
          ),
          ElevatedButton(
            onPressed: () async {
              final url = Uri.parse(
                  "https://apisoowgoodbeta.com/api/app/ek-pay/initiate-payment");
              try {
                final response = await http.post(url, body: {
                  "applicationCode": "SGAP240815ONLINESL008",
                  "transactionId": "",
                  "totalAmount": "20"
                });
                print("api hit done");
                if (response.statusCode == 200) {
                  print("status 200");
                  Logger().i(response.body);
                } else {
                  print("status ${response.statusCode}");
                  Logger().i(response.body);
                }
              } catch (e) {
                Logger().e(e);
              }
            },
            child: const Text("ekpay payment"),
          ),
        ],
      ),
    );
  }

  void _showSuccessNotification() {
    ElegantNotification.success(
      width: 360,
      isDismissable: false,
      position: Alignment.topCenter,
      toastDuration: const Duration(milliseconds: 2300),
      animation: AnimationType.fromTop,
      title: const Text('Update'),
      description: const Text('Your data has been updated'),
      shadow: BoxShadow(
        color: Colors.green.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 4),
      ),
    ).show(context);
  }

  void _showErrorNotification() {
    ElegantNotification.error(
      width: 360,
      stackedOptions: StackedOptions(
        key: 'topRight',
        type: StackedType.below,
        itemOffset: const Offset(0, 5),
      ),
      position: Alignment.topRight,
      toastDuration: const Duration(milliseconds: 2300),
      animation: AnimationType.fromRight,
      title: const Text('Error'),
      description: const Text('Error example notification'),
    ).show(context);
  }
}
