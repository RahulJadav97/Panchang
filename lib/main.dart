import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
    //   GetMaterialApp(
    //   title: 'Panchang',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home:const SplashScreen(),
    // );
      ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_ , child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Panchang',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: child,
          );
        },
        child:const SplashScreen(),
      );
  }
}


