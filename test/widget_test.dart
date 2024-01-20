// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:panchang/changecity/screen/changecity_screen.dart';
// import 'package:panchang/chaughadia/screen/chaughadia_screen.dart';
// import 'package:panchang/common/common_colour.dart';
// import 'package:panchang/common/teststyle.dart';
// import 'package:panchang/festivals/screen/festival_search_screen.dart';
// import 'package:panchang/festivals/screen/festivals.dart';
//
// class PanchangScreen extends StatefulWidget {
//
//   String ?date;
//   String ?dayname;
//
//   PanchangScreen({this.date, this.dayname}); // const PanchangScreen({super.key});
//
//   @override
//   State<PanchangScreen> createState() => _PanchangScreenState();
// }
//
// class _PanchangScreenState extends State<PanchangScreen> {
//
//
//   List SurriseLineList=[];
//   List DateLineList =[];
//   var date;
//   var dayname;
//
//   DateTime? selectedDateX;
//   String? selectedDate;
//   String?formattedDate;
//
//   Future<void> _changeDate() async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDateX,
//         firstDate: DateTime(2015, 8),
//         lastDate: DateTime(2101));
//     if (picked != null && picked != selectedDateX) {
//       setState(() {
//         selectedDateX = picked;
//         formattedDate = "${selectedDateX!.year}-${selectedDateX!.month.toString().padLeft(2, '0')}-${selectedDateX!.day.toString().padLeft(2, '0')}";
//         selectedDate = formattedDate ;
//         print("selectedDateX :$selectedDate");
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     date = widget.date;
//     dayname = widget.dayname;
//
//     SurriseLineList =[
//       "$date ($dayname)",
//       "Sunrise: 05:50 Sunset: 19:23",
//       "Chaturdashi till 19:57\n Krishna Praksha",
//       "Kritika till 21:18",
//       "Sakarma till 24:36",
//       "Vishit til 08:25/Sakuma",
//       "Rashi: Tourus",
//       "12:36 to 14:18",
//       "No",
//       "No",
//       "No",
//       "07:33 to 09:14",
//       "Bhardra to 08:59"
//     ];
//
//     DateLineList =[
//       "Date",
//       "Sunrise",
//       "Tithi",
//       "Nakshatra",
//       "Yoga",
//       "Karan",
//       "Rashi",
//       "Rahukaal",
//       "Gandmool",
//       "Panchak",
//       "Festival",
//       "Yamangandamkal",
//       "Bhadra",
//       "Choughadia",
//       "Change Date",
//       "Change City",
//       "Festivals",
//       "Hora",
//       "Daily Predictions",
//       "Weekly Prediction",
//       "Monthly Prediction",
//       "know About Yourself>>",
//       ""
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           backgroundColor: common_backcolor,
//           body: Container(
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage("assets/images/texture3.jpg",)
//                 )
//             ),
//             child: ListView(
//               physics: ClampingScrollPhysics(),
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(left: Get.width*0.020),
//                   height: Get.height*0.050,
//                   width: Get.width,
//                   color: Colors.grey,
//                   alignment: Alignment.centerLeft,
//                   child: Text("Panchang calendar", style:font_style.white_400_13 ,),
//
//                 ),
//
//
//                 Container(
//                   height: Get.height*0.9,
//                   child: ListView.builder(
//                     physics: ClampingScrollPhysics(),
//                     itemCount: DateLineList.length,
//                     itemBuilder: (context, index) {
//                       if(index== 0){
//                         return Container(
//                           child:Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     height: Get.height*0.070,
//                                     width: Get.width*0.110,
//                                     decoration: const BoxDecoration(
//                                         color: Color(0xffcb1505),
//                                         shape: BoxShape.circle
//                                     ),
//                                     alignment: Alignment.center,
//                                     child: Text("<<", style:TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),),
//                                   ),
//                                   SizedBox(width: Get.width*0.010,),
//                                   Container(
//                                     height: Get.height*0.050,
//                                     width: Get.width*0.6,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         color: Colors.green.shade900,
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(color: Colors.red, width: 1),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                               blurRadius: 5,
//                                               color: Colors.red,
//                                               spreadRadius: 1.0,
//                                               offset: Offset(0.0, 0.0)
//                                           )
//                                         ]
//                                     ),
//
//                                     child: Text("Panchang", style: font_style.White_700_16,),
//
//                                   ),
//                                   SizedBox(width: Get.width*0.010,),
//                                   Container(
//                                     height: Get.height*0.070,
//                                     width: Get.width*0.110,
//                                     decoration: BoxDecoration(
//                                         color: Color(0xffcb1505),
//                                         shape: BoxShape.circle
//                                     ),
//                                     alignment: Alignment.center,
//                                     child: Text(">>", style:TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),),
//                                   ),
//                                 ],
//                               ),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   // height: Get.height*0.020,
//                                   decoration: BoxDecoration(
//                                       color: Color(0xffcb1505),
//                                       borderRadius: BorderRadius.circular(10)
//                                   ),
//                                   padding: EdgeInsets.all(Get.width*0.020),
//                                   child: Text("Place: Ahmedabad(Gujarat)", style:font_style.white_400_11 ,),
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       }
//
//                       //chaughadia
//                       else if(index== 7) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
//                                 height: Get.height*0.060,
//                                 width: Get.width*0.3,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:Colors.purple[700],
//                                 ),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text("${DateLineList[index-1]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center ),
//                               ),
//                               Container(
//                                 height: Get.height*0.065,
//                                 width: Get.width*0.650,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Color(0XFFfedec5),
//                                     border: Border.all(color: common_red, width: 1),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           blurRadius: 1,
//                                           color: Color(0XFFbe765a),
//                                           spreadRadius: 1.0,
//                                           offset: Offset(0.0, 2.0)
//                                       )
//                                     ]
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Text("${SurriseLineList[index-1]}", style: font_style.Black_400_15_ff,),
//
//                               )
//                             ],
//                           ),
//                         );
//                       } else if(index== 8) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
//                                 height: Get.height*0.060,
//                                 width: Get.width*0.3,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:Colors.blue.shade900,
//                                 ),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text("${DateLineList[index-1]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center ),
//                               ),
//                               Container(
//                                 height: Get.height*0.065,
//                                 width: Get.width*0.650,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Color(0XFFfedec5),
//                                     border: Border.all(color: common_red, width: 1),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           blurRadius: 1,
//                                           color: Color(0XFFbe765a),
//                                           spreadRadius: 1.0,
//                                           offset: Offset(0.0, 2.0)
//                                       )
//                                     ]
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Text("${SurriseLineList[index-1]}", style: font_style.Black_400_15_ff,),
//
//                               )
//                             ],
//                           ),
//                         );
//                       }else if(index== 9) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
//                                 height: Get.height*0.060,
//                                 width: Get.width*0.3,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:common_green,
//                                 ),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text("${DateLineList[index-1]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center ),
//                               ),
//                               Container(
//                                 height: Get.height*0.065,
//                                 width: Get.width*0.650,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Color(0XFFfedec5),
//                                     border: Border.all(color: common_red, width: 1),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           blurRadius: 1,
//                                           color: Color(0XFFbe765a),
//                                           spreadRadius: 1.0,
//                                           offset: Offset(0.0, 2.0)
//                                       )
//                                     ]
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Text("${SurriseLineList[index-1]}", style: font_style.Black_400_15_ff,),
//
//                               )
//                             ],
//                           ),
//                         );
//                       }else if(index== 11) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
//                                 height: Get.height*0.060,
//                                 width: Get.width*0.3,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:Colors.purple,
//                                 ),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text("${DateLineList[index-1]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center ),
//                               ),
//                               Container(
//                                 height: Get.height*0.065,
//                                 width: Get.width*0.650,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Color(0XFFfedec5),
//                                     border: Border.all(color: common_red, width: 1),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           blurRadius: 1,
//                                           color: Color(0XFFbe765a),
//                                           spreadRadius: 1.0,
//                                           offset: Offset(0.0, 2.0)
//                                       )
//                                     ]
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Text("${SurriseLineList[index-1]}", style: font_style.Black_400_15_ff,),
//
//                               )
//                             ],
//                           ),
//                         );
//                       }else if(index== 12) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
//                                 height: Get.height*0.060,
//                                 width: Get.width*0.3,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:Colors.green.shade700,
//                                 ),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text("${DateLineList[index-1]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center ),
//                               ),
//                               Container(
//                                 height: Get.height*0.065,
//                                 width: Get.width*0.650,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Color(0XFFfedec5),
//                                     border: Border.all(color: common_red, width: 1),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           blurRadius: 1,
//                                           color: Color(0XFFbe765a),
//                                           spreadRadius: 1.0,
//                                           offset: Offset(0.0, 2.0)
//                                       )
//                                     ]
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Text("${SurriseLineList[index-1]}", style: font_style.Black_400_15_ff,),
//
//                               )
//                             ],
//                           ),
//                         );
//                       } else if(index == 13){    /// chaughadia:
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Center(
//                             child: InkWell(
//                               onTap: () {
//                                 Get.to( const ChaughadiaScreen());
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(Get.width*0.010),
//                                 height: Get.height*0.080,
//                                 width: Get.width,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color:Colors.white,
//                                     border: Border.all(color: Colors.purple, width: 2)
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Container(
//                                     height: Get.height*0.075,
//                                     width: Get.width,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       color:Colors.purple,
//                                     ),
//                                     child: Text("${DateLineList[index]}",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
//                               ),
//                             ),
//                           ),
//                         );
//                       }else if(index == 14){    /// change date:
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Center(
//                             child: InkWell(
//                               onTap: (){
//                                 setState(() {
//                                   _changeDate();
//                                 });
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(Get.width*0.010),
//                                 height: Get.height*0.080,
//                                 width: Get.width,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color:Colors.white,
//                                     border: Border.all(color: Colors.green, width: 2)
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Container(
//                                     height: Get.height*0.075,
//                                     width: Get.width,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       color:Colors.green,
//                                     ),
//                                     child: Text("${DateLineList[index]}",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                       else if(index == 15){     ///Change City:
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Center(
//                             child: InkWell(
//                               onTap: (){
//                                 setState(() {
//                                   Get.to(const ChangeCityScreen());
//                                 });
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(Get.width*0.010),
//                                 height: Get.height*0.080,
//                                 width: Get.width,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color:Colors.white,
//                                     border: Border.all(color: common_red, width: 2)
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Container(
//                                     height: Get.height*0.075,
//                                     width: Get.width,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       color:common_red,
//                                     ),
//                                     child: Text("${DateLineList[index]}",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                       else if(index == 16){  ///Festivals
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Center(
//                             child: InkWell(
//                               onTap: () => Get.to(FestivalsScreen()),
//                               child: Container(
//                                 padding: EdgeInsets.all(Get.width*0.010),
//                                 height: Get.height*0.080,
//                                 width: Get.width,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color:Colors.white,
//                                     border: Border.all(color: Color(0xff1b567a), width: 2)
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Container(
//                                     height: Get.height*0.075,
//                                     width: Get.width,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       color:Color(0xff1b567a),
//                                     ),
//                                     child: Text("${DateLineList[index]}",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                       else if(index == 17){///hora
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Center(
//                             child: Container(
//                               padding: EdgeInsets.all(Get.width*0.010),
//                               height: Get.height*0.080,
//                               width: Get.width,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:Colors.white,
//                                   border: Border.all(color: Color(0xff463458), width: 2)
//                               ),
//                               alignment: Alignment.center,
//                               child: Container(
//                                   height: Get.height*0.075,
//                                   width: Get.width,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color:Color(0xff463458),
//                                   ),
//                                   child: Text("${DateLineList[index]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
//                             ),
//                           ),
//                         );
//                       }
//                       else if(index == 18){ ///
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Center(
//                             child: Container(
//                               padding: EdgeInsets.all(Get.width*0.010),
//                               height: Get.height*0.080,
//                               width: Get.width,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:Colors.white,
//                                   border: Border.all(color: Color(0xff1b567a), width: 2)
//                               ),
//                               alignment: Alignment.center,
//                               child: Container(
//                                   height: Get.height*0.075,
//                                   width: Get.width,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color:Color(0xff1b567a),
//                                   ),
//                                   child: Text("${DateLineList[index]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
//                             ),
//                           ),
//                         );
//                       }
//                       if(index == 19){
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Center(
//                             child: Container(
//                               padding: EdgeInsets.all(Get.width*0.010),
//                               height: Get.height*0.080,
//                               width: Get.width,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:Colors.white,
//                                   border: Border.all(color: Color(0xff654a24), width: 2)
//                               ),
//                               alignment: Alignment.center,
//                               child: Container(
//                                   height: Get.height*0.075,
//                                   width: Get.width,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color:Color(0xff654a24),
//                                   ),
//                                   child: Text("${DateLineList[index]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
//                             ),
//                           ),
//                         );
//                       }else if(index == 20){
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Center(
//                             child: Container(
//                               padding: EdgeInsets.all(Get.width*0.010),
//                               height: Get.height*0.080,
//                               width: Get.width,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:Colors.white,
//                                   border: Border.all(color: common_red, width: 2)
//                               ),
//                               alignment: Alignment.center,
//                               child: Container(
//                                   height: Get.height*0.075,
//                                   width: Get.width,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color:common_red,
//                                   ),
//                                   child: Text("${DateLineList[index]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center, )),
//                             ),
//                           ),
//                         );
//                       }else if(index == 21){
//                         return Center(
//                           child: Container(
//                               margin: EdgeInsets.symmetric(vertical: Get.height*0.040),
//                               height: Get.height*0.040,
//                               width: Get.width,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 // borderRadius: BorderRadius.circular(5),
//                                 color:Color(0xff980101),
//                               ),
//                               child: Text("${DateLineList[index]}",style: font_style.white_600_15_cl,textAlign: TextAlign.center, )),
//                         );
//                       }else if(index == 22){
//                         return Center(
//                           child: Container(
//                               height: Get.height*0.150,
//                               width: Get.width,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 // borderRadius: BorderRadius.circular(5),
//                                 color:Colors.purple,
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     height: Get.height,
//                                     width: Get.width*0.250,
//                                     color: Colors.red,
//                                     child: Image.asset("assets/images/photo-1517462964-21fdcec3f25b.jpg", fit: BoxFit.cover,),
//                                   ),
//                                   Container(
//                                     height: Get.height,
//                                     width: Get.width*0.750,
//                                     color: Colors.black,
//                                     alignment: Alignment.topCenter,
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         SizedBox(height: Get.height*0.020,),
//                                         Text("Reach us at:",style: font_style.white_600_20_cl,textAlign: TextAlign.center, ),
//                                         SizedBox(height: Get.height*0.010,),
//
//                                         Text("https://imagecolorpicker.com",style: font_style.white_600_20_cl,textAlign: TextAlign.center, ),
//                                         SizedBox(height: Get.height*0.010,),
//
//                                         Text("psherma@premastrologer.com",style: font_style.white_600_20_cl,textAlign: TextAlign.center, ),
//
//
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                         );
//                       }else {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: Get.height*0.010, horizontal: Get.height*0.005),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: Get.width*0.020, vertical: 0.050),
//                                 height: Get.height*0.060,
//                                 width: Get.width*0.3,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color:Color(0xffcb1505),
//                                 ),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text("${DateLineList[index-1]}:",style: font_style.white_600_20_cl,textAlign: TextAlign.center ),
//                               ),
//                               Container(
//                                 height: Get.height*0.065,
//                                 width: Get.width*0.650,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Color(0XFFfedec5),
//                                     border: Border.all(color: common_red, width: 1),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           blurRadius: 1,
//                                           color: Color(0XFFbe765a),
//                                           spreadRadius: 1.0,
//                                           offset: Offset(0.0, 2.0)
//                                       )
//                                     ]
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Text("${SurriseLineList[index-1]}", style: font_style.Black_400_15_ff,),
//                               )
//                             ],
//                           ),
//                         );
//                       }
//
//
//                     },
//                     // separatorBuilder: (context, index) {
//                     //   return SizedBox(height: Get.height*0.020,);
//                     // },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Controller extends GetxController{

  var loading  = false.obs;
  var oldResponse = Model().obs;

  TextEditingController Controller = TextEditingController();

  Future<void> Cont () async {
    try{
      loading(true);

      final newResponse = await ApiServices().fun;
      if(newResponse.responseCode == "1"){

        oldResponse = newResponse.obs;

        print("Cont called..");
        Get.snackbar(
            '',
            '${oldResponse.value.message}',
            snackPosition: SnackPosition.TOP
        );
      }else{
        oldResponse = newResponse.obs;
        Get.snackbar(
            '',
            '${oldResponse.value.message}',
            snackPosition: SnackPosition.TOP
        );
        print("Cont failed..");
      }

    }finally{
      loading(false);
    }

  }

}

///
var selectedsh_date;
var selectedsh_dateday;

Future<void> getSelectdate()async{
  SharedPreferences sh = await SharedPreferences.getInstance();
  selectedsh_date =sh.getString("selectedDate_sh");
  selectedsh_dateday =sh.getString("selectedDateday_sh");
  print("selectedDate_sh :$selectedsh_date}");
  print("selectedDateday_sh :${selectedsh_dateday}");
}




Fun(){
  Row(
      children: [
  DropdownButtonFormField(
  decoration: InputDecoration(
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
  borderSide: BorderSide(color: Colors.grey)),
  contentPadding: EdgeInsets.only(
  left: 15, right: 10, top: 8, bottom: 8),
  enabledBorder: OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
  borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
  borderSide: BorderSide(color: common_red),
  borderRadius: BorderRadius.circular(10),
  ),
  filled: true,
  fillColor: Colors.transparent,
  hintText: "Please Select Country",
  hintStyle: TextStyle(
  fontFamily: 'calibri',
  color: Colors.grey,
  fontWeight: FontWeight.w600),
  ),
  icon: _getAllCountryController.loading.value
  ? Container(
  height: Get.height * 0.030,
  width: Get.width * 0.030,
  alignment: Alignment.center,
  child: CircularProgressIndicator(
  color: common_red,
  ))
      : Icon(
  Icons.arrow_drop_down,
  color: Colors.red,
  ),
  // padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.050, right: SizeConfig.screenWidth*0.050),
  onTap: () {
  print('object');
  _getAllCountryController.getAllCountryCont();
  },
  onChanged: (String? value) {
  var index = _getAllCountryController.allCountryName
      .indexOf(value);
  print("country index :$index");
  var countryId =
  _getAllCountryController.allCountryid[index];
  print("CountryId :$countryId");
  },
  items: _getAllCountryController.allCountryName.isEmpty
  ? [
  "No Data Found",
  ].map<DropdownMenuItem<String>>((var value) {
  return DropdownMenuItem<String>(
  value: value,
  child: Container(
  // width: SizeConfig.screenWidth*0.6,
  margin:
  EdgeInsets.symmetric(horizontal: 5),
  // color: Colors.red,
  child: Row(
  children: [
  Text(
  value.toString(),
  ),
  ],
  ),
  ),
  );
  }).toList()
      : _getAllCountryController.allCountryName
      .map<DropdownMenuItem<String>>((var value) {
  return DropdownMenuItem<String>(
  value: value,
  child: Container(
  margin:
  EdgeInsets.symmetric(horizontal: 5),
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
  validator: (String? value) {
  if (value == null || value.isEmpty) {
  return 'Country is required';
  } else {
  return null; // Return null if the selected city is valid
  }
  },
  ),
  ],
  ),
  SizedBox(
  height: Get.height * 0.020,
  ),
}