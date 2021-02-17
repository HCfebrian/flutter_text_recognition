import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_text_recognition/core/colors.dart';
import 'package:flutter_text_recognition/feature/history/presentation/bloc/pizza_history/pizza_history_bloc.dart';
import 'package:flutter_text_recognition/feature/history/presentation/bloc/scaner/scanner_bloc.dart';
import 'package:flutter_text_recognition/feature/profile/presentation/bloc/scan_ktp_bloc.dart';
import 'package:flutter_text_recognition/injection_container.dart';
import 'package:flutter_text_recognition/main_screen.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  print(
    hexToColor("#fbae0d").toString(),
  );
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<PizzaHistoryBloc>(
            create: (BuildContext context) => PizzaHistoryBloc(sl()),
          ),
          BlocProvider<ScanKtpBloc>(create: (context) => sl()),
          BlocProvider<ScannerBloc>(create: (context) => sl()),
        ],
        child: MaterialApp(
            title: "Pizza App",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                backgroundColor: appColorBackground,
                primaryColor: appColorSecondaryDarkBlue,
                accentColor: appColorPrimaryYellow),
            home: MainScreen()),
      )
  );
}
