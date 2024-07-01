// main(){
//  WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//    await AwesomeNotifications().initialize(null, [
//     NotificationChannel(
//       channelKey: "call_channel",
//       channelName: "Call Channel",
//       channelDescription: "Channel of calling",
//       defaultColor: Colors.redAccent,
//       ledColor: Colors.white,
//       importance: NotificationImportance.Max,
//       channelShowBadge: true,
//       locked: true,
//       defaultRingtoneType: DefaultRingtoneType.Ringtone,
//     ),
//   ]);
//   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
// }


// Future<void> backgroundHandler(RemoteMessage message) async {
//   String? title = message.notification!.title;
//   String? body = message.notification!.body;
//   AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 123,
//       channelKey: "call_channel",
//       color: Colors.white,
//       title: title,
//       body: body,
//       category: NotificationCategory.Call,
//       wakeUpScreen: true,
//       fullScreenIntent: true,
//       autoDismissible: false,
//       backgroundColor: Colors.orange,
//     ),
//     actionButtons: [
//       NotificationActionButton(
//         key: "ACCEPT",
//         label: "Accept Call",
//         color: Colors.green,
//         autoDismissible: true,
//       ),
//       NotificationActionButton(
//         key: "REJECT",
//         label: "Reject Call",
//         color: Colors.red,
//         autoDismissible: true,
//       ),
//     ],
//   );
// }

// class AwesomeNotifierScreen extends StatefulWidget {
//   const AwesomeNotifierScreen({super.key});
//   @override
//   State<AwesomeNotifierScreen> createState() => _AwesomeNotifierScreenState();
// }

// class _AwesomeNotifierScreenState extends State<AwesomeNotifierScreen> {
//   @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       String? title = message.notification!.title;
//       String? body = message.notification!.body;
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 123,
//           channelKey: "call_channel",
//           color: Colors.white,
//           title: title,
//           body: body,
//           category: NotificationCategory.Call,
//           wakeUpScreen: true,
//           fullScreenIntent: true,
//           autoDismissible: false,
//           backgroundColor: Colors.orange,
//         ),
//         actionButtons: [
//           NotificationActionButton(
//             key: "ACCEPT",
//             label: "Accept Call",
//             color: Colors.green,
//             autoDismissible: true,
//           ),
//           NotificationActionButton(
//             key: "REJECT",
//             label: "Reject Call",
//             color: Colors.red,
//             autoDismissible: true,
//           ),
//         ],
//       );
//       AwesomeNotifications().setListeners(
//         onActionReceivedMethod: NotificationController.onActionReceivedMethod,
//         onNotificationCreatedMethod:
//             NotificationController.onNotificationCreatedMethod,
//         onNotificationDisplayedMethod:
//             NotificationController.onNotificationDisplayedMethod,
//         onDismissActionReceivedMethod:
//             NotificationController.onDismissActionReceivedMethod,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     String? key = await FirebaseMessaging.instance.getToken();
//                     print(key);
//                   },
//                   child: const Text("Get Token"),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text("Send Notification"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NotificationController {
//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }

//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }

//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     // Your code goes here
//   }

//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     if (receivedAction.buttonKeyPressed == "REJECT") {
//       print("Call Rejected");
//     } else if (receivedAction.buttonKeyPressed == "ACCEPT") {
//       print("Call Accepted");
//     } else {
//       print("Click on Notification");
//     }
//     // Your code goes here
//     // // Navigate into pages, avoiding to open the notification details page over another details page already opened
//     // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
//     //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
//     //     arguments: receivedAction);
//   }
// }
