import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/auth/model/GetDistrictByStateModel.dart';
import 'package:panchang/auth/model/GetStateByCountryModel.dart';

class GetDistrictByStateController extends GetxController{

  var loading = false.obs;
  var old_response = GetDistrictByStateModel().obs;

  List<String> allDistrictName = [];
  List allDistrictId = [];

  Future<void> getDistrictByStateCont (StateId) async {
    try{
      loading(true);

      final new_response = await ApiServices().getDistrictByState(StateId);
      if(new_response.responseCode == "1"){
        old_response = new_response.obs;

        allDistrictId.clear();
        allDistrictName.clear();
        old_response.value.district!.forEach((element) {
          allDistrictId.add(element.id);
          allDistrictName.add(element.name.toString());
        });
        print("getDistrictByState called..");
      }
      else{
        print("getDistrictByState failed..");
      }
    }finally{
      loading(false);
    }
  }

}