import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';

import 'tithi_model.dart';

class TithiController extends GetxController{

  var loading = false.obs;
  var oldResponse = TithiModel().obs;

  List allDateTithi = [];
  List allDateTithiColor = [];

  Future<void> tithiCont (tmonth,tyear) async {

    try{
      loading(true);

      final new_response = await ApiServices().tithi(tmonth, tyear);

      if(new_response.responseCode == "1"){
        oldResponse = new_response.obs;
        // Get.snackbar("", "${oldResponse.value.responseMessage.toString()}");
        print("Tithi sucessfully called...");

        allDateTithi.clear();
        allDateTithiColor.clear();
        oldResponse.value.data!.forEach((element) {
          allDateTithi.add(element.value);
        });
        oldResponse.value.data!.forEach((element) {
          allDateTithiColor.add(element.dateColor);
        });
        allDateTithi.add("hello");
        print("allDateTithi $allDateTithi");
        print("allDateTithiColor $allDateTithiColor");

        loading(false);

      }else{
        oldResponse = new_response.obs;
        print("weeklyPredictionCont failed...");
        // Get.snackbar("", "${oldResponse.value.responseMessage.toString()}");
      }

    }catch(e){
      print("Error:$e");
      loading(false);
    }finally{
      loading(false);
    }

  }

}