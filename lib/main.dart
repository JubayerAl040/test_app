import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:test_app/firebase_options.dart';
import 'package:test_app/shimmer_loading_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Backgorung notification gets called-------------");
  print("Handling a background message: ${message.messageId}");
  Logger().t(message.data);
  if (message.notification != null) {
    print("\n------------------------------------");
    print('Handling a foreground message: ${message.messageId}');
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification!.title}');
    print('Message notification: ${message.notification!.body}');
  }
}

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // print(await FirebaseMessaging.instance.getToken());
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        title: 'Test App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ShimmerloadingScreen(),
      ),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    _handleNotification();
  }

  Future<void> _handleNotification() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      Logger().i(initialMessage.data);
      _handleMessage();
    }

    // foreground notification handle
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("foreground notification gets called-------------");
      Logger().e("message Data: ${message.data}");
      if (message.notification != null) {
        print("\n------------------------------------");
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification!.title}');
        print('Message notification: ${message.notification!.body}');
      }
      // showOverlayNotification(
      //   (context) {
      //     return Card(
      //       color: Colors.white,
      //       margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
      //       child: ListTile(
      //         minVerticalPadding: 0,
      //         contentPadding:
      //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //         leading: SizedBox.fromSize(
      //             size: const Size(40, 40),
      //             child:
      //                 ClipOval(child: Image.asset('assets/images/icon.png'))),
      //         // title: Text(message.notification!.title??""),
      //         subtitle: Text(message.notification!.body ?? ""),
      //         trailing: IconButton(
      //             icon: const Icon(Icons.close),
      //             onPressed: () {
      //               OverlaySupportEntry.of(context)!.dismiss();
      //             }),
      //       ),
      //     );
      //   },
      //   duration: const Duration(milliseconds: 4000),
      // );
    });

    // on run the app. from background or first-open
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!-----------------');
    });
  }

  void _handleMessage() {
    print("Coming to handle message option-------------------");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Notification Screen"),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
