import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/auth/model/delete_account_model.dart';
import 'package:panchang/changecity/model/city_data_model.dart';

class CityDataController extends GetxController{

  var loading  = false.obs;
  var del_loading  = false.obs;
  var oldResponse = CityDataModel().obs;
  var Response = DeleteAccountModel().obs;

  Future<void> cityDataCont () async {
    try{
      loading(true);

      final newResponse = await ApiServices().getCityData();
      if(newResponse.responseCode == 1){
        oldResponse = newResponse.obs;

      }else{
        print("City Data Cont failed..");
      }
    }finally{
      loading(false);
    }

  }

  Future<void> deleteAccountCont() async {
    try{
      del_loading(true);
      final newResponse = await ApiServices().delete_account();
      if(newResponse.responseCode == 1){
        Response = newResponse.obs;
        // Get.back();
      }else{
        print("City Data Cont failed..");
      }
    }finally{
      del_loading(false);
    }

  }

}