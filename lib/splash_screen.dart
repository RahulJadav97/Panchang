import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panchang/auth/screen/login_screen.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/screen/change_home_screen.dart';
import 'home/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    getUserData();
    Timer(Duration(seconds: 4), () {

      if(userIDs.toString() == ""||userIDs.toString() == null  || userIDs.toString() == "null"){
        print("userID ${userIDs}");
        Get.offAll(const LoginScreen());
      }else{
        Get.offAll(HomeScreen());
        // Get.offAll(()=>ChangeHomeScreen());
      }

    });
    super.initState();


  }
  var userIDs ;
  getUserData()async{
    SharedPreferences sh = await SharedPreferences.getInstance();
    userIDs = sh.getString("sh_userId");
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      alignment: Alignment.center,
      padding: EdgeInsets.all(SizeConfig.screenWidth*0.1),
      child: Image.asset("assets/images/PremAstrologer_FinalLOGO-01-01.png"),
    );
  }
}
