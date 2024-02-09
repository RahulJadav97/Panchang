import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:panchang/Panchang_Model_controller/Controller/PanchanGController.dart';
import 'package:panchang/changecity/controller/city_controller.dart';
import 'package:panchang/changecity/controller/city_data_controller.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/common_sharedprefrence.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/panchang/screen/panchang_screen.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/standalone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
// import 'package:timezone/data/latest.dart' as tz;




class ChangeCityScreen extends StatefulWidget {
  const ChangeCityScreen({super.key});

  @override
  State<ChangeCityScreen> createState() => _ChangeCityScreenState();
}

class _ChangeCityScreenState extends State<ChangeCityScreen> {

  CityController cityController = Get.put(CityController());
  CityDataController cityDataController = Get.put(CityDataController());

  TextEditingController _searchController = TextEditingController();
  TextEditingController _ltdCTC = TextEditingController();
  TextEditingController _ltd1CTC = TextEditingController();
  TextEditingController _longCTC = TextEditingController();
  TextEditingController _long1CTC = TextEditingController();
  TextEditingController _timeHour1CTC = TextEditingController();
  TextEditingController _timemin1CTC = TextEditingController();
  TextEditingController _dstCTC = TextEditingController();
  TextEditingController _warCTC = TextEditingController();
  bool south = false;
  bool east = false;
  var checkSelectedCity;

  // var directionEast ="East";

  String ?selectedRegion;

  final GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();


  Future<void> getSaharedDateData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    print("==============================================city Page getSaharedDateData===============================================");

    print("sh_selectedDate :${sh.getString("sh_selectedDate")}");
    print("sh_selectedDayName :${sh.getString("sh_selectedDayName")}");
    print("sh_selectedDay :${sh.getString("sh_selectedDay")}");
    print("sh_selectedMonth :${sh.getString("sh_selectedMonth")}");
    print("sh_selectedYear :${sh.getString("sh_selectedYear")}");
    print("sh_selectedCity :${sh.getString("sh_selectedCity")}");

