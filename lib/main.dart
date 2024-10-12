import 'package:flutter/material.dart';
import 'package:maroid/app_State.dart';
import 'package:maroid/introdution/introduction.dart';
import 'package:maroid/introdution/main_menu.dart';
import 'package:maroid/registerFile.dart';
import 'package:maroid/splash/datamemory.dart';
import 'package:maroid/splash/splash.dart';

import 'home/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget(
      child: Builder(
          builder: (BuildContext innerContext) {
            return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'M. A. Roid',
        onGenerateRoute: (setting){
          var route = {
            '/indroduction':const Introductioncreen(),
            '/mainMenu' : const MainMenu(),
            '/home': const MyHomePage(),
            '/registerFile': const RegisterFile(),
            '/datamemory': const DataMemory()
          };
          return MaterialPageRoute(builder: (_)=>route[setting.name] ?? const SplashScreen());
        },
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
      );
      }
      )
    );
  }
}

