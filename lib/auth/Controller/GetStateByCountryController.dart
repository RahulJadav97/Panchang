import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/auth/model/GetStateByCountryModel.dart';

class GetStateByCountryroller extends GetxController{

  var loading = false.obs;
  var old_response = GetStateByCountryModel().obs;

  List allstateName = [];
  List allstateid = [];

  Future<void> getStateByCountry (CountryId) async {
    try{
      loading(true);

      final new_response = await ApiServices().getStateByCountry(CountryId);
      if(new_response.responseCode == "1"){
        old_response = new_response.obs;

        allstateid.clear();
        allstateName.clear();
        old_response.value.state!.forEach((element) {
          allstateid.add(element.id);
          allstateName.add(element.name.toString());
        });
        print("getStateByCountry called..");
      }
      else{
        print("getStateByCountry failed..");
      }
    }finally{
      loading(false);
    }
  }

}