    print("==============================================city Page getSaharedDateData===============================================");

  }
  @override
  void initState() {
    getSaharedDateData();
    cityController.cityCont();
    _searchController.text = "Ahmedabad";
    super.initState();
  }

  String? selectedCity;
  String cityRowId = '';


  PanchangController _panchangController_obj = Get.put(PanchangController());


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



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
        child:Scaffold(
          backgroundColor: common_backcolor,
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         fit: BoxFit.cover,
            //         image: AssetImage("assets/images/texture3.jpg",)
            //     )
            // ),
            child: SingleChildScrollView(
              child:Obx(() => cityController.loading.value?Container(
                  height: SizeConfig.screenHeight*0.92,
                  width: SizeConfig.screenWidth,
                  child: Center(child: CircularProgressIndicator(color: common_red,),)):
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.020),
                    height: SizeConfig.screenHeight*0.050,
                    width: SizeConfig.screenWidth,
                    color: Colors.grey.shade700,
                    alignment: Alignment.centerLeft,
                    child: Text("Add City", style:font_style.White_700_18_ff ,),

                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.010,),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth*0.010),
                    child: Column(
                      children: [
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     SizedBox(width: SizeConfig.screenWidth*0.020,),
                        //     Text("City:",style: font_style.Black_600_20_ff, ),
                        //     SizedBox(width: SizeConfig.screenWidth*0.020,),
                        //
                        //
                        //     Container(
                        //       alignment: Alignment.center,
                        //       height: SizeConfig.screenHeight*0.060,
                        //       width: SizeConfig.screenWidth*0.850,
                        //       child: TextFormField(
                        //         autofocus: false,
                        //         textAlign: TextAlign.start,
                        //         controller: _searchController,
                        //         style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'calibri') ,
                        //         decoration: InputDecoration(
                        //             fillColor: Colors.white,
                        //             filled: true,
                        //           contentPadding: EdgeInsets.all(SizeConfig.screenWidth*0.030),
                        //           constraints: BoxConstraints(
                        //             maxHeight: SizeConfig.screenHeight*0.050,
                        //           ),
                        //             border:OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(5),
                        //                 borderSide: BorderSide(color:  Colors.grey, width: 2)
                        //             ),
                        //             enabledBorder: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(5),
                        //                 borderSide: const BorderSide(color:  Colors.grey, width: 2)
                        //             ),
                        //             focusedBorder: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(5),
                        //                 borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                        //             )
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Container(
                        //   height: SizeConfig.screenHeight*0.050,
                        //   width: SizeConfig.screenWidth*0.250,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey.shade500,
                        //     borderRadius: BorderRadius.circular(5)
                        //   ),
                        //   child: Text("Search City", style:font_style.Black_500_18_ff  ,),
                        // ),
                        SizedBox(height: SizeConfig.screenHeight*0.020,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth*0.7,
                              height: SizeConfig.screenHeight*0.065,
                              child: AutoCompleteTextField<String>(
                                key: key,
                                clearOnSubmit: false,
                                suggestions:cityController.allCityName, // List of suggestions
                                // style: FontStyles.regular_16_white, // Your text style
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:  Colors.grey.withOpacity(0.8),
                                  contentPadding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
                                  border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color:Colors.grey)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: " Select City",
                                  hintStyle: _searchController.text.isNotEmpty
                                      ? font_style.Black_500_18_ff
                                      : font_style.Black_500_18_ff.copyWith(color: Colors.grey),
                                ),
                                itemFilter: (item, query) {
                                  return item.toLowerCase().contains(query.toLowerCase());
                                },
                                itemSorter: (a, b) {
                                  return a.compareTo(b);
                                },
                                itemSubmitted: (value) async {
                                  SharedPreferences sh = await SharedPreferences.getInstance();
                                  setState(() {
                                    checkSelectedCity = value.toString();
                                    _searchController.text = value.toString();
                                    print("${_searchController.text}");

                                    var index = cityController.allCityName.indexOf(value);
                                    cityRowId = cityController.CityRowId[index].toString();
                                    sh.setString("sh_cityRowId", cityRowId);
                                    print("cityRowId :${cityRowId}");

                                    print("cityname : ${value.toString()}");
                                    print("cityRowId : $cityRowId");


                                    // print("==============================================DropDown open ================================");
                                    // getLatLngFromCityName(value.toString());
                                    // setup();
                                    // sh.setString("sh_selectedCity", value.toString());
                                    // print("sh_selectedCity : ${sh.getString("sh_selectedCity")}");
                                  });
                                },
                                itemBuilder: (context, item) {
                                  return ListTile(
                                    title: Text(item),
                                  );
                                },
                              ),
                            ),
                            Obx(() => cityDataController.loading.value?Center(child: CircularProgressIndicator(color: common_red,),):
                                /// =================== done =======================////
                            GestureDetector(
                              onTap: (){


                                cityDataController.cityDataCont().then((value) {
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
                                  setState(() {
                                    _ltdCTC.text = cityDataController.oldResponse.value.data!.first.latdeg.toString();
                                    _ltd1CTC.text = cityDataController.oldResponse.value.data!.first.latmin.toString();
                                    _longCTC.text =  cityDataController.oldResponse.value.data!.first.longdeg.toString();
                                    _long1CTC.text = cityDataController.oldResponse.value.data!.first.longmin.toString();
                                    _timeHour1CTC.text = cityDataController.oldResponse.value.data!.first.zHour.toString();
                                    _timemin1CTC.text = cityDataController.oldResponse.value.data!.first.zMin.toString();
                                    _dstCTC.text = cityDataController.oldResponse.value.data!.first.dST.toString();
                                    _warCTC.text = cityDataController.oldResponse.value.data!.first.wAR.toString();
                                    if (cityDataController.oldResponse.value.data!.first.direction == 0) {
                                      selectedRegion = ""; // No radio button selected
                                    } else if (cityDataController.oldResponse.value.data!.first.direction == 1) {
                                      selectedRegion = "South"; // Select East
                                    } else if (cityDataController.oldResponse.value.data!.first.direction == 2) {
                                      selectedRegion = "East"; // Select West
                                    }

                                  });
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: Get.height*0.01),
                                child: Container(
                                  height: SizeConfig.screenHeight*0.050,
                                  width: SizeConfig.screenWidth*0.250,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade500,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("Done", style:font_style.Black_500_18_ff  ,),
                                ),
                              ),
                            ),
                            )


                          ],
                        ),

                         /*
                         DropdownButtonFormField(
                          focusColor: Colors.grey,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:  Colors.grey.withOpacity(0.8),
                            contentPadding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color:Colors.grey)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: " Select City",
                            hintStyle: _searchController.text.isNotEmpty
                                ? font_style.Black_500_18_ff
                                : font_style.Black_500_18_ff.copyWith(color: Colors.grey),
                          ),
                          onTap: () {
                            print('object');
                          },
                          items: cityController.allCityName
                              .map<DropdownMenuItem<String>>((var value) {
                                // print(cityController.allCityName);
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      value.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) async {
                            checkSelectedCity = value.toString();
                            _searchController.text = value.toString();
                            print("${_searchController.text}");

                            var index = cityController.allCityName.indexOf(value!);
                            print("cityname : ${value.toString()}");
                            print("cityname index: $index");

                            getLatLngFromCityName(value.toString());
                            setup();

                            print("==============================================DropDown open ================================");
                            SharedPreferences sh = await SharedPreferences.getInstance();
                            sh.setString("sh_selectedCity", value.toString());
                            print("sh_selectedCity : ${sh.getString("sh_selectedCity")}");
                            print("==============================================DropDown Close ================================");
                          },

                        ),
                         */

                        SizedBox(height: SizeConfig.screenHeight*0.040,),

                        //lattitudes
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: SizeConfig.screenWidth*0.020,),
                            Text("Lattitudes:",style: font_style.Black_500_18_ff, ),
                            SizedBox(width: SizeConfig.screenWidth*0.030,),


                            Container(
                              // alignment: Alignment.center,
                              // height: SizeConfig.screenHeight*0.080,
                              width: SizeConfig.screenWidth*0.120,
                              // color: Colors.red,
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.justify,
                                controller: _ltdCTC,
                                style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'Kalam') ,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                    constraints: BoxConstraints(
                                      maxHeight: SizeConfig.screenHeight*0.050,
                                    ),
                                    border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.grey, width: 1)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color:  Colors.grey, width: 1)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.screenWidth*0.100,),
                            Container(
                              // alignment: Alignment.center,
                              // height: SizeConfig.screenHeight*0.080,
                              width: SizeConfig.screenWidth*0.120,
                              // color: Colors.red,
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.justify,
                                controller: _ltd1CTC,
                                style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'Kalam') ,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                    constraints: BoxConstraints(
                                      maxHeight: SizeConfig.screenHeight*0.050,
                                    ),
                                    border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.grey, width: 1)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color:  Colors.grey, width: 1)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.screenWidth*0.040,),


                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Radio<String>(
                                  value: "South",
                                  groupValue: selectedRegion,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRegion = value.toString();
                                    });
                                  },
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.010),
                                  child: Text("South",style: font_style.Black_500_18_ff,),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight*0.020,),
                        //langitudes
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: SizeConfig.screenWidth*0.020,),
                            Text("Longitudes:",style: font_style.Black_500_18_ff, ),
                            SizedBox(width: SizeConfig.screenWidth*0.020,),


                            Container(
                              // alignment: Alignment.center,
                              // height: SizeConfig.screenHeight*0.080,
                              width: SizeConfig.screenWidth*0.120,
                              // color: Colors.red,
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.justify,
                                controller: _longCTC,
                                style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'Kalam') ,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                    constraints: BoxConstraints(
                                      maxHeight: SizeConfig.screenHeight*0.050,
                                    ),
                                    border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.grey, width: 1)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color:  Colors.grey, width: 1)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.screenWidth*0.100,),
                            Container(
                              // alignment: Alignment.center,
                              // height: SizeConfig.screenHeight*0.080,
                              width: SizeConfig.screenWidth*0.120,
                              // color: Colors.red,
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.justify,
                                controller: _long1CTC,
                                style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'Kalam') ,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                    constraints: BoxConstraints(
                                      maxHeight: SizeConfig.screenHeight*0.050,
                                    ),
                                    border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.grey, width: 1)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color:  Colors.grey, width: 1)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.screenWidth*0.040,),


                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Radio<String>(
                                  value: "East",
                                  groupValue: selectedRegion,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRegion = value.toString();
                                    });
                                  },
                                ),

                                SizedBox(width: SizeConfig.screenWidth*0.020,),
                                Padding(
                                  padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.010),
                                  child: Text("East", style: font_style.Black_500_18_ff,),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight*0.020,),

                        //Timezone
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: SizeConfig.screenWidth*0.020,),
                            Text("TimeZone:",style: font_style.Black_500_18_ff, ),
                            SizedBox(width: SizeConfig.screenWidth*0.040,),


                            Container(
                              // alignment: Alignment.center,
                              // height: SizeConfig.screenHeight*0.080,
                              width: SizeConfig.screenWidth*0.120,
                              // color: Colors.red,
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.justify,
                                controller: _timeHour1CTC,
                                style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'Kalam') ,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                    constraints: BoxConstraints(
                                      maxHeight: SizeConfig.screenHeight*0.050,
                                    ),
                                    border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.grey, width: 1)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color:  Colors.grey, width: 1)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.screenWidth*0.100,),
                            Container(
                              // alignment: Alignment.center,
                              // height: SizeConfig.screenHeight*0.080,
                              width: SizeConfig.screenWidth*0.120,
                              // color: Colors.red,
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.justify,
                                controller: _timemin1CTC,
                                style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'Kalam') ,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                    constraints: BoxConstraints(
                                      maxHeight: SizeConfig.screenHeight*0.050,
                                    ),
                                    border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.grey, width: 1)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color:  Colors.grey, width: 1)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                                    )
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight*0.020,),

                        //DTS
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: SizeConfig.screenWidth*0.1350,),

                            Text("DST:",style: font_style.Black_500_18_ff, ),
                            SizedBox(width: SizeConfig.screenWidth*0.05,),
                            Container(
                              // alignment: Alignment.center,
                              // height: SizeConfig.screenHeight*0.080,
                              width: SizeConfig.screenWidth*0.120,
                              // color: Colors.red,
                              child: TextFormField(
                                controller: _dstCTC,
                                autofocus: false,
                                textAlign: TextAlign.justify,
                                // controller: _searchController,
                                style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'Kalam') ,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                    constraints: BoxConstraints(
                                      maxHeight: SizeConfig.screenHeight*0.050,
                                    ),
                                    border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.grey, width: 1)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color:  Colors.grey, width: 1)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.screenWidth*0.140,),
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight*0.020,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: SizeConfig.screenWidth*0.1290,),

                            Text("War:",style: font_style.Black_500_18_ff, ),
                            SizedBox(width: SizeConfig.screenWidth*0.05,),
                            Container(
                              // alignment: Alignment.center,
                              // height: SizeConfig.screenHeight*0.080,
                              width: SizeConfig.screenWidth*0.120,
                              // color: Colors.red,
                              child: TextFormField(
                                controller: _warCTC,
                                autofocus: false,
                                textAlign: TextAlign.justify,
                                // controller: _searchController,
                                style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20,fontFamily: 'Kalam') ,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(SizeConfig.screenWidth*0.020),
                                    constraints: BoxConstraints(
                                      maxHeight: SizeConfig.screenHeight*0.050,
                                    ),
                                    border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.grey, width: 1)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color:  Colors.grey, width: 1)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight*0.150,),


                        Obx(
                                () {
                              return InkWell(
                                onTap: () async {
                                  // print("_searchController.text ${checkSelectedCity}");
                                  if(checkSelectedCity == null){
                                    Fluttertoast.showToast(msg: "Please Select City");
                                  }else{

                                    SharedPreferences sh = await SharedPreferences.getInstance();

                                    sh.setString("sh_selectedCity", checkSelectedCity.toString());

                                    sh.setString("sh_selectedLtdDeg", _ltdCTC.text.toString());
                                    sh.setString("sh_selectedLtdMin", _ltd1CTC.text.toString());

                                    sh.setString("sh_selectedLongDeg", _longCTC.text.toString());
                                    sh.setString("sh_selectedLongMin", _long1CTC.text.toString());

                                    sh.setString("sh_selectedZHour", _timeHour1CTC.text.toString());
                                    sh.setString("sh_selectedZMin", _timemin1CTC.text.toString());

                                    sh.setString("sh_selectedDst", _dstCTC.text.toString());
                                    sh.setString("sh_selectedWar", _warCTC.text.toString());

                                    if(selectedRegion =="East"){
                                      sh.setString("sh_selectedDirectionEast","East");
                                    }else if(selectedRegion =="South"){
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




                                    setState(() {
                                      _panchangController_obj.panchangCont(popupDatepicker, mycity, subcat, LatDeg, LatMin, LonDeg, LonMin, East, ZHour, ZMin, DST, WAR, Hour, Min, txtnm, Day, Month, Year, Asc, Asc2, AYNS, as, moon).then((value) {
                                        if(_panchangController_obj.oldResponse.value.responseCode== 1){
                                          Get.to(PanchangScreen());
                                        }
                                      });
                                    });
                                  }

                                },
                                child: Container(
                                  height: SizeConfig.screenHeight*0.045,
                                  width: SizeConfig.screenWidth,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade500,
                                    // border: Border.all(width: 1)
                                  ),
                                  alignment: Alignment.center,
                                  child: _panchangController_obj.loading.value?CircularProgressIndicator(color: Colors.white,):Text("Show Panchang", style: font_style.Black_400_15_ff,),
                                ),
                              );
                            }
                        ),
                        SizedBox(height: SizeConfig.screenHeight*0.050,),
                        /// ---------- Save As Default City ---------------///////
                        // Container(
                        //   height: SizeConfig.screenHeight*0.045,
                        //   width: SizeConfig.screenWidth,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey.shade500,
                        //     // border: Border.all(width: 1)
                        //   ),
                        //   alignment: Alignment.center,
                        //   child: Text("Save As Default City", style: font_style.Black_400_15_ff,),
                        // )

                      ],
                    ),
                  ),
                ],
              ),
              )

            ),
          ),
        )
    );
  }
  var latitude;
  var longitude;


  // Future<void> getLatLngFromCityName(String cityName) async {
  //   try {
  //     List<Location> locations = await locationFromAddress(cityName);
  //     if (locations.isNotEmpty) {
  //       latitude = locations[0].latitude;
  //       longitude = locations[0].longitude;
  //        print("latitude${latitude}");
  //        print("longitude${longitude}");
  //
  //       var latitudex = '$latitude';
  //       var longitudex = '$longitude';
  //       // Split the string based on the dot (.)
  //       List<String> parts = latitudex.split('.');
  //       String wholeNumber = parts[0];
  //       String decimalPart = parts.length > 1 ? parts[1].substring(0, 2) : '00';
  //       print('Whole Number: $wholeNumber');
  //       print('Decimal Part: $decimalPart');
  //
  //       List<String> parts1 = longitudex.split('.');
  //       String wholeNumber1 = parts1[0];
  //       String decimalPart1 = parts1.length > 1 ? parts1[1].substring(0, 2) : '00';
  //       print('Whole Number1: $wholeNumber1');
  //       print('Decimal Part1: $decimalPart1');
  //       /// ===================== commment  ==========///
  //       // setState(() {
  //       //   _ltdCTC.text= wholeNumber.toString();
  //       //   _ltd1CTC.text= decimalPart.toString();
  //       //   _longCTC.text= wholeNumber1.toString();
  //       //   _long1CTC.text= decimalPart1.toString();
  //       // });
  //
  //
  //        // Extract latitude degrees and minutes
  //        int latitudeDegrees = latitude.floor();
  //        double latitudeMinutes = (latitude - latitudeDegrees) * 60;
  //
  //
  //        // Extract longitude degrees and minutes
  //        int longitudeDegrees = longitude.floor();
  //        double longitudeMinutes = (longitude - longitudeDegrees) * 60;
  //
  //
  //       SharedPreferences sh = await SharedPreferences.getInstance();
  //       sh.setString("sh_selectedLtd", latitude.toString());
  //        sh.setString("sh_selectedLtdDeg", latitudeDegrees.toString());
  //        sh.setString("sh_selectedLtdMin", latitudeMinutes.toString());
  //
  //        sh.setString("sh_selectedLong", longitude.toString());
  //        sh.setString("sh_selectedLongDeg", longitudeDegrees.toString());
  //        sh.setString("sh_selectedLongMin", longitudeMinutes.toString());
  //
  //        print("==============================================GetAddressFromLatLong open ================================");
  //        print("sh_selectedCity : ${sh.getString("sh_selectedCity")}");
  //
  //        print("sh_selectedLtd : ${sh.getString("sh_selectedLtd")}");
  //        print("sh_selectedLtdDeg : ${sh.getString("sh_selectedLtdDeg")}");
  //        print("sh_selectedLtdMin : ${sh.getString("sh_selectedLtdMin")}");
  //
  //        print("sh_selectedLong : ${sh.getString("sh_selectedLong")}");
  //        print("sh_selectedLongDeg : ${sh.getString("sh_selectedLongDeg")}");
  //        print("sh_selectedLongMin : ${sh.getString("sh_selectedLongMin")}");
  //        print("==============================================GetAddressFromLatLong close ================================");
  //
  //
  //
  //     } else {
  //       throw Exception('No locations found for the city: $cityName');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

  String? realTimeZon;
  var timeZoneMin;
  var timeZoneHour;
  // Future<void> setup() async {
  //   var londonLocation = tz.getLocation("Asia/Kolkata");
  //   print("londonLocation $londonLocation");
  //   var nowInLondon = tz.TZDateTime.now(londonLocation);
  //   print(nowInLondon.minute);
  //
  //   setState(() {
  //     realTimeZon = nowInLondon.toString();
  //     timeZoneMin = nowInLondon.minute;
  //     timeZoneHour = nowInLondon.hour;
  //
  //     setState(() {
  //       _timeHour1CTC.text = timeZoneHour.toString();
  //       _timemin1CTC.text = timeZoneMin.toString();
  //     });
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
