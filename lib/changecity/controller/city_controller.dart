import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/changecity/model/city_model.dart';

class CityController extends GetxController{

  var loading  = false.obs;
  var oldResponse = CityModel().obs;

  List<String> allCityName = [];
  List<String> CityRowId = [];

  Future<void> cityCont () async {
    try{
      loading(true);

      final newResponse = await ApiServices().getCity();
      if(newResponse.responseCode == 1){
        oldResponse = newResponse.obs;

        allCityName.clear();
        CityRowId.clear();
        oldResponse.value.data!.forEach((element) {
          allCityName.add(element.place.toString());
          CityRowId.add(element.rowid.toString());
        });


      }else{
        print("City Cont failed..");
      }
    }finally{
      loading(false);
    }

  }

}