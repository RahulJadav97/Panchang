import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'home_screen.dart';
class ChangeHomeScreen extends StatefulWidget {
  const ChangeHomeScreen({super.key});

  @override
  State<ChangeHomeScreen> createState() => _ChangeHomeScreenState();
}

class _ChangeHomeScreenState extends State<ChangeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: (){
              Get.to(()=>HomeScreen());
            },
            child: Container(
              alignment: Alignment.center,
              height: Get.height*0.2,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text("Significance",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),),
            ),
          ),
          InkWell(
            onTap: (){
              Get.to(()=>HomeScreen());
            },
            child: Container(
              alignment: Alignment.center,
              height: Get.height*0.2,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.brown.shade800,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text("Chaughadiya",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),),
            ),
          ),
          InkWell(
            onTap: (){
              Get.to(()=>HomeScreen());
            },
            child: Container(
              alignment: Alignment.center,
              height: Get.height*0.2,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.cyan.shade800,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text("Hora",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),),
            ),
          ),
        ],
      ),
    );
  }
}
