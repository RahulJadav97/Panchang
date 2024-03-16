import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panchang/Panchang_Model_controller/Controller/PanchanGController.dart';
import 'package:panchang/auth/screen/login_screen.dart';
import 'package:panchang/changecity/controller/city_data_controller.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/common_sharedprefrence.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/festivals/screen/festival_web_view.dart';
import 'package:panchang/panchang/screen/panchang_screen.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';
import 'package:panchang/tithi/tithi_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/standalone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
// import 'package:timezone/data/latest.dart' as tz;



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime selectedDay = DateTime.now();
  String _selectedValue = '1';
  PanchangController _panchangController_obj = Get.put(PanchangController());
  CityDataController cityDataController = Get.put(CityDataController());
  TithiController tithiController = Get.put(TithiController());


  String dd = "";
  String mm = "";
  String yy = "";
  String popupDatepicker = "";
  String mycity = "";
  String subcat = "";
  String LatDeg = "";
  String LatMin = "";
  String LonDeg = "";
  String LonMin = "";
  String East = "";
  String ZHour = "";
  String ZMin = "";
  String DST = "";
  String WAR = "";
  String Hour = "";
  String Min = "";
  String txtnm = "";
  String Day = "";
  String Month = "";
  String Year = "";
  String Asc = "";
  String Asc2 = "";
  String AYNS = "";
  String as = "";
  String moon = "";


  // Future<void> getLocation() async {
  //   LocationPermission permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     // Handle denied permission
  //     return;
  //   }
  //   Position position = await Geolocator.getCurrentPosition();
  //   print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
  // }

  // Future<void> getLatLongdata() async {
  //
  // }

  List tithiList = [];
  @override
  void initState() {
    getCurrentMonthAndYear().then((value) =>
        tithiController.tithiCont(month,year).then((value) {
          // tithiController.allDateTithi.forEach((element) {
          //   tithiList.add(element);
          // });
          print("tithiList${tithiList}");
          getdelhiData();
        }

        )
    );



    // _determinePosition().then((value) {
    //   getPosition();
    // });
    // TODO: implement initState
    super.initState();
  }
  String? month;
  String? year;
   Future<void> getCurrentMonthAndYear()async {
    DateTime now = DateTime.now();
     focusedDay = DateTime.now();
     month = DateFormat('MM').format(now);
     print("month  ${month}");
     year = DateFormat('yyyy').format(now);
    print("year  ${year}");


  }




  DateTime? focusedDay;

  Future<void> forwardMonthAndYear(int currentMonth, int currentYear) async {
    // Increment month and year
    int monthdd = currentMonth + 1;
    int yeardd = currentYear;

    // Check if month exceeds 12 (December)
    if (monthdd > 12) {
      monthdd = 1; // Reset month to January
      yeardd++;    // Increment year
    }



    month = monthdd.toString();
    year = yeardd.toString();
    // Update month and year variables
    tithiController.tithiCont(month.toString(), year.toString());


    // Update the focused day to the beginning of the new month
    setState(() {
      focusedDay = DateTime(int.parse(year.toString()) , int.parse(month.toString()), 1);
      print('forward focusedDay: $focusedDay');
    });
  }

  Future<void> backwardMonthAndYear(int currentMonth, int currentYear) async {
    // Decrement month and year
    int monthdd = currentMonth - 1;
    int yeardd = currentYear;

    // Check if month is less than 1 (January)
    if (monthdd < 1) {
      monthdd = 12;  // Set month to December
      yeardd--;      // Decrement year
    }

    month = monthdd.toString();
    year = yeardd.toString();
    // Update month and year variables
    tithiController.tithiCont(month.toString(), year.toString());


    // Update the focused day to the beginning of the new month
    setState(() {
      focusedDay = DateTime(int.parse(year.toString()) , int.parse(month.toString()), 1);
      print('backward focusedDay: $focusedDay');
    });
  }



  getdelhiData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString("sh_cityRowId", "1724").then((value) =>
    cityDataController.cityDataCont().then((value) {
      print("home page call");
      print("City: ${cityDataController.oldResponse.value.data!.first.place}");
      print("LetDeg: ${cityDataController.oldResponse.value.data!.first.latdeg}");
      print("latmin: ${cityDataController.oldResponse.value.data!.first.latmin}");
      print("latns: ${cityDataController.oldResponse.value.data!.first.latns}");
      print("longdeg: ${cityDataController.oldResponse.value.data!.first.longdeg}");
      print("longmin: ${cityDataController.oldResponse.value.data!.first.longmin}");
      print("longew: ${cityDataController.oldResponse.value.data!.first.longew}");
      print("ZHour: ${cityDataController.oldResponse.value.data!.first.zHour}");
      print("ZMin: ${cityDataController.oldResponse.value.data!.first.zMin}");
      print("DST: ${cityDataController.oldResponse.value.data!.first.dST}");
      print("WAR: ${cityDataController.oldResponse.value.data!.first.wAR}");
      print("direction: ${cityDataController.oldResponse.value.data!.first.direction}");

      sh.setString("sh_selectedCity", cityDataController.oldResponse.value.data!.first.place.toString());

      sh.setString("sh_selectedLtdDeg", cityDataController.oldResponse.value.data!.first.latdeg.toString());
      sh.setString("sh_selectedLtdMin", cityDataController.oldResponse.value.data!.first.latmin.toString());

      sh.setString("sh_selectedLongDeg",cityDataController.oldResponse.value.data!.first.longdeg.toString());
      sh.setString("sh_selectedLongMin", cityDataController.oldResponse.value.data!.first.longmin.toString());

      sh.setString("sh_selectedZHour", cityDataController.oldResponse.value.data!.first.zHour.toString());
      sh.setString("sh_selectedZMin", cityDataController.oldResponse.value.data!.first.zMin.toString());

      sh.setString("sh_selectedDst", cityDataController.oldResponse.value.data!.first.dST.toString());
      sh.setString("sh_selectedWar", cityDataController.oldResponse.value.data!.first.wAR.toString());

      var direction = cityDataController.oldResponse.value.data!.first.direction.toString();
      if(direction =="2"){
        sh.setString("sh_selectedDirectionEast","East");
      }else if(direction =="1"){
        sh.setString("sh_selectedDirectionEast","South");
      }else{
        sh.setString("sh_selectedDirectionEast","");
      }

      print("==============================================GetAddressFromLatLong open ================================");
      print("sh_selectedCity : ${sh.getString("sh_selectedCity")}");

      print("sh_selectedLtdDeg : ${sh.getString("sh_selectedLtdDeg")}");
      print("sh_selectedLtdMin : ${sh.getString("sh_selectedLtdMin")}");

      print("sh_selectedLongDeg : ${sh.getString("sh_selectedLongDeg")}");
      print("sh_selectedLongMin : ${sh.getString("sh_selectedLongMin")}");

      print("sh_selectedZHour : ${sh.getString("sh_selectedZHour")}");
      print("sh_selectedZMin : ${sh.getString("sh_selectedZMin")}");

      print("sh_selectedDst : ${sh.getString("sh_selectedDst")}");
      print("sh_selectedWar : ${sh.getString("sh_selectedWar")}");

      print("sh_selectedDirectionEast : ${sh.getString("sh_selectedDirectionEast")}");
      print("==============================================GetAddressFromLatLong close ================================");
    })
    );

  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          Future.value(false);
          return true;
        },
        child: Scaffold(
          backgroundColor: common_backcolor,
          body:Obx(() => tithiController.loading.value?Center(child: CircularProgressIndicator(color: common_red,),):
          Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     fit: BoxFit.cover,
            //     image: AssetImage("assets/images/texture3.jpg",)
            //   )
            // ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.020),
                    height: SizeConfig.screenHeight * 0.050,
                    width: SizeConfig.screenWidth,
                    color: Colors.grey.shade700,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Panchang Calendar", style: font_style.White_700_18_ff,),
                        PopupMenuButton<String>(
                          iconColor: Colors.white,
                          onSelected: (String value) {
                            setState(() {
                              _selectedValue = value;
                            });
                            if(_selectedValue.toString() == "1"){
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Are You Sure You Want To Delete Account?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      Obx(
                                         () {
                                          return TextButton(
                                            child:
                                            cityDataController.del_loading.value ?Center(child: CircularProgressIndicator())
                                          :
                                             Text('Ok'),
                                            onPressed: () {
                                              cityDataController.deleteAccountCont().then((value) {
                                                Get.back();
                                              });
                                            },
                                          );
                                        }
                                      ),
                                    ],
                                  );
                                },
                              );
                            }else{
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Are You Sure You Want To Logout?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Ok'),
                                        onPressed: () async {
                                          Get.to(()=> LoginScreen());
                                          SharedPreferences sh = await SharedPreferences.getInstance();
                                          sh.clear();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              value: '1',
                              child: Text('Delete Account?'),
                            ),
                            PopupMenuItem(
                              value: '2',
                              child: Text('Logout'),
                            ),
                          ],
                        )
                      ],
                    ),
                        
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.010,),
                        
                  Container(
                    height: SizeConfig.screenHeight * 0.060,
                    width: SizeConfig.screenWidth * 0.8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: common_red,
                        border: Border.all(width: 1.5, color: Colors.green
                            .shade800),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 9,
                              color: Colors.grey,
                              spreadRadius: 2.0,
                              offset: Offset(0.0, 0.0)
                          )
                        ]
                    ),
                    // child: Text("Select Date: 25-12-2023(Tueday)",style:font_style.White_700_18_ff  ,),
                    child: Text(
                      "Select Date: ", style: font_style.White_700_18_ff,),
                  ),
                  // SizedBox(height: SizeConfig.screenHeight*0.010,),
                        
                  Container(
                        
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: TableCalendar(
                        availableGestures: AvailableGestures.none,
                        // pageAnimationEnabled: false,
                        // focusedDay: DateTime.now(),
                        focusedDay: focusedDay!,
                        firstDay: DateTime.utc(2000, 1, 1),
                        lastDay: DateTime.utc(3000, 1, 1),
                        headerStyle: HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                            leftChevronIcon: InkWell(
                              onTap: (){
                                setState(() {
                                  backwardMonthAndYear(int.parse(month.toString()),int.parse(year.toString()));
                                });
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 2, color: Colors.red),
                                ),
                                child: const RotatedBox(
                                  quarterTurns: 6,
                                  child: Icon(Icons.play_arrow, color: Colors.green,
                                      size: 50),
                                ),
                              ),
                            ),
                        
                          rightChevronIcon: InkWell(
                            onTap: (){
                              forwardMonthAndYear(int.parse(month.toString()),int.parse(year.toString()));
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 2, color: Colors.red),
                                ),
                                child:  RotatedBox(
                                  quarterTurns: 0,
                                  child: Icon(Icons.play_arrow, color: Colors.green,
                                      size: 50),
                                ),
                              ),
                          ),
                            titleTextStyle: font_style.Black_600_22_ff_bold
                        
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15 // Set the font weight to bold
                          ),
                          weekendStyle: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15 // Set the font weight to bold
                          ),
                        ),
                        daysOfWeekVisible: true,
                        dayHitTestBehavior: HitTestBehavior.deferToChild,
                        daysOfWeekHeight: SizeConfig.screenHeight * 0.050,
                        
                        onDaySelected: (selectedDate, focusedDay) async {
                          setState(() {
                            selectedDay = selectedDate;
                          });
                          String datex = "${selectedDate.day}-${selectedDate
                              .month}-${selectedDate.year}";
                          String dayName = getDayName(selectedDate.year,
                              selectedDate.month, selectedDate.day);
                        
                          SharedPreferences sh = await SharedPreferences
                              .getInstance();
                          sh.setString("sh_selectedDate", datex.toString());
                          sh.setString("sh_selectedDayName", dayName.toString());
                          sh.setString("sh_selectedDay", selectedDate.day
                              .toString());
                          sh.setString('sh_selectedMonth', selectedDate.month
                              .toString());
                          sh.setString('sh_selectedYear', selectedDate.year
                              .toString());
                        
                          print(
                              "==================================onDaySelected=============================================");
                        
                          print("selected date: $datex");
                          print("selected dayname: $dayName");
                        
                          print(
                              "==================================onDaySelected=============================================");
                        
                          print("sh_selectedDate :${sh.getString(
                              "sh_selectedDate")}");
                          print("sh_selectedDayName :${sh.getString(
                              "sh_selectedDayName")}");
                          print("sh_selectedDay :${sh.getString(
                              "sh_selectedDay")}");
                          print("sh_selectedMonth :${sh.getString(
                              "sh_selectedMonth")}");
                          print("sh_selectedYear :${sh.getString(
                              "sh_selectedYear")}");
                          print(
                              "==================================onDaySelected=============================================");
                        
                        
                          Get.to(PanchangScreen(
                            date: datex,
                            dayname: dayName,
                          ));
                        },
                        
                        calendarStyle: CalendarStyle(
                          cellMargin: EdgeInsets.symmetric(horizontal: Get.width*0.002,vertical: Get.height*0.005),
                          outsideDaysVisible: true,
                          // Show previous and next month days
                          outsideDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey.withOpacity(0.2),
                            border: Border.all(width: 2, color: Colors.white),
                        
                          ),
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.orange,
                            border: Border.all(width: 1.5, color: common_red),
                          ),
                          // todayDecoration: BoxDecoration(
                          //   shape: BoxShape.rectangle,
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   color: Colors.blue,
                          //   border: Border.all(width: 1.5, color: common_red),
                          // ),
                        ),
                        
                        calendarBuilders: CalendarBuilders(
                          todayBuilder: (context, date, events,) {
                            bool isSelected = isSameDay(selectedDay, date);
                            // Get the index of the current date to select the corresponding letter
                            // int index = date.day % dayNames.length;
                            // int index = tithiList.isNotEmpty ? date.day % tithiList.length : 0;
                            int index = tithiController.allDateTithi.isNotEmpty ? date.day % tithiController.allDateTithi.length : 0;


                        
                            return GestureDetector(
                              onTap: () async {
                                selectedDay = date;
                                String datex = "${selectedDay.day}-${selectedDay
                                    .month}-${selectedDay.year}";
                                String dayName = getDayName(
                                    selectedDay.year, selectedDay.month,
                                    selectedDay.day);
                        
                                print(
                                    "=================================home calender Tap==============================================");
                        
                                print("selectedDay :${selectedDay}");
                        
                                print("selected date: $datex");
                                print("selected dayname: $dayName");
                        
                                SharedPreferences sh = await SharedPreferences
                                    .getInstance();
                                sh.setString("sh_selectedDate", datex.toString());
                                sh.setString(
                                    "sh_selectedDayName", dayName.toString());
                                sh.setString(
                                    "sh_selectedDay", selectedDay.day.toString());
                                sh.setString('sh_selectedMonth',
                                    selectedDay.month.toString());
                                sh.setString('sh_selectedYear',
                                    selectedDay.year.toString());
                        
                                print(
                                    "=================================home calender Tap==============================================");
                        
                                print("sh_selectedDate :${sh.getString(
                                    "sh_selectedDate")}");
                                print("sh_selectedDayName :${sh.getString(
                                    "sh_selectedDayName")}");
                                print("sh_selectedDay :${sh.getString(
                                    "sh_selectedDay")}");
                                print("sh_selectedMonth :${sh.getString(
                                    "sh_selectedMonth")}");
                                print("sh_selectedYear :${sh.getString(
                                    "sh_selectedYear")}");
                        
                                Get.to(PanchangScreen(
                                    date: datex, dayname: dayName));
                        
                                print(
                                    "=================================home calender Tap close==============================================");
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: Get.width*0.002,vertical: Get.height*0.005),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      width: 1.5, color:tithiController.allDateTithiColor[index-1] =="1"?common_red: common_red),
                                  // color: isSelected ? Colors.orange : Colors.green
                                  //     .shade800,
                                  color: Colors.blue
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${date.day}',
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : Colors.white,
                                          fontFamily: "calibri",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                        
                                      Text(
                                        // tithiController.allDateTithi.isNotEmpty ? '${tithiController.allDateTithi[index-1]}' : '',
                                        tithiController.allDateTithi[index-1],
                                        maxLines: 1,// Use a conditional to check if the list is empty
                                        style: TextStyle(
                                          color:  Colors.yellow,
                                          fontFamily: "calibri",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8,
                                        ),
                                      ),
                        
                        
                                    ],
                                  ),
                        
                                ),
                              ),
                            );
                          },
                          defaultBuilder: (context, date, events,) {
                            bool isSelected = isSameDay(selectedDay, date);
                            // Get the index of the current date to select the corresponding letter
                            // int index = date.day % dayNames.length;
                            // int index = tithiList.isNotEmpty ? date.day % tithiList.length : 0;
                            int index = tithiController.allDateTithi.isNotEmpty ? date.day % tithiController.allDateTithi.length : 0;
                            return GestureDetector(
                              onTap: () async {
                                selectedDay = date;
                                String datex = "${selectedDay.day}-${selectedDay
                                    .month}-${selectedDay.year}";
                                String dayName = getDayName(
                                    selectedDay.year, selectedDay.month,
                                    selectedDay.day);
                        
                                print(
                                    "=================================home calender Tap==============================================");
                        
                                print("selectedDay :${selectedDay}");
                        
                                print("selected date: $datex");
                                print("selected dayname: $dayName");
                        
                                SharedPreferences sh = await SharedPreferences
                                    .getInstance();
                                sh.setString("sh_selectedDate", datex.toString());
                                sh.setString(
                                    "sh_selectedDayName", dayName.toString());
                                sh.setString(
                                    "sh_selectedDay", selectedDay.day.toString());
                                sh.setString('sh_selectedMonth',
                                    selectedDay.month.toString());
                                sh.setString('sh_selectedYear',
                                    selectedDay.year.toString());
                        
                                print(
                                    "=================================home calender Tap==============================================");
                        
                                print("sh_selectedDate :${sh.getString(
                                    "sh_selectedDate")}");
                                print("sh_selectedDayName :${sh.getString(
                                    "sh_selectedDayName")}");
                                print("sh_selectedDay :${sh.getString(
                                    "sh_selectedDay")}");
                                print("sh_selectedMonth :${sh.getString(
                                    "sh_selectedMonth")}");
                                print("sh_selectedYear :${sh.getString(
                                    "sh_selectedYear")}");
                        
                                Get.to(PanchangScreen(
                                    date: datex, dayname: dayName));
                        
                                print(
                                    "=================================home calender Tap close==============================================");
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: Get.width*0.002,vertical: Get.height*0.005),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      width: 1.5, color: common_red),
                                  color: tithiController.allDateTithiColor[index-1] =="1" ? Colors.red : Colors.green
                                      .shade800,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${date.day}',
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : Colors.white,
                                          fontFamily: "calibri",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                        
                                      Text(
                                        // tithiController.allDateTithi.isNotEmpty ? '${tithiController.allDateTithi[index-1]}' : '',
                                        tithiController.allDateTithi[index-1],
                                        maxLines: 1,// Use a conditional to check if the list is empty
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : Colors.yellow,
                                          fontFamily: "calibri",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8,
                                        ),
                                      ),
                        
                        
                                    ],
                                  ),
                        
                                ),
                              ),
                            );
                        
                        
                          },
                        ),
                        rowHeight: SizeConfig.screenHeight * 0.085,
                        
                      ),
                    ),
                  ),
                  // SizedBox(height: SizeConfig.screenHeight*0.010,),
                        
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>FestivalWebScreen(webUrl: "https://www.premastrologer .com",));
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.screenHeight * 0.040),
                        height: SizeConfig.screenHeight * 0.040,
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.circular(5),
                          color: Color(0xff980101),
                        ),
                        child: Text("know About Yourself>>",
                          style: font_style.white_600_15_ff,
                          textAlign: TextAlign.center,)),
                  ),
                  Container(
                      height: SizeConfig.screenHeight * 0.150,
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: SizeConfig.screenHeight,
                            width: SizeConfig.screenWidth * 0.250,
                            // color: Colors.red,
                            child: Image.asset(
                              "assets/images/cilent_panchang.png",
                              fit: BoxFit.cover,),
                          ),
                          Container(
                            height: SizeConfig.screenHeight,
                            width: SizeConfig.screenWidth * 0.750,
                            color: Colors.black,
                            alignment: Alignment.topCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.020,),
                                Text("Reach us at:",
                                  style: font_style.White_700_18_ff,
                                  textAlign: TextAlign.center,),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.010,),
                        
                                InkWell(
                                  onTap: (){
                                    Get.to(()=>FestivalWebScreen(webUrl: "https://www.premastrologer.com/",));
                                  },
                                  child: Text("www.premastrologer.com",
                                    style: font_style.White_700_18_ff,
                                    textAlign: TextAlign.center,),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.010,),
                        
                                InkWell(
                                  onTap: (){
                                    redirectToGmail();
                                  },
                                  child: Text("psharma@premastrologer.com",
                                    style: font_style.White_700_18_ff,
                                    textAlign: TextAlign.center,),
                                ),
                        
                        
                              ],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 50,),
                        
                        
                ],
              ),
            ),
          ),
          )

        ),
      ),
    );
  }


  String getDayName(int year, int month, int day) {
    if (month < 3) {
      month += 12;
      year -= 1;
    }

    int h = (day + ((13 * (month + 1)) ~/ 5) + year + (year ~/ 4) -
        (year ~/ 100) + (year ~/ 400)) % 7;

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

  List<String> dayNames = [
    "Day 1",
    "Day 2",
    "Day 3",
    "Day 4",
    "Day 5",
    "Day 6",
    "Day 7",
    "Day 8",
    "Day 9",
    "Day 10",
    "Day 11",
    "Day 12",
    "Day 13",
    "Day 14",
    "Day 15",
    "Day 16",
    "Day 17",
    "Day 18",
    "Day 19",
    "Day 20",
    "Day 21",
    "Day 22",
    "Day 23",
    "Day 24",
    "Day 25",
    "Day 26",
    "Day 27",
    "Day 28",
    "Day 29",
    "Day 30",
    "Day 31",
    "Day 32",
  ];

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


  /// --------- current location ----------------///

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
