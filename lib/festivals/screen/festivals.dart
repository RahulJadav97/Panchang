import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/festivals/screen/festival_search_screen.dart';
import 'package:panchang/festivals/screen/monthFestivale_screen.dart';

class FestivalsScreen extends StatefulWidget {
  const FestivalsScreen({super.key});

  @override
  State<FestivalsScreen> createState() => _FestivalsScreenState();
}

class _FestivalsScreenState extends State<FestivalsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: common_backcolor,
        body: Container(
          height: Get.height,
          width: Get.width,
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         fit: BoxFit.cover,
          //         image: AssetImage("assets/images/texture3.jpg",)
          //     )
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: Get.width*0.020),
                  height: Get.height*0.050,
                  width: Get.width,
                  color: Colors.grey.shade700,
                  alignment: Alignment.centerLeft,
                  child: Text("Festivals ", style:font_style.White_700_18_ff ,),

                ),
                SizedBox(height: Get.height*0.020,),

                InkWell(
                  onTap: (){
                    Get.to(FestivalSearchScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(Get.width*0.010),
                    height: Get.height*0.080,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Colors.white,
                        border: Border.all(color: common_red, width: 2)
                    ),
                    alignment: Alignment.center,
                    child: Container(
                        height: Get.height*0.075,
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:common_red,
                        ),
                        child: Text("Festival Search",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                  ),
                ),
                SizedBox(height: Get.height*0.020,),

                InkWell(
                  onTap: (){
                    Get.to(const MonthFestivalScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(Get.width*0.010),
                    height: Get.height*0.080,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Colors.white,
                        border: Border.all(color:  Color(0xff1b567a), width: 2)
                    ),
                    alignment: Alignment.center,
                    child: Container(
                        height: Get.height*0.075,
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff1b567a),
                        ),
                        child: Text("Monthly Festivals",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                  ),
                ),
                SizedBox(height: Get.height*0.020,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
