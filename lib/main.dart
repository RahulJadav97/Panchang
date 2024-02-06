import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panchang/auth/screen/login_screen.dart';
import 'package:get/get.dart';
import 'package:panchang/splash_screen.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  // tz.initializeTimeZones();
  // var londonLocation = tz.getLocation('Asia/Kolkata');
  // print("londonLocation $londonLocation");
  // var nowInLondon = tz.TZDateTime.now(londonLocation);
  // print(nowInLondon);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Panchang',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const SplashScreen(),
    );
  }
}


