
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';
import 'package:panchang/festivals/controller/festival_controller.dart';
import 'package:panchang/festivals/model/festival_model.dart';

import 'festival_web_view.dart';
class FestivalSearchScreen extends StatefulWidget {
  const FestivalSearchScreen({super.key});

  @override
  State<FestivalSearchScreen> createState() => _FestivalSearchScreenState();
}

class _FestivalSearchScreenState extends State<FestivalSearchScreen> {

  FestivalController festivalController = Get.put(FestivalController());
  List<FestivalModel> festivalListSearch = [];
  final FocusNode _focusnode = FocusNode();
  TextEditingController _searchCTC = TextEditingController();
  @override
  void initState() {
    festivalController.festivalCont();
    print("length:${festivalController.oldResponse.value.title}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: common_backcolor,
        body:Obx(() => festivalController.loading.value?Center(child: CircularProgressIndicator(color: common_red,),):
        Container(
          height: Get.height,
          width: Get.width,
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         fit: BoxFit.cover,
          //         image: AssetImage("assets/images/texture3.jpg",)
          //     )
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: Get.width*0.020),
                  height: Get.height*0.050,
                  width: Get.width,
                  color: Colors.grey.shade700,
                  alignment: Alignment.centerLeft,
                  child: Text("Search Festival ", style:font_style.White_700_18_ff ,),

                ),
                SizedBox(height: Get.height*0.020,),
                Padding(
                  padding:  EdgeInsets.all( Get.width*0.010),
                  child: Container(
                    alignment: Alignment.center,
                    height: Get.height*0.055,
                    width: Get.width,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          festivalListSearch = festivalController.festivalList.where((element) => element.title.toString().toLowerCase().contains(value.toLowerCase())).toList();
                          if(_searchCTC.text.isNotEmpty && festivalListSearch.isEmpty){
                            print("Items Lenght ${festivalListSearch.length}");
                          }
                        });
                      },
                      controller: _searchCTC,
                      focusNode: _focusnode,
                      autofocus: false,
                      textAlign: TextAlign.start,
                      // controller: _searchController,
                      style:TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20,fontFamily: 'calibri') ,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                          hintText: "Search Festival",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(Get.width*0.030),

                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color:  Colors.grey, width: 2)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color:  Colors.grey, width: 2)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.020,),
                Container(
                  height: Get.height*0.8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:_searchCTC.text.isNotEmpty?festivalListSearch.length:
                    festivalController.festivalList.length,
                      itemBuilder:( BuildContext context,int index ){
                      return InkWell(
                        onTap: (){
                          Get.to(()=>FestivalWebScreen(webUrl:_searchCTC.text.isNotEmpty?festivalListSearch[index].link.toString():festivalController.festivalList[index].link.toString(),));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            height: Get.height*0.20,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey,width: 2)
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: Get.height*0.17,
                                        width: Get.width*0.25,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: common_red,width: 2),
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child:Image.network("${ festivalController.festivalList[index].image.toString()}"),
                                        // CachedNetworkImage(
                                        //   imageUrl: festivalController.festivalList[index].image.toString(), // Replace with your image URL
                                        //   placeholder: (context, url) => Center(child: CupertinoActivityIndicator(color: common_red,)), // Placeholder widget while loading
                                        //   errorWidget: (context, url, error) => Icon(Icons.error), // Widget to display in case of an error
                                        //   fit: BoxFit.cover, // Set the fit mode
                                        // ),
                                      ),
                                      SizedBox(width: Get.width*0.02,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          /// festival name
                                          Row(
                                            children: [
                                              Text("Title : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                              SizedBox(
                                                  width: Get.width*0.54,
                                                  height: Get.height*0.03,
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                      child: Text("${_searchCTC.text.isNotEmpty?festivalListSearch[index].title.toString(): festivalController.festivalList[index].title != ""?festivalController.festivalList[index].title:""}",style: TextStyle(color: common_red,fontWeight: FontWeight.w400),)))
                                            ],
                                          ),
                                          SizedBox(height: Get.height*0.01,),
                                          /// festival date
                                          Row(
                                            children: [
                                              Text("Date : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),),
                                              Text("${festivalController.festivalList[index].date != ""?festivalController.festivalList[index].date:""}",style: TextStyle(color: common_red,fontWeight: FontWeight.w200),)
                                            ],
                                          ),
                                          SizedBox(height: Get.height*0.01,),
                                          /// festival details
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Description : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),),
                                              Container(
                                                  height: Get.height*0.08,
                                                  width: Get.width*0.64,
                                                  child: SingleChildScrollView(
                                                      scrollDirection: Axis.vertical,
                                                      child: Text("${festivalController.festivalList[index].description != ""?festivalController.festivalList[index].description:""}",style: TextStyle(color: common_red,fontWeight: FontWeight.w200),)))
                                            ],
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                      },
                  ),
                )
              ],
            ),
          ),
        ),
        )

      ),
    );
  }
}
