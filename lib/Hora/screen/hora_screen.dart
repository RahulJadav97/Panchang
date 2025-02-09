import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panchang/Hora/controller/hora_controller.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/festivals/screen/festival_web_view.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../panchang/screen/panchang_screen.dart';

class HoraScreen extends StatefulWidget {
  const HoraScreen({super.key});

  @override
  State<HoraScreen> createState() => _HoraScreenState();
}

class _HoraScreenState extends State<HoraScreen> {

  final translator = GoogleTranslator();

  HoraController hora = Get.put(HoraController());

  var formattedDate ;
  bool chindex = false;
  var colorIndex;


  Future<void> dateFun() async {
    DateTime currentDate = DateTime.now();
    formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
    print('Formatted Current Date: $formattedDate');
  }

  @override
  void initState() {
    getdelhiData().then((value){
      dateFun();
    });
    hora.horaCont();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    super.initState();
  }
  var ddd  = "";
  var mmm = "" ;
  var yyy = "" ;

  Future<void> getdelhiData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString("sh_cityRowId", "1724");
    print("dd:${sh.getString("sh_selectedDay")}");
    print("mm:${sh.getString("sh_selectedMonth")}");
    print("yy:${sh.getString("sh_selectedYear")}");
    setState(() {
      ddd = sh.getString("sh_selectedDay").toString();
      mmm = sh.getString("sh_selectedMonth").toString();
      yyy = sh.getString("sh_selectedYear").toString();
    });
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

                        child: Text("Hora $ddd-$mmm-$yyy ", style: font_style.White_700_18_ff,),

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
                                    child:
                                    FutureBuilder<Translation>(
                                      future: translator.translate("Day", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.White_700_18_ff ,
                                          );
                                        } else {
                                          return Text("Day", style:font_style.White_700_18_ff ,);
                                        }
                                      },
                                    ),
                                    // Text("Day", style:font_style.White_700_18_ff ,),
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
                                    child:
                                    FutureBuilder<Translation>(
                                      future: translator.translate("Night", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.White_700_18_ff ,
                                          );
                                        } else {
                                          return Text("Night", style:font_style.White_700_18_ff ,);
                                        }
                                      },
                                    ),
                                    // Text("Night", style:font_style.White_700_18_ff ,),
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
                              child:
                              FutureBuilder<Translation>(
                                future: translator.translate("Time", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.text,
                                        style: font_style.White_700_18_ff,textAlign: TextAlign.center );
                                  } else {
                                    return Text("Time",style: font_style.White_700_18_ff,textAlign: TextAlign.center );
                                  }
                                },
                              ),
                              // Text("Time",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
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
                              child:
                              FutureBuilder<Translation>(
                                future: translator.translate("Ruling Planet", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                        snapshot.data!.text,
                                        style: font_style.White_700_18_ff,textAlign: TextAlign.center );
                                  } else {
                                    return Text("Ruling Planet",style: font_style.White_700_18_ff,textAlign: TextAlign.center );
                                  }
                                },
                              ),
                              // Text("Ruling Planet",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
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
                              child:
                              FutureBuilder<Translation>(
                                future: translator.translate("Significance", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                        snapshot.data!.text,
                                        style: font_style.White_700_18_ff,textAlign: TextAlign.center );
                                  } else {
                                    return Text("Significance",style: font_style.White_700_18_ff,textAlign: TextAlign.center );
                                  }
                                },
                              ),
                              // Text("Significance",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
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
                                    child:
                                    FutureBuilder<Translation>(
                                      future: translator.translate("${chindex == false?hora.oldResponse.value.data!.day![index].planet:hora.oldResponse.value.data!.night![index].planet}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              snapshot.data!.text,
                                              style: font_style.White_700_18_ff,textAlign: TextAlign.center);
                                        } else {
                                          return Text("${chindex == false?hora.oldResponse.value.data!.day![index].planet:hora.oldResponse.value.data!.night![index].planet}",style: font_style.White_700_18_ff,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                    // Text("${chindex == false?hora.oldResponse.value.data!.day![index].planet:hora.oldResponse.value.data!.night![index].planet}",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                                  ),

                                  GestureDetector(
                                    onTap:(){
                                      setState(() {
                                        colorIndex = index;
                                        print("colorIndex ${colorIndex}");
                                        print("colorIndex ${index}");
                                      });
                                      Get.defaultDialog(
                                         backgroundColor: common_backcolor,
                                        title: "Significance",
                                        titleStyle: font_style.Red_700_18,
                                        content: Column(
                                          children: [
                                            FutureBuilder<Translation>(
                                              future: translator.translate("${chindex == false?hora.oldResponse.value.data!.day![index].significance:hora.oldResponse.value.data!.night![index].significance}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                      snapshot.data!.text,
                                                      style: font_style.Black_700_18);
                                                } else {
                                                  return  Text("${chindex == false?hora.oldResponse.value.data!.day![index].significance:hora.oldResponse.value.data!.night![index].significance}",style: font_style.Black_700_18,);
                                                }
                                              },
                                            ),
                                            // Text("${chindex == false?hora.oldResponse.value.data!.day![index].significance:hora.oldResponse.value.data!.night![index].significance}",style: font_style.Black_700_18,)
                                          ],
                                        )
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
                                      height: SizeConfig.screenHeight*0.100,
                                      width: Get.width*0.320,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color:colorIndex !=index ?common_red:common_green,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child:
                                      FutureBuilder<Translation>(
                                        future: translator.translate("${chindex == false?hora.oldResponse.value.data!.day![index].significance:hora.oldResponse.value.data!.night![index].significance}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                snapshot.data!.text,
                                                overflow: TextOverflow.ellipsis,style: font_style.White_700_18_ff,textAlign: TextAlign.center );
                                          } else {
                                            return  Text("${chindex == false?hora.oldResponse.value.data!.day![index].significance:hora.oldResponse.value.data!.night![index].significance}",overflow: TextOverflow.ellipsis,style: font_style.White_700_18_ff,textAlign: TextAlign.center );
                                          }
                                        },
                                      ),
                                      // Text("${chindex == false?hora.oldResponse.value.data!.day![index].significance:hora.oldResponse.value.data!.night![index].significance}",overflow: TextOverflow.ellipsis,style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                                    ),
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
                      //           border: Border.all(color: common_red,width: 3),
                      //           borderRadius: BorderRadius.circular(2),
                      //           color:common_green,
                      //         ),
                      //         alignment: Alignment.centerLeft,
                      //         child: Text("Significance:",style: font_style.White_700_18_ff,textAlign: TextAlign.center ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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

                                          InkWell(
                                              onTap: (){
                                                Get.to(()=>FestivalWebScreen(webUrl: "https://www.premastrologer.com/",));
                                              },
                                              child: Text("www.premastrologer.com",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                                          SizedBox(height: SizeConfig.screenHeight*0.010,),

                                          InkWell(
                                            onTap: (){
                                              redirectToGmail();
                                            },
                                              child: Text("psharma@premastrologer.com",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),


                                        ],
                                      ),
                                    ),
                                  ],
                                )),
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
  void redirectToGmail() async {
    const emailAddress = 'psharma@premastrologer.com';
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );
    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }
}
