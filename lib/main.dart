import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/core/colors.dart';
import 'package:flutter_text_recognition/route_generator.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  print(
    hexToColor("#fbae0d").toString(),
  );
  runApp(
    MaterialApp(
        title: "Pizza App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            backgroundColor: appColorBackground,
            primaryColor: appColorSecondaryDarkBlue,
            accentColor: appColorPrimaryYellow),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute),
  );
}
