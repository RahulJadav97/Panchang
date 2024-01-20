import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panchang/Hora/controller/hora_controller.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';

class HoraScreen extends StatefulWidget {
  const HoraScreen({super.key});

  @override
  State<HoraScreen> createState() => _HoraScreenState();
}

class _HoraScreenState extends State<HoraScreen> {

  HoraController hora = Get.put(HoraController());

  var formattedDate ;
  bool chindex = false;

  @override
  void initState() {
    DateTime currentDate = DateTime.now();

     formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
    print('Formatted Current Date: $formattedDate');
    hora.horaCont();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }



  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async{
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ]);
        return true;
      },
      child: SafeArea(
          child: Scaffold(
            backgroundColor: common_backcolor,
            body:Obx(() => hora.loading.value?Center(child: CircularProgressIndicator(color: common_red,),):
            OrientationBuilder(
              builder: (context, orientation) {
                return Container(
                  height: SizeConfig.screenHeight*0.9,
                  width: SizeConfig.screenWidth,
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: AssetImage("assets/images/texture3.jpg",)
                  //     )
                  // ),
                  child: ListView(
                    children: [

                      /// line
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.010, horizontal: SizeConfig.screenWidth*0.010),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.all(Get.width*0.010),
                      //         // height: SizeConfig.screenHeight*0.100,
                      //         width: Get.width*0.98,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(2),
                      //           color:common_red,
                      //         ),
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(""" Not good for Auspicious Work. Good for Bravery works, sports and competitive activities, electrical and mechanical engineering works, fire related work, pursuing litigation, construction work can be performed during Hora of Mangal.""",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.only(left: Get.width*0.020),
                        height: SizeConfig.screenHeight*0.070,
                        width: Get.width,
                        color: Colors.grey.shade700,
                        alignment: Alignment.centerLeft,
                        child: Text("Hora", style:font_style.White_700_18_ff ,),

                      ),
                      Container(
                        height: SizeConfig.screenHeight*0.080,
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:common_red,
                          borderRadius: BorderRadius.circular(5),

                        ),

                        child: Text("Hora ${formattedDate}", style: font_style.White_700_18_ff,),

                      ),
                      Container(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(height: SizeConfig.screenHeight*0.010,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      chindex = false;
                                      print("Day Chaughadia");
                                    });
                                  },
                                  child: Container(
                                    height: SizeConfig.screenHeight*0.070,
                                    width: Get.width*0.200,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xffcb1505),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    // padding: EdgeInsets.all(Get.width*0.020),
                                    child: Text("Day", style:font_style.White_700_18_ff ,),
                                  ),
                                ),
                                SizedBox(width: Get.width*0.020,),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      chindex = true;
                                      print("Night Chaughadia");
                                    });
                                  },
                                  child: Container(
                                    height: SizeConfig.screenHeight*0.070,
                                    width: Get.width*0.200,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xffcb1505),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    // padding: EdgeInsets.all(Get.width*0.020),
                                    child: Text("Night", style:font_style.White_700_18_ff ,),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.020, horizontal: SizeConfig.screenHeight*0.005),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
                              height: SizeConfig.screenHeight*0.100,
                              width: Get.width*0.320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color:common_green,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text("Time",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
                              height: SizeConfig.screenHeight*0.100,
                              width: Get.width*0.320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color:common_green,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text("Ruling Planet",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
                            //   height: SizeConfig.screenHeight*0.100,
                            //   width: Get.width*0.320,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(2),
                            //     color:common_green,
                            //   ),
                            //   alignment: Alignment.centerLeft,
                            //   child: Text("Significance",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                            // ),

                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight*0.002,),

                      Container(
                        // height: SizeConfig.screenHeight*0.93,
                        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.100),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: hora.oldResponse.value.data!.day!.length,
                          // itemCount: daytimeList.length,
                          itemBuilder: (context, index) {
                            print("date ${hora.oldResponse.value.data!.day!.first.startTime}");
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.005, horizontal: SizeConfig.screenHeight*0.005),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
                                    height: SizeConfig.screenHeight*0.100,
                                    width: Get.width*0.320,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color:common_red,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text("${chindex == false?"${hora.oldResponse.value.data!.day![index].startTime} to ${
                                        hora.oldResponse.value.data!.day![index].endTime
                                    }":
                                    "${hora.oldResponse.value.data!.night![index].startTime} to ${
                                        hora.oldResponse.value.data!.night![index].endTime
                                    }"
                                    }",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
                                    height: SizeConfig.screenHeight*0.100,
                                    width: Get.width*0.320,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color:common_red,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text("${chindex == false?hora.oldResponse.value.data!.day![index].planet:hora.oldResponse.value.data!.night![index].planet}",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                                  ),
                                ],
                              ),
                            );

                          },
                          // separatorBuilder: (context, index) {
                          //   return SizedBox(height: Get.height*0.020,);
                          // },
                        ),
                      ),
                      /// signi
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.010, horizontal: SizeConfig.screenWidth*0.010),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
                      //         height: SizeConfig.screenHeight*0.100,
                      //         width: Get.width*0.320,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(2),
                      //           color:common_green,
                      //         ),
                      //         alignment: Alignment.centerLeft,
                      //         child: Text("Singnification:",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      /// last
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.020, horizontal: SizeConfig.screenWidth*0.010),
                        child: Row(
                          children: [
                            Container(
                                height: SizeConfig.screenHeight*0.300,
                                width: SizeConfig.screenWidth*0.970,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  // borderRadius: BorderRadius.circular(5),
                                  color:Colors.black,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: SizeConfig.screenHeight,
                                      width: SizeConfig.screenWidth*0.180,
                                      color: Colors.red,
                                      child: Image.asset("assets/images/halfcilentImg.png", fit: BoxFit.fill,),
                                    ),
                                    Container(
                                      height: SizeConfig.screenHeight,
                                      width: SizeConfig.screenWidth*0.700,
                                      color: Colors.black,
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: SizeConfig.screenHeight*0.020,),
                                          Text("Reach us at:",style: font_style.white_600_20_cl,textAlign: TextAlign.center, ),
                                          SizedBox(height: SizeConfig.screenHeight*0.010,),

                                          Text("www.premastrologer.com",style: font_style.white_600_20_cl,textAlign: TextAlign.center, ),
                                          SizedBox(height: SizeConfig.screenHeight*0.010,),

                                          Text("psharma@premastrologer.com",style: font_style.white_600_20_cl,textAlign: TextAlign.center, ),


                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      /// line
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.010, horizontal: SizeConfig.screenWidth*0.010),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(Get.width*0.010),
                              // height: SizeConfig.screenHeight*0.100,
                              width: Get.width*0.98,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color:common_red,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(""" Not good for Auspicious Work. Good for Bravery works, sports and competitive activities, electrical and mechanical engineering works, fire related work, pursuing litigation, construction work can be performed during Hora of Mangal.""",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                );
              },
            ),
            )

          )
      ),
    );
  }
}
