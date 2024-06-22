import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdp/extras/bedroom.dart';
import 'package:gdp/extras/provider.dart';
import 'package:gdp/pages/login.dart';
import 'package:provider/provider.dart';
import 'extras/mqtt.dart';
import 'pages/home.dart';
import 'pages/signup.dart';
import 'pages/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MqttProvider()),
        ChangeNotifierProvider(create: (_) => change()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Login(),
          );
        },
      ),
    );
  }
}