import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panchang/chaughadia/controller/choghadiya_controller.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';
import 'package:translator/translator.dart';

import '../../panchang/screen/panchang_screen.dart';

class ChaughadiaScreen extends StatefulWidget {

  String ?date;

  ChaughadiaScreen({required this.date}); // const ChaughadiaScreen({super.key});

  @override
  State<ChaughadiaScreen> createState() => _ChaughadiaScreenState();
}

class _ChaughadiaScreenState extends State<ChaughadiaScreen> {
  ChogadiyaController chogadiyaController = Get.put(ChogadiyaController());
  final translator = GoogleTranslator();

  bool chindex = false;

  @override
  void initState() {
    chogadiyaController.choghadiyaCont();
    getCurrentDate();
    print("date :${widget.date.toString()}");
    super.initState();
  }
  // setState(() {
  // currentDate = formattedDate;
  // });
  var currentDate;
  var currentDay;
  var currentMonth;
  var currentYear;
  void getCurrentDate() async {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(now);
    setState(() {
    currentDate = formattedDate;
    });

    // Split the formatted date into day, month, and year
    List<String> dateComponents = formattedDate.split('-');

    // Extract day, month, and year from the list
    String day = dateComponents[0];
    String month = dateComponents[1];
    String year = dateComponents[2];

    setState(() {
      currentDate = formattedDate;
      currentDay = day;
      currentMonth = month;
      currentYear = year;
      print("currentDay $currentDay");
      print("currentMonth $currentMonth");
      print("currentYear $currentYear");
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: common_backcolor,
          body:Obx(() => chogadiyaController.loading.value?Center(child: CircularProgressIndicator(color: common_red,),):
          Container(
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         fit: BoxFit.cover,
            //         image: AssetImage("assets/images/texture3.jpg",)
            //     )
            // ),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.020),
                  height: SizeConfig.screenHeight*0.050,
                  width: SizeConfig.screenWidth,
                  color: Colors.grey.shade700,
                  alignment: Alignment.centerLeft,
                  child: FutureBuilder<Translation>(
                    future: translator.translate("Chaughadiya ", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.text,
                          style:font_style.White_700_18_ff
                        );
                      } else {
                        return  Text("Chaughadiya ",style:font_style.White_700_18_ff );
                      }
                    },
                  ),

                ),
                SizedBox(height: SizeConfig.screenHeight*0.002,),
                Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.010),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: SizeConfig.screenHeight*0.040,
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:common_red,
                          borderRadius: BorderRadius.circular(5),

                        ),

