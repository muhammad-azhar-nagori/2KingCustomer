import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:kingcustomer/Screens/flashscreen/flashscreen.dart';
import 'package:kingcustomer/providers/about.dart';
import 'package:kingcustomer/providers/agreement_provider.dart';
import 'package:kingcustomer/providers/chat_provider.dart';
import 'package:kingcustomer/providers/comments_provider.dart';
import 'package:kingcustomer/providers/current_user_provider.dart';
import 'package:kingcustomer/providers/customer_provider.dart';
import 'package:kingcustomer/providers/inventory_provider.dart';
import 'package:kingcustomer/providers/service_log_provider.dart';
import 'package:kingcustomer/providers/message_provider.dart';
import 'package:kingcustomer/providers/order_provider.dart';
import 'package:kingcustomer/providers/post_provider.dart';
import 'package:kingcustomer/providers/service_provider.dart';
import 'package:kingcustomer/providers/story_provider.dart';
import 'package:kingcustomer/providers/contractor_provider.dart';
import 'package:kingcustomer/providers/worker_provider.dart';
import 'package:kingcustomer/themes/mytheme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/authentication_provider.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // print('User granted permission: ${settings.authorizationStatus}');
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}'
  // );
  //   }
  // });

  runApp(const MyApp());
//...
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => ContractorsProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => AgreementProvider()),
        ChangeNotifierProvider(create: (_) => ServiceLogsProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => CommentsProvider()),
        ChangeNotifierProvider(create: (_) => AboutProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "2Kings",
        theme: MyTheme.Mytheme(),
        home: const FlashScreen(),
      ),
    );
  }
}
