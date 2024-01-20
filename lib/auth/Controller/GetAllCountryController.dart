import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/auth/model/GetAllCountryModel.dart';

class GetAllCountryController extends GetxController{

  var loading = false.obs;
  var old_response = GetAllCountryModel().obs;

  List allCountryName = [];
  List allCountryid = [];

  Future<void> getAllCountryCont () async {
    try{
      loading(true);

      final new_response = await ApiServices().getAllCountry();
      if(new_response.responseCode == "1"){
        old_response = new_response.obs;

        allCountryid.clear();
        allCountryName.clear();
        old_response.value.country!.forEach((element) {
          allCountryid.add(element.id);
          allCountryName.add(element.name.toString());
        });
        print("getAllCountryCont called..");
      }
      else{
        print("getAllCountryCont failed..");
      }
    }finally{
      loading(false);
    }
  }

}