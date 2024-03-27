import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/panchang/screen/panchang_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

import '../../festivals/screen/festival_web_view.dart';
import '../controller/month_significance_controller.dart';

class MonthSignificance extends StatefulWidget {
  const MonthSignificance({super.key});

  @override
  State<MonthSignificance> createState() => _MonthSignificanceState();
}

class _MonthSignificanceState extends State<MonthSignificance> {
  final translator = GoogleTranslator();
  var msigni = Get.put(MonthlySignificanceController());

  @override
  void initState() {
    msigni.monthlySignificanceCont(monthListNo);
    super.initState();
  }

  List monthNo = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
  ];


  List<String> monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  var month = "January";
  var monthListNo = '01';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: common_backcolor,
          body: SingleChildScrollView(
            child:Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: Get.width*0.020),
                  height: Get.height*0.050,
                  width: Get.width,
                  color: Colors.grey.shade700,
                  alignment: Alignment.centerLeft,
                  child:
                  FutureBuilder<Translation>(
                    future: translator.translate("Monthly Significance", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.text,
                            style:font_style.White_700_18_ff
                        );
                      } else {
                        return  Text("Monthly Significance", style:font_style.White_700_18_ff ,);
                      }
                    },
                  ),
                  // Text("Monthly Significance", style:font_style.White_700_18_ff ,),

                ),
                SizedBox(height: Get.height*0.020,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width*0.4,
                      height: Get.height*0.9,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: monthNames.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap:()async{
                                    setState(() {
                                      month = monthNames[index];
                                      monthListNo= monthNo[index];
                                    });
                                    msigni.monthlySignificanceCont(monthListNo);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
                                    height: Get.height*0.060,
                                    width: Get.width*0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:common_red
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child:
                                    FutureBuilder<Translation>(
                                      future: translator.translate("${monthNames[index]} :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              snapshot.data!.text,
                                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),textAlign: TextAlign.center
                                          );
                                        } else {
                                          return  Text("${monthNames[index]} :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                    // Text("${monthNames[index]} :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),textAlign: TextAlign.center ),
                                    // child: Text("${monthNames[index]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center ),
                                  ),
                                ),

                              ],
                            ),
                          );

                        },
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8.0,),
                            child: Container(
                              alignment: Alignment.center,
                              height: Get.height*0.065,
                              width: Get.width*0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0XFFfedec5),
                                  border: Border.all(color: common_red, width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        color: Color(0XFFbe765a),
                                        spreadRadius: 1.0,
                                        offset: Offset(0.0, 2.0)
                                    )
                                  ]
                              ),
                              child:
                              FutureBuilder<Translation>(
                                future: translator.translate("$month:", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                        snapshot.data!.text,
                                        style: font_style.Black_400_15_ff
                                    );
                                  } else {
                                    return  Text("$month", style: font_style.Black_400_15_ff,);
                                  }
                                },
                              ),
                              // Text("$month", style: font_style.Black_400_15_ff,),
                            ),
                          ),
                          SizedBox(height: Get.height*0.02,),
                          Obx(() => msigni.loading.value?Center(child: CircularProgressIndicator(color: common_red,),):
                          Container(
                            height: Get.height*0.8,
                            // color: Colors.blue,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:msigni.allMonthlySignificance.length,
                                itemBuilder: (BuildContext context ,int index){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        // Get.to(()=>FestivalWebScreen(webUrl: monthFestival.monthFestivalList[index].link.toString(),));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color:common_red
                                        ),

                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FutureBuilder<Translation>(
                                                  future: translator.translate("$month:", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                          snapshot.data!.text,
                                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)
                                                      );
                                                    } else {
                                                      return  Text('${msigni.allMonthlySignificance[index].title}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white));
                                                    }
                                                  },
                                                ),
                                                // Text('${msigni.allMonthlySignificance[index].title}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)),
                                                FutureBuilder<Translation>(
                                                  future: translator.translate("Date: ${msigni.allMonthlySignificance[index].date}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                          snapshot.data!.text,
                                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)
                                                      );
                                                    } else {
                                                      return   Text('Date: ${msigni.allMonthlySignificance[index].date}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white));
                                                    }
                                                  },
                                                ),
                                                // Text('Date: ${msigni.allMonthlySignificance[index].date}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          )
                          )

                        ],
                      ),
                    )

                  ],
                )
              ],
            ) ,
          ),
        )
    );
  }
}
