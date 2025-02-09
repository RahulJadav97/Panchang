import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:panchang/Predictions/Controller/DailyPredictionController.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';
import 'package:translator/translator.dart';

import '../../panchang/screen/panchang_screen.dart';

class DailyPredictionScreen extends StatefulWidget {
  String ?date;
   DailyPredictionScreen({required this.date});

  @override
  State<DailyPredictionScreen> createState() => _DailyPredictionScreenState();
}

class _DailyPredictionScreenState extends State<DailyPredictionScreen> {
  final translator = GoogleTranslator();

  DailyPredictionController _dailyPredictionCont_obj = Get.put(DailyPredictionController());
  @override
  void initState() {
    _dailyPredictionCont_obj.dailyPredictionCont();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: common_backcolor,
        body: Obx(
           () {
            return Container(
              height: Get.height,
              width: Get.width,
              // decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: AssetImage("assets/images/texture3.jpg",)
              //     )
              // ),
              child:_dailyPredictionCont_obj.loading.value?Center(child: CircularProgressIndicator(color: common_red,))
                  :
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Get.width*0.020),
                    height: Get.height*0.050,
                    width: Get.width,
                    color: Colors.grey.shade700,
                    alignment: Alignment.centerLeft,
                    child:
                    FutureBuilder<Translation>(
                      future: translator.translate("Daily Prediction", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                              snapshot.data!.text,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)
                          );
                        } else {
                          return Text("Daily Prediction", style:font_style.White_700_18_ff ,);
                        }
                      },
                    ),
                    // Text("Daily Prediction", style:font_style.White_700_18_ff ,),

                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.010,),
                  Container(
                    // height: SizeConfig.screenHeight*0.040,
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:common_red,
                      borderRadius: BorderRadius.circular(5),

                    ),

                    // child: Text("Chaughadia ${currentDate.toString()}", style: font_style.White_700_16_ff,),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:
                      FutureBuilder<Translation>(
                        future: translator.translate("Daily Prediction ${widget.date.toString()}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                                snapshot.data!.text,
                                style: font_style.White_700_16_ff
                            );
                          } else {
                            return Text("Daily Prediction ${widget.date.toString()}",  style: font_style.White_700_16_ff,);
                          }
                        },
                      ),
                      // Text("Daily Prediction ${widget.date.toString()}", style: font_style.White_700_16_ff,),
                    ),

                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.010,),
                  // SizedBox(height: Get.height*0.020,),

                  _dailyPredictionCont_obj.allData.length == 0
                      ?
                      Expanded(child: Container(
                        alignment: Alignment.center,
                        child: Text("No Daily Predictions Found..", style: font_style.Black_500_18_ff,),
                      ))
                      :
                 Expanded(
                   child: Container(
                     // color: Colors.grey.shade300,
                     child: ListView.separated(
                       itemCount: _dailyPredictionCont_obj.allData.length,
                       itemBuilder: (context, index) {
                         return Container(
                           margin: EdgeInsets.all(Get.width*0.020),
                           padding: EdgeInsets.all(Get.width*0.040),
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Color(0XFFfedec5),
                               border: Border.all(color: common_red, width: 1),
                               boxShadow: const [
                                 BoxShadow(
                                     blurRadius: 1,
                                     color: Color(0XFFbe765a),
                                     spreadRadius: 1.0,
                                     offset: Offset(0.0, 2.0)
                                 )
                               ]
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Container(
                                 padding: EdgeInsets.all(Get.width*0.010),
                                 width: Get.width,
                                 // color: Colors.blue,
                                 child:
                                 FutureBuilder<Translation>(
                                   future: translator.translate("${_dailyPredictionCont_obj.oldResponse.value.data![index].sunsignName.toString()}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                   builder: (context, snapshot) {
                                     if (snapshot.hasData) {
                                       return Text(
                                           snapshot.data!.text,
                                           style: TextStyle(color: common_red,fontSize: 15,fontWeight: FontWeight.bold)
                                       );
                                     } else {
                                       return  Text("${_dailyPredictionCont_obj.oldResponse.value.data![index].sunsignName.toString()}",
                                           style: TextStyle(color: common_red,fontSize: 15,fontWeight: FontWeight.bold));
                                     }
                                   },
                                 ),
                                 // Text("${_dailyPredictionCont_obj.oldResponse.value.data![index].sunsignName.toString()}",
                                 //     style: TextStyle(color: common_red,fontSize: 15,fontWeight: FontWeight.bold)),
                               ),
                               Container(
                                 padding: EdgeInsets.all(Get.width*0.010),
                                 width: Get.width,
                                 // color: Colors.blue,
                                 child:
                                 FutureBuilder<Translation>(
                                   future: translator.translate("${_dailyPredictionCont_obj.oldResponse.value.data![index].date.toString()}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                   builder: (context, snapshot) {
                                     if (snapshot.hasData) {
                                       return Text(
                                           snapshot.data!.text,
                                           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)
                                       );
                                     } else {
                                       return Text("${_dailyPredictionCont_obj.oldResponse.value.data![index].date.toString()}", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold));
                                     }
                                   },
                                 ),
                                 // Text("${_dailyPredictionCont_obj.oldResponse.value.data![index].date.toString()}", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                               ),

                               Container(
                                 padding: EdgeInsets.all(Get.width*0.010),
                                 width: Get.width,
                                 // color: Colors.blue,
                                 child:
                                 FutureBuilder<Translation>(
                                   future: translator.translate("${_dailyPredictionCont_obj.oldResponse.value.data![index].description.toString()}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                   builder: (context, snapshot) {
                                     if (snapshot.hasData) {
                                       return Text(
                                           snapshot.data!.text,
                                           style: font_style.Black_700_15_ff
                                       );
                                     } else {
                                       return Text(_dailyPredictionCont_obj.oldResponse.value.data![index].description.toString(),
                                         style: font_style.Black_700_15_ff,);
                                     }
                                   },
                                 ),
                                 // Text(_dailyPredictionCont_obj.oldResponse.value.data![index].description.toString(),
                                 // style: font_style.Black_700_15_ff,),
                               ),
                               // SizedBox(height: Get.height*0.005,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                     // height: Get.height*0.060,
                                     width: Get.width*0.400,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: Color(0XFFfedec5),
                                         border: Border.all(color: common_red, width: 1),
                                         boxShadow: const [
                                           BoxShadow(
                                               blurRadius: 1,
                                               color: Color(0XFFbe765a),
                                               spreadRadius: 1.0,
                                               offset: Offset(0.0, 2.0)
                                           )
                                         ]
                                     ),
                                     alignment: Alignment.centerLeft,
                                     padding: EdgeInsets.all(Get.width*0.015),
                                     child:
                                     FutureBuilder<Translation>(
                                       future: translator.translate("Lucky Number : ${_dailyPredictionCont_obj.oldResponse.value.data![index].luckyNumber.toString()}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                       builder: (context, snapshot) {
                                         if (snapshot.hasData) {
                                           return Text(
                                               snapshot.data!.text,
                                               style: font_style.Black_bold_15_ff
                                           );
                                         } else {
                                           return Text("Lucky Number : ${_dailyPredictionCont_obj.oldResponse.value.data![index].luckyNumber.toString()}", style: font_style.Black_bold_15_ff,);
                                         }
                                       },
                                     ),
                                     // Text("Lucky Number : ${_dailyPredictionCont_obj.oldResponse.value.data![index].luckyNumber.toString()}", style: font_style.Black_bold_15_ff,),
                                   ),
                                   Container(
                                     // height: Get.height*0.060,
                                     width: Get.width*0.400,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: Color(0XFFfedec5),
                                         border: Border.all(color: common_red, width: 1),
                                         boxShadow: const [
                                           BoxShadow(
                                               blurRadius: 1,
                                               color: Color(0XFFbe765a),
                                               spreadRadius: 1.0,
                                               offset: Offset(0.0, 2.0)
                                           )
                                         ]
                                     ),
                                     alignment: Alignment.centerLeft,
                                     padding: EdgeInsets.all(Get.width*0.015),
                                     child:
                                     FutureBuilder<Translation>(
                                       future: translator.translate("Lucky Colour: ${_dailyPredictionCont_obj.oldResponse.value.data![index].luckyColor.toString()}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                       builder: (context, snapshot) {
                                         if (snapshot.hasData) {
                                           return Text(
                                               snapshot.data!.text,
                                             style: font_style.Black_bold_15_ff,
                                           );
                                         } else {
                                           return Text("Lucky Colour: ${_dailyPredictionCont_obj.oldResponse.value.data![index].luckyColor.toString()}", style: font_style.Black_bold_15_ff,);
                                         }
                                       },
                                     ),
                                     // Text("Lucky Colour: ${_dailyPredictionCont_obj.oldResponse.value.data![index].luckyColor.toString()}", style: font_style.Black_bold_15_ff,),
                                   )

                                 ],
                               )
                             ],
                           ),
                         );
                       },
                         separatorBuilder: (context, index) {
                           return SizedBox(height: Get.height*0.020,);
                         },
                         ),
                   ),
                 )


                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
