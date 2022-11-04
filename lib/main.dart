import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:numerology_yantra/ui/splashscreen.dart';

Future<void> backgroundHandler(RemoteMessage message) async{}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]
  );

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {


    return MaterialApp(
    title: 'Numerology Yantra',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    primarySwatch: Colors.blue,
    ),
    home: const SplashScreen(),
    builder: EasyLoading.init(),
    );
    }
}
