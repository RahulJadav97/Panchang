import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:panchang/Hora/screen/hora_screen.dart';
import 'package:panchang/Panchang_Model_controller/Controller/PanchanGController.dart';
import 'package:panchang/Predictions/screen/MonthlyPredictionScreen.dart';
import 'package:panchang/Predictions/screen/WeeklyPredictionScreen.dart';
import 'package:panchang/Predictions/screen/dailyPredictionScreen.dart';
import 'package:panchang/Significance/screen/Significance_screen.dart';
import 'package:panchang/changecity/screen/changecity_screen.dart';
import 'package:panchang/chaughadia/screen/chaughadia_screen.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/festivals/controller/festival_date_controller.dart';
import 'package:panchang/festivals/screen/festival_web_view.dart';
import 'package:panchang/festivals/screen/festivals.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/standalone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
// import 'package:timezone/data/latest.dart' as tz;




class PanchangScreen extends StatefulWidget {

  String ?date;
  String ?dayname;

  PanchangScreen({
    this.date,
    this.dayname,

  }); // const PanchangScreen({super.key});

  @override
  State<PanchangScreen> createState() => _PanchangScreenState();
}

class _PanchangScreenState extends State<PanchangScreen> {




  // Position? _currentlocation;
  late bool servicePermission=false;
  // late LocationPermission Permission;
  String currentAddress = '';



  String dd="";
  String mm="";
  String yy="";
  String popupDatepicker="";
  String mycity="";
  String subcat="";
  String LatDeg="";
  String LatMin="";
  String LonDeg="";
  String LonMin="";
  String East="";
  String ZHour="";
  String ZMin="";
  String DST="";
  String WAR="";
  String Hour="";
  String Min="";
  String txtnm="";
  String Day="";
  String Month="";
  String Year="";
  String Asc="";
  String Asc2="";
  String AYNS="";
  String as="";
  String moon="";

  String? currentdate;
  String? currentdatedayname;
  String? currentCityName;

  Future<void> getSaharedDateData() async {

    SharedPreferences sh = await SharedPreferences.getInstance();
    currentdate = sh.getString("sh_selectedDate");
    currentdatedayname =sh.getString("sh_selectedDayName");
    currentCityName =sh.getString("sh_selectedCity");

    print("==============================================Panchang Page getSaharedDateData===============================================");

    print("currentdate :$currentdate");
    print("currentdatedayname :$currentdatedayname");
    print("currentCityName :$currentCityName");

    print("sh_selectedDate :${sh.getString("sh_selectedDate")}");
    print("sh_selectedDayName :${sh.getString("sh_selectedDayName")}");
    print("sh_selectedDay :${sh.getString("sh_selectedDay")}");
    print("sh_selectedMonth :${sh.getString("sh_selectedMonth")}");
    print("sh_selectedYear :${sh.getString("sh_selectedYear")}");
    print("sh_selectedCity :${sh.getString("sh_selectedCity")}");

    print("==============================================Panchang Page getSaharedDateData===============================================");

  }

  PanchangController _panchangController_obj = Get.put(PanchangController());
  FestivalDateList festivalDate = Get.put(FestivalDateList());



  BackWordUpdateDate() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String dateString = "${sh.getString("sh_selectedDate")}";
    // String dateString = "21-12-2023";
    List<String> dateParts = dateString.split('-');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    DateTime date = DateTime(year, month, day);
    var selectedDate = date.subtract(Duration(days: 1));

    String datex = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    String dayName = getDayName(selectedDate.year, selectedDate.month, selectedDate.day);

    sh.setString("sh_selectedDate", datex.toString());
    sh.setString("sh_selectedDayName", dayName.toString());
    sh.setString("sh_selectedDay", selectedDate.day.toString());
    sh.setString('sh_selectedMonth', selectedDate.month.toString());
    sh.setString('sh_selectedYear', selectedDate.year.toString());

    print("==============================================BackWordupdateDate open===============================================");

    print("sh_selectedDate :${sh.getString("sh_selectedDate")}");
    print("sh_selectedDayName :${sh.getString("sh_selectedDayName")}");
    print("sh_selectedDay :${sh.getString("sh_selectedDay")}");
    print("sh_selectedMonth :${sh.getString("sh_selectedMonth")}");
    print("sh_selectedYear :${sh.getString("sh_selectedYear")}");

