import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/festivals/screen/festival_web_view.dart';
import 'package:panchang/grahan/controller/grahan_controller.dart';

class GrahanScreen extends StatefulWidget {
  var year;
  GrahanScreen({super.key, required this.year});

  @override
  State<GrahanScreen> createState() => _GrahanScreenState();
}

class _GrahanScreenState extends State<GrahanScreen> {
  var grahan = Get.put(GrahanController());

  List yearss = [
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
  ];

  var currentY;
  @override
  void initState() {
    print("FFFFFFFFFFFFFFFFFF   $currentY");
    DateTime dateTime = DateFormat("dd-MM-yyyy").parse(widget.year.toString());
    int year = dateTime.year;
    currentY = year.toString();
    grahan.grahanCont("${year}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: common_red,
        title: Text(
          "Eclipse",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: yearss.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentY = yearss[index];
                        grahan.grahanCont("${currentY}");
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      height: Get.height * 0.06,
                      width: Get.width,
                      child: Text(
                        "${yearss[index]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  currentY == yearss[index]
                      ? Obx(
                        () => grahan.loading.value
                        ? Center(
                      child: CircularProgressIndicator(
                        color: common_red,
                      ),
                    )
                        : Container(
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        itemCount: grahan.grahanList.length,
                        itemBuilder: (BuildContext context,
                            int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                // Get.to(()=>FestivalWebScreen(webUrl: "${grahan.grahanList[index].link}",));
                              },
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: common_red,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "${grahan.grahanList[index].title}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "Date: ${grahan.grahanList[index].date}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.w300,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: "Description",
                                            titleStyle: TextStyle(color: common_red),
                                            content: Container(
                                              height: Get.height * 0.8,
                                              width: Get.width,
                                              child: SingleChildScrollView(
                                                scrollDirection:Axis.vertical ,
                                                child: Text(
                                                  "${grahan.grahanList[index].description}",
                                                  style: TextStyle(
                                                    color: common_red,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Know more",
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                      : SizedBox()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