                        // child: Text("Chaughadia ${currentDate.toString()}", style: font_style.White_700_16_ff,),
                        child: FutureBuilder<Translation>(
                          future: translator.translate("Chaughadia ${widget.date.toString()}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                  snapshot.data!.text,
                                  style:font_style.White_700_18_ff
                              );
                            } else {
                              return  Text("Chaughadia ${widget.date.toString()}", style: font_style.White_700_16_ff,);
                            }
                          },
                        ),

                      ),
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
                              height: SizeConfig.screenHeight*0.035,
                              width: SizeConfig.screenWidth*0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xffcb1505),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              // padding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                              child: FutureBuilder<Translation>(
                                future: translator.translate("Day", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                        snapshot.data!.text,
                                        style:font_style.White_700_16_ff
                                    );
                                  } else {
                                    return  Text("Day", style:font_style.White_700_16_ff,);
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: SizeConfig.screenWidth*0.020,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                chindex = true;
                                print("Night Chaughadia");
                              });
                            },
                            child: Container(
                              height: SizeConfig.screenHeight*0.035,
                              width: SizeConfig.screenWidth*0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xffcb1505),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              // padding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                              child: FutureBuilder<Translation>(
                                future: translator.translate("Night", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                        snapshot.data!.text,
                                        style:font_style.White_700_16_ff
                                    );
                                  } else {
                                    return  Text("Night", style:font_style.White_700_16_ff,);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  height: SizeConfig.screenHeight*0.9,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: chogadiyaController.oldResponse.value.data!.day!.length,
                    itemBuilder: (context, index) {
                      var dayindex = chogadiyaController.oldResponse.value.data!.day![index];
                      print("day ${dayindex.choghadiya}");
                      print("day ${dayindex.start}");
                      var nightindex = chogadiyaController.oldResponse.value.data!.night![index];
                     return  Padding(
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.005, horizontal: SizeConfig.screenHeight*0.005),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth*0.020, vertical: 0.050),
                              height: SizeConfig.screenHeight*0.055,
                              width: SizeConfig.screenWidth*0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:Color(0xffcb1505),
                              ),
                              alignment: Alignment.centerLeft,
                              child: FutureBuilder<Translation>(
                                future: translator.translate("${chindex == false?dayindex.choghadiya:nightindex.choghadiya}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                        snapshot.data!.text,
                                        style: font_style.White_700_16_ff,textAlign: TextAlign.center
                                    );
                                  } else {
                                    return  Text("${chindex == false?dayindex.choghadiya:nightindex.choghadiya}", style: font_style.White_700_16_ff,textAlign: TextAlign.center);
                                  }
                                },
                              ),
                            ),
                            Container(
                              // height: SizeConfig.screenHeight*0.055,
                              width: SizeConfig.screenWidth*0.650,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
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
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    FutureBuilder<Translation>(
                                      future: translator.translate("${chindex == false?"${dayindex.start} to ${dayindex.end}":"${"${nightindex.start} to ${nightindex.end}"}"}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              snapshot.data!.text,
                                              style: font_style.Black_bold_15_ff
                                          );
                                        } else {
                                          return  Text("${chindex == false?"${dayindex.start} to ${dayindex.end}":"${"${nightindex.start} to ${nightindex.end}"}"}",  style: font_style.Black_bold_15_ff);
                                        }
                                      },
                                    ),
                                    chindex == false&& dayindex.yamagandam !="0"?
                                    FutureBuilder<Translation>(
                                      future: translator.translate("${chindex == false?dayindex.yamagandam:nightindex.yamagandam}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              snapshot.data!.text,
                                              style: font_style.Black_bold_15_ff
                                          );
                                        } else {
                                          return  Text("${chindex == false?dayindex.yamagandam:nightindex.yamagandam}",  style: font_style.Black_bold_15_ff);
                                        }
                                      },
                                    ):
                                    // Text("${chindex == false?dayindex.yamagandam:nightindex.yamagandam}", style: font_style.Black_bold_15_ff,):SizedBox(),
                                    chindex == false&& dayindex.gulikaKaal !="0"?
                                    FutureBuilder<Translation>(
                                      future: translator.translate("${chindex == false?dayindex.gulikaKaal:nightindex.gulikaKaal}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              snapshot.data!.text,
                                              style: font_style.Black_bold_15_ff
                                          );
                                        } else {
                                          return  Text("${chindex == false?dayindex.gulikaKaal:nightindex.gulikaKaal}",  style: font_style.Black_bold_15_ff);
                                        }
                                      },
                                    ):
                                    // Text("${chindex == false?dayindex.gulikaKaal:nightindex.gulikaKaal}", style: font_style.Black_bold_15_ff,):SizedBox(),
                                    chindex == false&& dayindex.rahuKaal !="0"?
                                    FutureBuilder<Translation>(
                                      future: translator.translate("${chindex == false?dayindex.rahuKaal:nightindex.rahuKaal}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              snapshot.data!.text,
                                              style: font_style.Black_bold_15_ff
                                          );
                                        } else {
                                          return  Text("${chindex == false?dayindex.rahuKaal:nightindex.rahuKaal}",  style: font_style.Black_bold_15_ff);
                                        }
                                      },
                                    ):SizedBox()
                                    // Text("${chindex == false?dayindex.rahuKaal:nightindex.rahuKaal}", style: font_style.Black_bold_15_ff,):SizedBox(),
                                  ],
                                ),
                              )
                            )
                          ],
                        ),
                      );


                    },
                    // separatorBuilder: (context, index) {
                    //   return SizedBox(height: Get.height*0.020,);
                    // },
                  ),
                )

              ],
            ),
          ),
          )
        )
    );
  }


  List DateLineList =[
    "Date",
    "Sunrise",
    "Tithi",
    "Nakshatra",
    "Yoga",
    "Karan",
    "Rashi",
    "Rahukaal",
    "Gandmool",
    "Panchak",
    "Festival",
    "Yamangandamkal",
    "Bhadra",
    "Choughadia",
    "Change Date",
    "Change City",
    "Festivals",
    "Hora",
    "Daily Predictions",
    "Weekly Prediction",
    "Monthly Prediction",
    "know About Yourself>>",
    ""
  ];

  List dayList = [
    "Chal",
    "Labh",
    "Amrut",
    "Kal",
    "Shubh",
    "Rog",
    "Udveg",
    "Chal",
  ];

  List nightList = [
    "Rog",
    "Kal",
    "Labh",
    "Udveg",
    "Shubh",
    "Amrut",
    "Chal",
    "Rog",
  ];

  List daytimeList = [
    "07:36 to 08:18",
    "08:36 to 10:18",
    "10:36 to 12:18",
    "12:36 to 14:18",
    "14:36 to 16:18",
    "16:36 to 18:18",
    "18:36 to 20:18",
    "20:36 to 22:18",
  ];
  List nighttimeList = [
    "00:36 to 02:18",
    "02:36 to 04:18",
    "04:36 to 06:18",
    "06:36 to 08:18",
    "08:36 to 10:18",
    "10:36 to 12:18",
    "12:36 to 14:18",
    "14:36 to 16:18",
  ];

  List SurriseLineList =[
    "5-6-2023   (Wednesday)",
    "Sunrise: 05:50 Sunset: 19:23",
    "Chaturdashi till 19:57\n Krishna Praksha",
    "Kritika till 21:18",
    "Sakarma till 24:36",
    "Vishit til 08:25/Sakuma",
    "Rashi: Tourus",
    "12:36 to 14:18",
    "No",
    "No",
    "No",
    "07:33 to 09:14",
    "Bhardra to 08:59"
  ];
}
