import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/auth/model/GetCityByDistrictModel.dart';
import 'package:panchang/auth/model/GetDistrictByStateModel.dart';
import 'package:panchang/auth/model/GetStateByCountryModel.dart';

class GetCityByDistrictController extends GetxController{

  var loading = false.obs;
  var old_response = GetCityByDistrictModel().obs;

  List allCityName = [];
  List allCityId = [];

  Future<void> getCityByDistrictCont (DistrictId) async {
    try{
      loading(true);

      final new_response = await ApiServices().getCityByDistrict(DistrictId);
      if(new_response.responseCode == "1"){
        old_response = new_response.obs;

        allCityId.clear();
        allCityName.clear();
        old_response.value.city!.forEach((element) {
          allCityId.add(element.id);
          allCityName.add(element.name.toString());
        });
        print("getCityByDistrictCont called..");
      }
      else{
        print("getCityByDistrictCont failed..");
      }
    }finally{
      loading(false);
    }
  }

}