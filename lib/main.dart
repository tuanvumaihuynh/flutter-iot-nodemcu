import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';

import 'package:rtbd_nodemcu_project/screens/home_page.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarIconBrightness: Brightness.dark));
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyDWeSDvGyMUU2kNfX9IL0qwgNGkCkmi6N0",
      //     authDomain: "rtdb-nodemcu-project.firebaseapp.com",
      //     databaseURL: "https://rtdb-nodemcu-project-default-rtdb.firebaseio.com",
      //     projectId: "rtdb-nodemcu-project",
      //     storageBucket: "rtdb-nodemcu-project.appspot.com",
      //     messagingSenderId: "82697239004",
      //     appId: "1:82697239004:web:89347fc630e52047b67719",
      //     measurementId: "G-EBE3GTD4FY"),
      );
  // Set Device Orientation only Portrait
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then((value) => runApp(const MyApp()));
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    const MyApp(), // Wrap your app
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
