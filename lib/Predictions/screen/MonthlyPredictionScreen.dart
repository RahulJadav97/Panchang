import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:panchang/Predictions/Controller/MonthlyPredictionController.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';

class MonthlyPredictionScreen extends StatefulWidget {
  const MonthlyPredictionScreen({super.key});

  @override
  State<MonthlyPredictionScreen> createState() => _MonthlyPredictionScreenState();
}

class _MonthlyPredictionScreenState extends State<MonthlyPredictionScreen> {

  MonthlyPredictionController _monthlyPredictionCont_obj = Get.put(MonthlyPredictionController());

  @override
  void initState() {
    _monthlyPredictionCont_obj.monthlyPredictionCont();
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
                child:_monthlyPredictionCont_obj.loading.value?Center(child: CircularProgressIndicator(color: common_red,))
                    :
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: Get.width*0.020),
                      height: Get.height*0.050,
                      width: Get.width,
                      color: Colors.grey.shade700,
                      alignment: Alignment.centerLeft,
                      child: Text("Monthly Prediction", style:font_style.White_700_18_ff ,),

                    ),
                    // SizedBox(height: Get.height*0.020,),

                    _monthlyPredictionCont_obj.allDataMonthly.length == 0
                        ?
                    Expanded(child: Container(
                      alignment: Alignment.center,
                      child: Text("No Monthly Predictions Found..", style: font_style.Black_500_18_ff,),
                    ))
                        :
                    Expanded(
                      child: Container(
                        // color: Colors.grey.shade300,
                        child: ListView.separated(
                          itemCount: _monthlyPredictionCont_obj.allDataMonthly.length,
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
                                    child: Text("${_monthlyPredictionCont_obj.oldResponse.value.data![index].sunsignName.toString()}",
                                      style: TextStyle(color: common_red,fontSize: 15,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(Get.width*0.010),
                                    width: Get.width,
                                    // color: Colors.blue,
                                    child: Text(_monthlyPredictionCont_obj.oldResponse.value.data![index].description.toString(),
                                      style: font_style.Black_700_15_ff,/*textAlign: TextAlign.center,*/),
                                  ),
                                  _monthlyPredictionCont_obj.oldResponse.value.data![index].luckyDays != ""?
                                  Container(
                                    padding: EdgeInsets.all(Get.width*0.010),
                                    width: Get.width,
                                    // color: Colors.blue,
                                    child: Row(
                                      children: [
                                        Text("${_monthlyPredictionCont_obj.oldResponse.value.data![index].luckyDays.toString()}", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                                        Text("-${_monthlyPredictionCont_obj.oldResponse.value.data![index].luckyMonths.toString()}", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ):SizedBox(),
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
                                        padding: EdgeInsets.all( Get.width*0.020),
                                        child: Text("Lucky Number : ${_monthlyPredictionCont_obj.oldResponse.value.data![index].luckyNumber.toString()}", style: font_style.Black_bold_15_ff,),
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
                                        padding: EdgeInsets.all( Get.width*0.020),
                                        child: Text("Lucky Colour: ${_monthlyPredictionCont_obj.oldResponse.value.data![index].luckyColor.toString()}", style: font_style.Black_bold_15_ff,),
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