    currentdate = sh.getString("sh_selectedDate");
    currentdatedayname = sh.getString("sh_selectedDayName");

    print("==============================================BackWordupdateDate Close===============================================");
    setState(() {
      _panchangController_obj.panchangCont(popupDatepicker, mycity, subcat, LatDeg, LatMin, LonDeg, LonMin, East, ZHour, ZMin, DST, WAR, Hour, Min, txtnm, Day, Month, Year, Asc, Asc2, AYNS, as, moon).then((value) => festivalDate.festivalDateCont());
    });
}

  ForwordUpdateDate() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String dateString = "${sh.getString("sh_selectedDate")}";
    // String dateString = "21-12-2023";
    List<String> dateParts = dateString.split('-');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    DateTime date = DateTime(year, month, day);
    var selectedDate = date.add(Duration(days: 1));

    String datex = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    String dayName = getDayName(selectedDate.year, selectedDate.month, selectedDate.day);

    sh.setString("sh_selectedDate", datex.toString());
    sh.setString("sh_selectedDayName", dayName.toString());
    sh.setString("sh_selectedDay", selectedDate.day.toString());
    sh.setString('sh_selectedMonth', selectedDate.month.toString());
    sh.setString('sh_selectedYear', selectedDate.year.toString());

    print("==============================================ForwordUpdateDate open===============================================");

    print("sh_selectedDate :${sh.getString("sh_selectedDate")}");
    print("sh_selectedDayName :${sh.getString("sh_selectedDayName")}");
    print("sh_selectedDay :${sh.getString("sh_selectedDay")}");
    print("sh_selectedMonth :${sh.getString("sh_selectedMonth")}");
    print("sh_selectedYear :${sh.getString("sh_selectedYear")}");


    currentdate = sh.getString("sh_selectedDate");
    currentdatedayname = sh.getString("sh_selectedDayName");

    print("==============================================ForwordUpdateDate Close===============================================");

    setState(() {
      _panchangController_obj.panchangCont(popupDatepicker, mycity, subcat, LatDeg, LatMin, LonDeg, LonMin, East, ZHour, ZMin, DST, WAR, Hour, Min, txtnm, Day, Month, Year, Asc, Asc2, AYNS, as, moon).then((value) => festivalDate.festivalDateCont());
    });
  }

  ChangeDate() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String dateString = "${sh.getString("sh_selectedDate")}";
    // String dateString = "21-12-2023";
    List<String> dateParts = dateString.split('-');
    int day = int.parse(selectedDateX!.day.toString().padLeft(2, '0'));
    int month = int.parse(selectedDateX!.month.toString().padLeft(2, '0'));
    int year = int.parse(selectedDateX!.year.toString());

    DateTime date = DateTime(year, month, day);
    var selectedDate = date;

    String datex = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    String dayName = getDayName(selectedDate.year, selectedDate.month, selectedDate.day);

    sh.setString("sh_selectedDate", datex.toString());
    sh.setString("sh_selectedDayName", dayName.toString());
    sh.setString("sh_selectedDay", selectedDate.day.toString());
    sh.setString('sh_selectedMonth', selectedDate.month.toString());
    sh.setString('sh_selectedYear', selectedDate.year.toString());

    print("==============================================ForwordUpdateDate open===============================================");

    print("sh_selectedDate :${sh.getString("sh_selectedDate")}");
    print("sh_selectedDayName :${sh.getString("sh_selectedDayName")}");
    print("sh_selectedDay :${sh.getString("sh_selectedDay")}");
    print("sh_selectedMonth :${sh.getString("sh_selectedMonth")}");
    print("sh_selectedYear :${sh.getString("sh_selectedYear")}");


    currentdate = sh.getString("sh_selectedDate");
    currentdatedayname = sh.getString("sh_selectedDayName");

    print("==============================================ForwordUpdateDate Close===============================================");

    setState(() {
      _panchangController_obj.panchangCont(popupDatepicker, mycity, subcat, LatDeg, LatMin, LonDeg, LonMin, East, ZHour, ZMin, DST, WAR, Hour, Min, txtnm, Day, Month, Year, Asc, Asc2, AYNS, as, moon).then((value) => festivalDate.festivalDateCont());
    });
  }


  @override
  void initState() {
    getSaharedDateData().then((value){
      _panchangController_obj.panchangCont(popupDatepicker, mycity, subcat, LatDeg, LatMin, LonDeg, LonMin, East, ZHour, ZMin, DST, WAR, Hour, Min, txtnm, Day, Month, Year, Asc, Asc2, AYNS, as, moon);
    }).then((value) => festivalDate.festivalDateCont());
    
    // getSaharedDateData();
    // setup();
    // _determinePosition();
    // getPosition();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    super.initState();
  }
  var ddd  = "";
  var mmm = "" ;
  var yyy = "" ;
  getdelhiData() async {
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
  bool panchagePageStatus = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: common_backcolor,
          body: Obx(() {
            return SingleChildScrollView(
              child: Container(
                // height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                // color: Colors.red,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.020),
                      height: SizeConfig.screenHeight*0.050,
                      width: SizeConfig.screenWidth,
                      color: Colors.grey.shade700,
                      alignment: Alignment.centerLeft,
                      child: Text("Panchang", style:font_style.White_700_18_ff ,),

                    ),
                    _panchangController_obj.loading.value
                        ?
                    Center(
                      child: Container(
                        height: SizeConfig.screenHeight*0.92,
                        width: SizeConfig.screenWidth,
                        // color: Colors.blue,
                        // color: Colors.white54.withOpacity(0.4),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(color: common_red,),
                      ),
                    )
                        :
                    Center(
                      child: Container(
                        // color: Colors.purple,
                        width: SizeConfig.screenWidth*0.97,
                        child: Column(
                          children: [

                            // Panchang container
                            Container(
                              child:Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          BackWordUpdateDate();
                                        },
                                        child: Container(
                                          height: SizeConfig.screenHeight*0.070,
                                          width: SizeConfig.screenWidth*0.110,
                                          decoration: const BoxDecoration(
                                              color: Color(0xffcb1505),
                                              shape: BoxShape.circle
                                          ),
                                          alignment: Alignment.center,
                                          child: Text("<<", style:TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),),
                                        ),
                                      ),
                                      SizedBox(width: SizeConfig.screenWidth*0.010,),
                                      Container(
                                        height: SizeConfig.screenHeight*0.050,
                                        width: SizeConfig.screenWidth*0.6,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade900,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.red, width: 1),
                                            boxShadow: const [
                                              BoxShadow(
                                                  blurRadius: 5,
                                                  color: Colors.red,
                                                  spreadRadius: 1.0,
                                                  offset: Offset(0.0, 0.0)
                                              )
                                            ]
                                        ),

                                        child: Text("Panchang", style: font_style.white_bold_20_ff,),

                                      ),
                                      SizedBox(width: SizeConfig.screenWidth*0.010,),
                                      InkWell(
                                        onTap: (){
                                          ForwordUpdateDate();
                                        },
                                        child: Container(
                                          height: SizeConfig.screenHeight*0.070,
                                          width: SizeConfig.screenWidth*0.110,
                                          decoration: BoxDecoration(
                                              color: Color(0xffcb1505),
                                              shape: BoxShape.circle
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(">>", style:TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: SizeConfig.screenHeight*0.05,
                                      // height: SizeConfig.screenHeight*0.020,
                                      decoration: BoxDecoration(
                                          color: Color(0xffcb1505),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                      child: Text("Place: ${currentCityName}", style:font_style.white_400_11 ,),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.020,),

                            //date
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFFb36307),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Date:",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Container(
                                      height: SizeConfig.screenHeight*0.065,
                                      width: SizeConfig.screenWidth*0.650,
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
                                      alignment: Alignment.center,
                                      child: Text("$currentdate ($currentdatedayname)", style: font_style.Black_bold_15_ff,),

                                    );
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Sunrise
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFF04d479),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Sunrise:",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                ),
                                Container(
                                  height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text("Sunrise ${_panchangController_obj.sunrise}", style: font_style.Black_bold_15_ff,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),
                            // Sunset
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFFf505d1),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Sunset:",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                ),
                                Container(
                                  height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text("Sunset ${_panchangController_obj.sunset}", style: font_style.Black_bold_15_ff,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),


                            // Moonrise

                            _panchangController_obj.moonrise != "0"?
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                      height: SizeConfig.screenHeight*0.060,
                                      width: SizeConfig.screenWidth*0.310,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:Color(0XFF0394fc),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text("Moonrise:",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                    ),
                                    Container(
                                      height: SizeConfig.screenHeight*0.065,
                                      width: SizeConfig.screenWidth*0.650,
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
                                      alignment: Alignment.center,
                                      child: Text("Moonrise ${_panchangController_obj.moonrise}", style: font_style.Black_bold_15_ff,),

                                    )
                                  ],
                                ),
                                SizedBox(height: SizeConfig.screenHeight*0.010,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                      height: SizeConfig.screenHeight*0.060,
                                      width: SizeConfig.screenWidth*0.310,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:Color(0XFFf57105),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text("Moonset:",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                    ),
                                    Container(
                                      height: SizeConfig.screenHeight*0.065,
                                      width: SizeConfig.screenWidth*0.650,
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
                                      alignment: Alignment.center,
                                      child: Text("Moonset ${_panchangController_obj.moonset}", style: font_style.Black_bold_15_ff,),

                                    )
                                  ],
                                ),
                                SizedBox(height: SizeConfig.screenHeight*0.010,),
                              ],
                            ):Container(),

                            // //Moonrise
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                            //       height: SizeConfig.screenHeight*0.060,
                            //       width: SizeConfig.screenWidth*0.310,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10),
                            //         color:common_red,
                            //       ),
                            //       alignment: Alignment.centerLeft,
                            //       child: Text("Moonrise:",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                            //     ),
                            //     Container(
                            //       height: SizeConfig.screenHeight*0.065,
                            //       width: SizeConfig.screenWidth*0.650,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(10),
                            //           color: Color(0XFFfedec5),
                            //           border: Border.all(color: common_red, width: 1),
                            //           boxShadow: const [
                            //             BoxShadow(
                            //                 blurRadius: 1,
                            //                 color: Color(0XFFbe765a),
                            //                 spreadRadius: 1.0,
                            //                 offset: Offset(0.0, 2.0)
                            //             )
                            //           ]
                            //       ),
                            //       alignment: Alignment.center,
                            //       child: Text(" Moonrise 11:11 Moonset 24:24", style: font_style.Black_bold_15_ff,),
                            //
                            //     )
                            //   ],
                            // ),
                            // SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Vikram Samwat
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFFBE2E2E),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Vikrami Samwat:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.vikramSamvat.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Shaka Samvat
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF447eeb),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Shaka Samwat:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.shakaSamvat.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Tithi
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFFb402c4),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Tithi :",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.tithi.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Nakshatra
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF205D25),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Nakshatra :",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.nakshatra.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Yoga
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF503A34),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Yoga:",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.yoga.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Karan
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF2173C2),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Karan:",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.karan.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Rashi
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF225E27),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Rashi:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.rashi!.replaceAll("Rashi: ", "").toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Maas
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color:Colors.purple,
                                      color:Color(0XFFBB3030)
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Mass:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.mass.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Ritu
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFF311B92)
                                    // color:Colors.blue.shade700,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Ritu:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify,  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.ritu.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Panchak
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:  Color(0xFFdb07b8)
                                    // color:CupertinoColors.activeGreen,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Panchak:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.panchak.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFF06cc09),
                                    // color:CupertinoColors.activeGreen,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Gandmool:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.gandmool.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Disha shool
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:  Color(0xFFB71C1C),
                                    // color:Colors.deepOrange,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Disha shool:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.dishaShool.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Festival
                            GestureDetector(
                              onTap: (){
                                // Get.to(()=>FestivalWebScreen(webUrl: "https://festivals.premastrologer.com/",));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                    height: SizeConfig.screenHeight*0.060,
                                    width: SizeConfig.screenWidth*0.310,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0xFF7F2F93),
                                      // color:Color(0xff1b567a),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text("Festival:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                    // height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
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
                                    alignment: Alignment.center,
                                    child:Obx(() => festivalDate.loading1.value?Center(child: CircularProgressIndicator(color: common_red,),):
                                    festivalDate.oldResponse.value.data!.isEmpty?
                                    Text(" No Festival", style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,):
                                    Container(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: festivalDate.oldResponse.value.data!.length,
                                          itemBuilder:(BuildContext context,int indexx) {
                                            return InkWell(
                                                onTap: (){
                                                  Get.to(()=>FestivalWebScreen(webUrl: "${festivalDate.oldResponse.value.data![indexx].link}",));
                                                },
                                                child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Column(
                                                      children: [
                                                        Text("${festivalDate.oldResponse.value.data![indexx].title?.trim()??"No Festival"}", style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),
                                                        festivalDate.oldResponse.value.data!.length ==1?SizedBox(): Divider(color: common_red,thickness: 3,)
                                                      ],
                                                    )));
                                          }
                                      ),
                                    ),
                                    )
                                    // Text(_panchangController_obj.fastival.toString().isEmpty?" No Festival":_panchangController_obj.fastival.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Bhadra
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:  Color(0xFF7F2F55),
                                    // color:Color(0xff654a24),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Bhadra:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.Bhadra.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),


                            SizedBox(height: SizeConfig.screenHeight*0.015,),
                            /// Inauspicious Period
                            Row(
                              children: [
                                Container(
                                  height: SizeConfig.screenHeight*0.050,
                                  width: SizeConfig.screenWidth*0.5,
                                  decoration: BoxDecoration(
                                      color: Color(0XFFfc051e),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Inauspicious Period:", style: font_style.Black_500_18_ff,),
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Rahu
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF0511f7),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Rahukaal:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.rahu_kaal.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Yamaganda
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF7F2F11),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Yamagandam:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.yamagamdam.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Gulika
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                  height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:  Color(0xFFfa05ee),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Gulika kaal:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                  // height: SizeConfig.screenHeight*0.065,
                                  width: SizeConfig.screenWidth*0.650,
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
                                  alignment: Alignment.center,
                                  child: Text(_panchangController_obj.gulikaKaal.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Dur Muhurat
                            _panchangController_obj.durMuhurat != "0"?
                           Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                     padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                                     height: SizeConfig.screenHeight*0.060,
                                     width: SizeConfig.screenWidth*0.310,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       color: Color(0xFF7F5F22),
                                     ),
                                     alignment: Alignment.centerLeft,
                                     child: Text("Dur Muhurat:",style: font_style.White_700_17_ff,textAlign: TextAlign.center ),
                                   ),
                                   Container(
                                     padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.015),
                                     // height: SizeConfig.screenHeight*0.065,
                                     width: SizeConfig.screenWidth*0.650,
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
                                     alignment: Alignment.center,
                                     child: Text(_panchangController_obj.durMuhurat.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),

                                   )
                                 ],
                               ),

                               SizedBox(height: SizeConfig.screenHeight*0.015,),
                             ],
                           ) :Container(),
                            // //Varjyam
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.010, ),
                            //       height: SizeConfig.screenHeight*0.060,
                            //       width: SizeConfig.screenWidth*0.310,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10),
                            //         color:common_red,
                            //       ),
                            //       alignment: Alignment.centerLeft,
                            //       child: Text("Varjyam:",style: font_style.White_700_17_ff,textAlign: TextAlign.justify ),
                            //     ),
                            //     Container(
                            //       height: SizeConfig.screenHeight*0.065,
                            //       width: SizeConfig.screenWidth*0.650,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(10),
                            //           color: Color(0XFFfedec5),
                            //           border: Border.all(color: common_red, width: 1),
                            //           boxShadow: const [
                            //             BoxShadow(
                            //                 blurRadius: 1,
                            //                 color: Color(0XFFbe765a),
                            //                 spreadRadius: 1.0,
                            //                 offset: Offset(0.0, 2.0)
                            //             )
                            //           ]
                            //       ),
                            //       alignment: Alignment.center,
                            //       child: Text("15:43 – 05:29 ", style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,),
                            //
                            //     )
                            //   ],
                            // ),
                            //
                            // SizedBox(height: SizeConfig.screenHeight*0.010,),




                            // Chughadia
                            InkWell(
                              onTap: () {
                                Get.to( ChaughadiaScreen(date: currentdate.toString(),));
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: Colors.purple, width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Colors.purple,
                                    ),
                                    child: Text("Chaughadiya",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            // Change Date
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _changeDate();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: Colors.green, width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Colors.green,
                                    ),
                                    child: Text("Change Date",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),


                            // Change City
                            InkWell(
                              onTap: (){
                                setState(() {
                                  Get.to(const ChangeCityScreen());
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: common_red, width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:common_red,
                                    ),
                                    child: Text("Change City",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Festivals
                            InkWell(
                              onTap: () => Get.to(FestivalsScreen()),
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: Color(0xff1b567a), width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Color(0xff1b567a),
                                    ),
                                    child: Text("Festivals",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Hora
                            InkWell(
                              onTap: (){
                                Get.to(const HoraScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: Color(0xff463458), width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Color(0xff463458),
                                    ),
                                    child: Text("Hora",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Significance
                            InkWell(
                              onTap: () {
                                Get.to(()=>SignificanceScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: Colors.purpleAccent, width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Colors.purpleAccent,
                                    ),
                                    child: Text("Significance",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Daily Predictions
                            InkWell(
                              onTap: (){
                                Get.to(DailyPredictionScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: Color(0xff1b567a), width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Color(0xff1b567a),
                                    ),
                                    child: Text("Daily Predictions",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Weekly Predictions
                            InkWell(
                              onTap: (){
                                Get.to(WeeklyPredictionScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: Color(0xff654a24), width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Color(0xff654a24),
                                    ),
                                    child: Text("Weekly Predictions",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Monthly Predictions
                            InkWell(
                              onTap: (){
                                Get.to(MonthlyPredictionScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: common_red, width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:common_red,
                                    ),
                                    child: Text("Monthly Predictions",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
                              ),
                            ),

                            //know About Yourself>>
                            GestureDetector(
                              onTap: (){
                                Get.to(()=>FestivalWebScreen(webUrl: "https://www.premastrologer.com",));
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.040),
                                  height: SizeConfig.screenHeight*0.040,
                                  width: SizeConfig.screenWidth,
                                  alignment: Alignment.center,
                                  decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:Color(0xff980101),
                                  ),
                                  child: Text("know About Yourself>>",style: font_style.white_600_15_cl,textAlign: TextAlign.center, )
                              ),
                            ),

                            //Client info
                            Container(
                                height: SizeConfig.screenHeight*0.150,
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
                                      width: SizeConfig.screenWidth*0.250,
                                      color: Colors.red,
                                      child: Image.asset("assets/images/cilent_panchang.png", fit: BoxFit.cover,),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: SizeConfig.screenHeight,

                                      color: Colors.black,
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: SizeConfig.screenHeight*0.020,),
                                          Text("Reach us at:",style: font_style.White_700_17_ff,textAlign: TextAlign.center, ),
                                          SizedBox(height: SizeConfig.screenHeight*0.010,),

                                          InkWell(
                                            onTap: (){
                                              Get.to(()=>FestivalWebScreen(webUrl: "https://www.premastrologer.com/",));
                                            },
                                              child: Text("www.premastrologer.com",style: font_style.White_700_17_ff,textAlign: TextAlign.center, )),
                                          SizedBox(height: SizeConfig.screenHeight*0.010,),

                                          InkWell(
                                            onTap: (){
                                              redirectToGmail();
                                            },
                                              child: Text("psharma@premastrologer.com",style: font_style.White_700_17_ff,textAlign: TextAlign.center, )),


                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                )),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),



                          ],
                        ),
                      ),
                    )




                  ],
                ),
              ),
            );
          }),






        )
    );
  }


  DateTime? selectedDateX;
  String? selectedDate;
  String?formattedDate;


  Future<void> _changeDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateX,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateX) {
      setState(() {
        selectedDateX = picked;
        formattedDate = "${selectedDateX!.day.toString().padLeft(2, '0')}-${selectedDateX!.month.toString().padLeft(2, '0')}-${selectedDateX!.year}";
        // formattedDate = "${selectedDateX!.year}-${selectedDateX!.month.toString().padLeft(2, '0')}-${selectedDateX!.day.toString().padLeft(2, '0')}";
        selectedDate = formattedDate ;
        print("selectedDateX :$selectedDate");
        ChangeDate();
      });
    }
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


  // /// --------- current location ----------------///
  //
  // Future<Position> _determinePosition() async {
  //   print("current location call");
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   return await Geolocator.getCurrentPosition();
  // }
  //
  //
  // Future<void> getPosition() async {
  //   // Get the current position
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   await GetAddressFromLatLong(position);
  // }
  //
  // var ltd ;
  // var long;
  // var Address;
  // Future<void> GetAddressFromLatLong(Position position) async {
  //   setState(() {
  //     ltd =  position.latitude;
  //     long =  position.longitude;
  //   });
  //   timezoneName();
  //   double latitude = position.latitude;
  //   double longitude = position.longitude;
  //
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //
  //   List<Placemark> placemarks = await placemarkFromCoordinates(
  //     position.latitude,
  //     position.longitude,
  //   );
  //
  //   print(placemarks);
  //   Placemark place = placemarks[0];
  //   setState(() {
  //     Address = '${place.locality}';
  //     sh.setString("sh_selectedCity", Address.toString());
  //     print("Address: $Address");
  //   });
  //
  //   // Extract latitude degrees and minutes
  //   int latitudeDegrees = latitude.floor();
  //   double latitudeMinutes = (latitude - latitudeDegrees) * 60;
  //
  //   // Extract longitude degrees and minutes
  //   int longitudeDegrees = longitude.floor();
  //   double longitudeMinutes = (longitude - longitudeDegrees) * 60;
  //
  //   sh.setString("sh_selectedLtd", latitude.toString());
  //   sh.setString("sh_selectedLtdDeg", latitudeDegrees.toString());
  //   sh.setString("sh_selectedLtdMin", latitudeMinutes.toString());
  //
  //   sh.setString("sh_selectedLong", longitude.toString());
  //   sh.setString("sh_selectedLongDeg", longitudeDegrees.toString());
  //   sh.setString("sh_selectedLongMin", longitudeMinutes.toString());
  //
  //   print("==============================================GetAddressFromLatLong open ================================");
  //   print("sh_selectedCity : ${sh.getString("sh_selectedCity")}");
  //
  //   print("sh_selectedLtd : ${sh.getString("sh_selectedLtd")}");
  //   print("sh_selectedLtdDeg : ${sh.getString("sh_selectedLtdDeg")}");
  //   print("sh_selectedLtdMin : ${sh.getString("sh_selectedLtdMin")}");
  //
  //   print("sh_selectedLong : ${sh.getString("sh_selectedLong")}");
  //   print("sh_selectedLongDeg : ${sh.getString("sh_selectedLongDeg")}");
  //   print("sh_selectedLongMin : ${sh.getString("sh_selectedLongMin")}");
  //   print("==============================================GetAddressFromLatLong close ================================");
  // }
  //
  // var tzName;
  // timezoneName(){
  //   print(ltd);
  //   String tz = tzmap.latLngToTimezoneString(ltd,long);
  //   setState(() {
  //     tzName = tz;
  //     setup();
  //   });
  //   print('Montreal is in the $tz time zone.');
  //
  //
  // }
  // String? realTimeZon;
  // var timeZoneMin;
  // var timeZoneHour;
  // Future<void> setup() async {
  //   var londonLocation = tz.getLocation(tzName.toString());
  //   print("londonLocation $londonLocation");
  //   var nowInLondon = tz.TZDateTime.now(londonLocation);
  //   print("minute${nowInLondon.minute}");
  //   print("hour${nowInLondon.hour}");
  //   // print(nowInLondon.hour);
  //
  //   setState(() {
  //     realTimeZon = nowInLondon.toString();
  //     timeZoneMin = nowInLondon.minute;
  //     timeZoneHour = nowInLondon.hour;
  //   });
  //
  //   print("==============================================setup open ================================");
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   sh.setString("sh_selectedZHour", timeZoneHour.toString());
  //   sh.setString("sh_selectedZMin", timeZoneMin.toString());
  //
  //   print("sh_selectedZHour : ${sh.getString("sh_selectedZHour")}");
  //   print("sh_selectedZMin : ${sh.getString("sh_selectedZMin")}");
  //   print("==============================================setup Close ================================");
  //
  // }
}


String getDayName(int year, int month, int day) {
  if (month < 3) {
    month += 12;
    year -= 1;
  }

  int h = (day + ((13 * (month + 1)) ~/ 5) + year + (year ~/ 4) - (year ~/ 100) + (year ~/ 400)) % 7;

  switch (h) {
    case 0:
      return "Saturday";
    case 1:
      return "Sunday";
    case 2:
      return "Monday";
    case 3:
      return "Tuesday";
    case 4:
      return "Wednesday";
    case 5:
      return "Thursday";
    case 6:
      return "Friday";
    default:
      return "";
  }
}

