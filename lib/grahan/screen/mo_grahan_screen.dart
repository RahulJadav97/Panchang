import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/grahan/controller/grahan_controller.dart';
import 'package:translator/translator.dart';

import '../../common/common_colour.dart';
import '../../panchang/screen/panchang_screen.dart';

class MonGrahanScreen extends StatefulWidget {
  final String year;
   MonGrahanScreen({super.key , required this.year});

  @override
  State<MonGrahanScreen> createState() => _MonGrahanScreenState();
}

class _MonGrahanScreenState extends State<MonGrahanScreen> {
  final translator = GoogleTranslator();
  var grahan = Get.put(GrahanController());
  List<int> colo = [
    0xff8E24AA,
    0xff2E7D32,
    0xfff21905,
    0xff1b567a,
    0xffaf69db,
    0xff0db9db,
    0xff1b567a,
    0xff1b567a,
    0xff2E7D32,
    0xfff21905,
    0xff1b567a,
    0xffaf69db,
  ];

  List<String> yearss = [
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030",
  ];
  var month = "2024";
  var currentY ;

  void initState() {
    super.initState();
    DateTime dateTime = DateFormat("dd-MM-yyyy").parse(widget.year.toString());
    int year = dateTime.year;
    currentY = year.toString();
    grahan.grahanCont("$year");
  }
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
                    future: translator.translate("Monthly Eclipse", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                            snapshot.data!.text,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)
                        );
                      } else {
                        return   Text("Monthly Eclipse", style:font_style.White_700_18_ff ,);
                      }
                    },
                  ),
                  // Text("Monthly Eclipse", style:font_style.White_700_18_ff ,),

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
                        itemCount: yearss.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap:()async{
                                    setState(() {
                                      month = yearss[index];
                                      grahan.grahanCont("${yearss[index]}");
                                    });
                                    // monthFestival.monthlyFestivalCont(monthListNo);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
                                    height: Get.height*0.060,
                                    width: Get.width*0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:Color(colo[index])
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text("${yearss[index]} :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),textAlign: TextAlign.center ),
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
                              child: Text("$month", style: font_style.Black_400_15_ff,),
                            ),
                          ),
                          SizedBox(height: Get.height*0.02,),
                          Obx(() => grahan.loading.value?Center(child: CircularProgressIndicator(color: common_red,),):
                          Container(
                            height: Get.height*0.8,
                            // color: Colors.blue,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:grahan.grahanList.length,
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
                                                  future: translator.translate("${grahan.grahanList[index].title}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                          snapshot.data!.text,
                                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)
                                                      );
                                                    } else {
                                                      return    Text('${grahan.grahanList[index].title}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white));
                                                    }
                                                  },
                                                ),
                                                // Text('${grahan.grahanList[index].title}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)),
                                                FutureBuilder<Translation>(
                                                  future: translator.translate("Date: ${grahan.grahanList[index].date}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                          snapshot.data!.text,
                                                          style: TextStyle(fontSize: 15,color: Colors.white)
                                                      );
                                                    } else {
                                                      return     Text('Date: ${grahan.grahanList[index].date}',style: TextStyle(fontSize: 15,color: Colors.white));
                                                    }
                                                  },
                                                ),
                                                // Text('Date: ${grahan.grahanList[index].date}',style: TextStyle(fontSize: 15,color: Colors.white)),
                                                SizedBox(height: Get.height*0.015,),
                                                InkWell(
                                                  onTap: (){
                                                    Get.defaultDialog(
                                                      title: "Description",
                                                      titleStyle: TextStyle(color: common_red),
                                                      content: Container(
                                                        height: Get.height * 0.8,
                                                        width: Get.width,
                                                        child: SingleChildScrollView(
                                                            scrollDirection: Axis.vertical,
                                                            child:
                                                            FutureBuilder<Translation>(
                                                              future: translator.translate("${grahan.grahanList[index].description}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                                              builder: (context, snapshot) {
                                                                if (snapshot.hasData) {
                                                                  return Text(
                                                                      snapshot.data!.text,
                                                                    style: TextStyle(
                                                                      color: common_red,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                    "${grahan.grahanList[index].description}",
                                                                    style: TextStyle(
                                                                      color: common_red,
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                            // Text(
                                                            //   "${grahan.grahanList[index].description}",
                                                            //   style: TextStyle(
                                                            //     color: common_red,
                                                            //   ),
                                                            // )
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                    child:
                                                    FutureBuilder<Translation>(
                                                      future: translator.translate("Know More", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                                      builder: (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                              snapshot.data!.text,
                                                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)
                                                          );
                                                        } else {
                                                          return Text('Know More',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white));
                                                        }
                                                      },
                                                    ),
                                                    // Text('Know More',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white))
                                                ),

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
