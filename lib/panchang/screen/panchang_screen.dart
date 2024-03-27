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
import 'package:panchang/Significance/screen/month_significance.dart';
import 'package:panchang/changecity/screen/changecity_screen.dart';
import 'package:panchang/chaughadia/screen/chaughadia_screen.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/festivals/controller/festival_date_controller.dart';
import 'package:panchang/festivals/screen/festival_web_view.dart';
import 'package:panchang/festivals/screen/festivals.dart';
import 'package:panchang/grahan/screen/grahan_screen.dart';
import 'package:panchang/grahan/screen/mo_grahan_screen.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/standalone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
// import 'package:timezone/data/latest.dart' as tz;




String? selectedLanguage; // Default language key

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


  final translator = GoogleTranslator();

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
    var selectedDate = date.add(Duration(days: 1,));

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


  final Map<String, String> languageKeys = {
    "Default Language": "klk",
    "Gujarati":"gu",
    "Hindi":"hi",
    "English": "klkj",
    "Telugu":"te",
    "Marathi":"mr",
    "Tamil":"ta",
    "Urdu":"ur",
    "Urdu":"ur",
    "Kannada": "kn",
    "Odia ": "or",
    "Malayalam": "ml",
    "Punjabi": "pa",
    "Assamese": "as",
    "Maithili": "mai",
    "Santali": "sat",
    "Kashmiri": "ks",
    "Nepali": "ne",
    "Konkani": "kok",
    "Sindhi": "sd",
    "Dogri ": "doi",
    "Bodo ": "brx",
    "Sanskrit ": "sa",
    "Bhojpuri ": "bho",
    "Magahi": "mag",
    "Awadhi": "awa",
    "Kokborok ": "trp",
    "Albanian": "sq",
    "Amharic": "am",
    "Arabic": "ar",
    "Armenian": "hy",
    "Azerbaijani": "az",
    "Basque": "eu",
    "Belarusian": "be",
    "Bengali": "bn",
    "Bosnian": "bs",
    "Bulgarian": "bg",
    "Catalan": "ca",
    "Cebuano": "ceb",
    "Chinese (Simplified)": "zh-CN",
    "Chinese (Traditional)": "zh-TW",
    "Corsican": "co",
    "Croatian": "hr",
    "Czech": "cs",
    "Danish": "da",
    "Dutch": "nl",
    "Esperanto": "eo",
    "Estonian": "et",
    "Finnish": "fi",

    // Add more languages as needed
  };

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
                      padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.020,right: SizeConfig.screenWidth*0.020),
                      height: SizeConfig.screenHeight*0.050,
                      width: SizeConfig.screenWidth,
                      color: Colors.blue,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Choose Language", style:font_style.White_700_18_ff ,),
                            DropdownButton<String>(
                              dropdownColor: Colors.blue,
                              value: selectedLanguage,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedLanguage = newValue!;
                                });
                              },
                              hint: Text('Select a language' ,style:font_style.White_700_18_ff ), // Set the hint text
                              items: languageKeys.keys.map<DropdownMenuItem<String>>((String key) {
                                return DropdownMenuItem<String>(

                                  value: languageKeys[key],
                                  child: Text(key,style:TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white,fontFamily: 'calibri'),
                                  ));
                              }).toList(),
                            ),


                          ],
                      )

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
                                  SizedBox(height: Get.height*0.010,),
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
                                          child: Text("<<", style:TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                                        ),
                                      ),
                                      SizedBox(width: SizeConfig.screenWidth*0.010,),
                                      Container(
                                        // height: SizeConfig.screenHeight*0.050,
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
                                        padding: EdgeInsets.all(Get.width*0.030),
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
                                          child: Text(">>", style:TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.010,),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      alignment: Alignment.center,
                                      // height: SizeConfig.screenHeight*0.05,
                                      // height: SizeConfig.screenHeight*0.020,
                                      decoration: BoxDecoration(
                                          color: Color(0xffcb1505),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: FutureBuilder<Translation>(
                                              future: translator.translate("Place: ${currentCityName}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    snapshot.data!.text,
                                                    style:font_style.white_400_11,
                                                  );
                                                } else {
                                                  return  Text("Place: ${currentCityName}", style:font_style.white_400_11 ,);
                                                }
                                              },
                                            ),
                                        ),
                                      ),
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
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  // height: SizeConfig.screenHeight*0.060,
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFFb36307),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child:FutureBuilder<Translation>(
                                    future: translator.translate("Date", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.center,
                                        );
                                      } else {
                                        return  Text("Date:",style: font_style.White_700_17_ff,textAlign: TextAlign.center );
                                      }
                                    },
                                  ),
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
                                      child: FutureBuilder<Translation>(
                                        future: translator.translate("$currentdate ($currentdatedayname)", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data!.text,
                                                style: font_style.Black_bold_15_ff,
                                            );
                                          } else {
                                            return   Text("$currentdate ($currentdatedayname)", style: font_style.Black_bold_15_ff,);
                                          }
                                        },
                                      ),

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
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFF04d479),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child:FutureBuilder<Translation>(
                                    future: translator.translate("Sunrise", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Sunrise:",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
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
                                  child:FutureBuilder<Translation>(
                                    future: translator.translate("Sunrise ${_panchangController_obj.sunrise}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.Black_bold_15_ff,
                                        );
                                      } else {
                                        return  Text("Sunrise ${_panchangController_obj.sunrise}", style: font_style.Black_bold_15_ff,);
                                      }
                                    },
                                  )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),
                            // Sunset
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFFf505d1),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Sunset", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Sunset:",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
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
                                  child:FutureBuilder<Translation>(
                                    future: translator.translate("Sunset ${_panchangController_obj.sunset}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.Black_bold_15_ff,
                                        );
                                      } else {
                                        return  Text("Sunset ${_panchangController_obj.sunset}", style: font_style.Black_bold_15_ff,);
                                      }
                                    },
                                  )

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
                                      padding: EdgeInsets.all(Get.height*0.008),
                                      constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                      width: SizeConfig.screenWidth*0.310,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:Color(0xFFf505d1),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: FutureBuilder<Translation>(
                                        future: translator.translate("Moonrise", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data!.text,
                                              style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                            );
                                          } else {
                                            return  Text("Moonrise:",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                          }
                                        },
                                      ),
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
                                        child:FutureBuilder<Translation>(
                                          future: translator.translate("Moonrise ${_panchangController_obj.moonrise}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!.text,
                                                style:font_style.Black_bold_15_ff,
                                              );
                                            } else {
                                              return  Text("Moonrise ${_panchangController_obj.moonrise}", style: font_style.Black_bold_15_ff,);
                                            }
                                          },
                                        )

                                    )
                                  ],
                                ),
                                SizedBox(height: SizeConfig.screenHeight*0.010,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(Get.height*0.008),
                                      constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                      width: SizeConfig.screenWidth*0.310,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:Color(0xFFf505d1),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: FutureBuilder<Translation>(
                                        future: translator.translate("Moonrise", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data!.text,
                                              style:font_style.White_700_17_ff,textAlign: TextAlign.center,
                                            );
                                          } else {
                                            return  Text("Moonrise:",style: font_style.White_700_17_ff,textAlign: TextAlign.center );
                                          }
                                        },
                                      ),
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
                                        child:FutureBuilder<Translation>(
                                          future: translator.translate("Moonrise ${_panchangController_obj.moonrise}", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!.text,
                                                style:font_style.Black_bold_15_ff,
                                              );
                                            } else {
                                              return  Text("Moonrise ${_panchangController_obj.moonrise}", style: font_style.Black_bold_15_ff,);
                                            }
                                          },
                                        )

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
                           /// vikaram samvat
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFFBE2E2E),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Vikrami Samwat:", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Vikrami Samwat:",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.vikramSamvat.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return  Text(_panchangController_obj.vikramSamvat.toString(), style: font_style.Black_bold_15_ff,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Shaka Samvat
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF447eeb),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Shaka Samwat:", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Shaka Samwat:",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.shakaSamvat.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return  Text(_panchangController_obj.shakaSamvat.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Tithi
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFFb402c4),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Tithi :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Tithi :",style: font_style.White_700_17_ff,textAlign: TextAlign.left);
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(Get.height*0.008),
                                    // height: SizeConfig.screenHeight*0.080,
                                    width: SizeConfig.screenWidth*0.650,
                                    constraints: BoxConstraints(
                                      minHeight: SizeConfig.screenHeight*0.080
                                    ),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.tithi.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return  Text(_panchangController_obj.tithi.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Nakshatra
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF205D25),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Nakshatra :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Nakshatra :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.nakshatra.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.nakshatra.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Yoga
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF503A34),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Yoga :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Yoga :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.yoga.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.yoga.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Karan
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF2173C2),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Karan :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Karan :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.karan.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.karan.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Rashi
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0XFF225E27),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Rashi :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.center,
                                        );
                                      } else {
                                        return  Text("Rashi :",style: font_style.White_700_17_ff,textAlign: TextAlign.center );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.rashi!.replaceAll("Rashi: ", "").toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.rashi!.replaceAll("Rashi: ", "").toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Maas
                            _panchangController_obj.mass != "0"?
                           Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                     padding: EdgeInsets.all(Get.height*0.008),
                                     constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                     width: SizeConfig.screenWidth*0.310,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       color:Color(0XFFBB3030),
                                     ),
                                     alignment: Alignment.centerLeft,
                                     child: FutureBuilder<Translation>(
                                       future: translator.translate("Mass :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                       builder: (context, snapshot) {
                                         if (snapshot.hasData) {
                                           return Text(
                                             snapshot.data!.text,
                                             style:font_style.White_700_17_ff,textAlign: TextAlign.center,
                                           );
                                         } else {
                                           return  Text("Mass :",style: font_style.White_700_17_ff,textAlign: TextAlign.center );
                                         }
                                       },
                                     ),
                                   ),
                                   Container(
                                       height: SizeConfig.screenHeight*0.065,
                                       width: SizeConfig.screenWidth*0.650,
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(10),
                                           color:  Color(0XFFfedec5),
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
                                       child:FutureBuilder<Translation>(
                                         future: translator.translate(_panchangController_obj.mass.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                         builder: (context, snapshot) {
                                           if (snapshot.hasData) {
                                             return Text(
                                               snapshot.data!.text,
                                               style:font_style.Black_bold_15_ff,
                                             );
                                           } else {
                                             return Text(_panchangController_obj.mass.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                           }
                                         },
                                       )

                                   )
                                 ],
                               ),
                               SizedBox(height: SizeConfig.screenHeight*0.010,),
                             ],
                           ):SizedBox(),

                            //Ritu
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFF311B92),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Ritu :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.center,
                                        );
                                      } else {
                                        return  Text("Ritu :",style: font_style.White_700_17_ff,textAlign: TextAlign.center );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.ritu.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.ritu.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Panchak
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFFdb07b8),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Panchak :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Panchak :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.panchak.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.panchak.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),
                            /// gandmool
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFF06cc09),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Gandmool :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Gandmool :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.gandmool.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.gandmool.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Disha shool
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFFB71C1C),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Disha shool :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.center,
                                        );
                                      } else {
                                        return  Text("Disha shool :",style: font_style.White_700_17_ff,textAlign: TextAlign.center );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.dishaShool.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.dishaShool.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

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
                                    padding: EdgeInsets.all(Get.height*0.008),
                                    constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                    width: SizeConfig.screenWidth*0.310,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:  Color(0xFF7F2F93),
                                      // color:Color(0xff1b567a),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate("Festival :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.White_700_17_ff,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Festival :",style: font_style.White_700_17_ff,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
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
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFF7F2F55),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Bhadra :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Bhadra :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.Bhadra.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.Bhadra.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),


                            SizedBox(height: SizeConfig.screenHeight*0.015,),
                            /// Inauspicious Period
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  // constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.5,
                                  height: Get.height*0.05,
                                  decoration: BoxDecoration(
                                      color: Color(0XFFfc051e),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  alignment: Alignment.center,
                                  child:FutureBuilder<Translation>(
                                    future: translator.translate("Inauspicious Period:", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style: font_style.Black_500_18_ff,
                                        );
                                      } else {
                                        return  Text("Inauspicious Period:",style: font_style.Black_500_18_ff,);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Rahu
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFF0511f7),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Rahukaal :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Rahukaal :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.rahu_kaal.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.rahu_kaal.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Yamaganda
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFF7F2F11),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Yamagandam :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Yamagandam :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.yamagamdam.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.yamagamdam.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.010,),

                            //Gulika
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.height*0.008),
                                  constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                  width: SizeConfig.screenWidth*0.310,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xFFfa05ee),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Gulika kaal :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return  Text("Gulika kaal :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.screenHeight*0.065,
                                    width: SizeConfig.screenWidth*0.650,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  Color(0XFFfedec5),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate(_panchangController_obj.gulikaKaal.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.Black_bold_15_ff,
                                          );
                                        } else {
                                          return Text(_panchangController_obj.gulikaKaal.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                        }
                                      },
                                    )

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
                                     padding: EdgeInsets.all(Get.height*0.008),
                                     constraints: BoxConstraints(minHeight: SizeConfig.screenHeight * 0.060),
                                     width: SizeConfig.screenWidth*0.310,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       color:Color(0xFF7F5F22),
                                     ),
                                     alignment: Alignment.centerLeft,
                                     child: FutureBuilder<Translation>(
                                       future: translator.translate("Dur Muhurat :", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                       builder: (context, snapshot) {
                                         if (snapshot.hasData) {
                                           return Text(
                                             snapshot.data!.text,
                                             style:font_style.White_700_17_ff,textAlign: TextAlign.left,
                                           );
                                         } else {
                                           return  Text("Dur Muhurat :",style: font_style.White_700_17_ff,textAlign: TextAlign.left );
                                         }
                                       },
                                     ),
                                   ),
                                   Container(
                                       height: SizeConfig.screenHeight*0.065,
                                       width: SizeConfig.screenWidth*0.650,
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(10),
                                           color:  Color(0XFFfedec5),
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
                                       child:FutureBuilder<Translation>(
                                         future: translator.translate(_panchangController_obj.durMuhurat.toString(), to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                         builder: (context, snapshot) {
                                           if (snapshot.hasData) {
                                             return Text(
                                               snapshot.data!.text,
                                               style:font_style.Black_bold_15_ff,
                                             );
                                           } else {
                                             return Text(_panchangController_obj.durMuhurat.toString(), style: font_style.Black_bold_15_ff,textAlign: TextAlign.center,);
                                           }
                                         },
                                       )

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
                                    child: FutureBuilder<Translation>(
                                      future: translator.translate("Chaughadia", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Chaughadia",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
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
                                    child:FutureBuilder<Translation>(
                                      future: translator.translate("Change Date", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Change Date",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
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
                                    child: FutureBuilder<Translation>(
                                      future: translator.translate("Change City", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Change City",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
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
                                    child: FutureBuilder<Translation>(
                                      future: translator.translate("Festivals", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Festivals",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
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
                                    child: FutureBuilder<Translation>(
                                      future: translator.translate("Hora", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Hora",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Significance
                            InkWell(
                              onTap: () {
                                Get.to(()=>MonthSignificance());
                                // Get.to(()=>SignificanceScreen());
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
                                    child: FutureBuilder<Translation>(
                                      future: translator.translate("Significanse", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Significance",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),
                            // Eclipse
                            InkWell(
                              onTap: () {
                                print(currentdate);
                                Get.to(()=>MonGrahanScreen(year: currentdate.toString(),));
                              },
                              child: Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth*0.010),
                                height: SizeConfig.screenHeight*0.080,
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Colors.white,
                                    border: Border.all(color: Colors.cyan, width: 2)
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                    height: SizeConfig.screenHeight*0.075,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Colors.cyan,
                                    ),
                                    child: FutureBuilder<Translation>(
                                      future: translator.translate("List of Eclipse", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("List of Eclipse",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Daily Predictions
                            InkWell(
                              onTap: (){
                                Get.to(DailyPredictionScreen(date: currentdate.toString()));
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
                                    child: FutureBuilder<Translation>(
                                      future: translator.translate("Daily Prediction", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Daily Prediction",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Weekly Predictions
                            InkWell(
                              onTap: (){
                                Get.to(WeeklyPredictionScreen(date: currentdate.toString()));
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
                                    child: FutureBuilder<Translation>(
                                      future: translator.translate("Weekly Prediction", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Weekly Prediction",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight*0.015,),

                            //Monthly Predictions
                            InkWell(
                              onTap: (){
                                Get.to(MonthlyPredictionScreen(date: currentdate.toString()));
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
                                    child: FutureBuilder<Translation>(
                                      future: translator.translate("Monthly Prediction", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.text,
                                            style:font_style.white_600_20_cl,textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return  Text("Monthly Prediction",style: font_style.white_600_20_cl,textAlign: TextAlign.center );
                                        }
                                      },
                                    ),
                                ),
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
                                  child: FutureBuilder<Translation>(
                                    future: translator.translate("Know About YourSelf >>", to: "${selectedLanguage}"), // Translate to Hindi ("hi")
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.text,
                                          style:font_style.White_700_17_ff,textAlign: TextAlign.center,
                                        );
                                      } else {
                                        return  Text("Know About Yourself >>",style: font_style.White_700_17_ff,textAlign: TextAlign.center );
                                      }
                                    },
                                  ),
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

  void selectLangu(){
    DropdownButton<String>(
      value: selectedLanguage,
      onChanged: (String? newValue) {
        setState(() {
          selectedLanguage = newValue!;
        });
      },
      items: languageKeys.keys.map<DropdownMenuItem<String>>((String key) {
        return DropdownMenuItem<String>(
          value: languageKeys[key],
          child: Text(key),
        );
      }).toList(),
    );
  }

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

