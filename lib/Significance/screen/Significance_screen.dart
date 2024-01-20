import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panchang/Significance/controller/signification_controller.dart';
import 'package:panchang/Significance/model/significance_model.dart';
import 'package:panchang/common/common_colour.dart';

class SignificanceScreen extends StatefulWidget {
  const SignificanceScreen({super.key});

  @override
  State<SignificanceScreen> createState() => _SignificanceScreenState();
}

class _SignificanceScreenState extends State<SignificanceScreen> {

  SignificanceController significance = Get.put(SignificanceController());
  List<Data> significationListSearch = [];
  final FocusNode _focusnode = FocusNode();
  TextEditingController _searchCTC = TextEditingController();

  @override
  void initState() {
    significance.significanceCont();
        super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: common_red,
        title: Text("Significance",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body:Obx(() => significance.loading.value?Center(child: CircularProgressIndicator(color: common_red,),):
      Column(
        children: [
          SizedBox(height: Get.height*0.02,),
          Padding(
            padding:  EdgeInsets.all( Get.width*0.010),
            child: Container(
              alignment: Alignment.center,
              height: Get.height*0.06,
              width: Get.width,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    significationListSearch = significance.significationList.where((element) => element.title.toString().toLowerCase().contains(value.toLowerCase())).toList();
                    significationListSearch = significance.significationList.where((element) => element.date.toString().toLowerCase().contains(value.toLowerCase())).toList();
                    if(_searchCTC.text.isNotEmpty && significationListSearch.isEmpty){
                      print("Items Lenght ${significationListSearch.length}");
                    }
                  });
                },
                cursorColor: common_red,
                controller: _searchCTC,
                focusNode: _focusnode,
                autofocus: false,
                textAlign: TextAlign.start,
                // controller: _searchController,
                style:TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20,fontFamily: 'calibri') ,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: "Search Signification",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(Get.width*0.030),

                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color:  common_red, width: 2)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:  BorderSide(color:common_red, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color:common_red, width: 2)
                    )
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height*0.02,),
          Expanded(
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                itemCount:_searchCTC.text.isNotEmpty?significationListSearch.length: significance.oldResponse.value.data!.length,
                  itemBuilder: (BuildContext context ,int index){
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: common_red,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Title:${_searchCTC.text.isNotEmpty?significationListSearch[index].title != null?significationListSearch[index].title:"Title Not Found": significance.oldResponse.value.data![index].title != null?significance.oldResponse.value.data![index].title:"Title Not Found"}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),),
                            Text("Date: ${_searchCTC.text.isNotEmpty?significationListSearch[index].date != null?significationListSearch[index].date:"Date Not Found": significance.oldResponse.value.data![index].date != null?significance.oldResponse.value.data![index].date:"Date Not Found"}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w200,fontSize: 15),),
                          ],
                        ),
                      ),
                    ),
                  );
                  }
              ),
            ),
          )

        ],
      ),
      )

    );
  }
}
