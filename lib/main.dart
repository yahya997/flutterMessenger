import 'package:flutter/material.dart';
import 'package:fluttermessengerapp/screens/chat_screen.dart';
import 'package:fluttermessengerapp/screens/main_screen.dart';
import 'package:fluttermessengerapp/screens/search_screen.dart';
import 'package:fluttermessengerapp/screens/splash_screen.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              brightness: Brightness.light,
              color: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              actionsIconTheme: IconThemeData(color: Colors.black)),
          fontFamily: "Ubuntu",
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff0084FF)),
      home: SplashScreen(),
      routes: {
        '/main': (context) => MainScreen(),
        '/search':(context)=>SearchScreen(),
        '/chat': (context) => ChatScreen()
      },
    );
  }
}
