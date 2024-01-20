import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/changecity/model/city_data_model.dart';

class CityDataController extends GetxController{

  var loading  = false.obs;
  var oldResponse = CityDataModel().obs;

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

}