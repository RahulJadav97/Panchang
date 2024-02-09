import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/Predictions/model/WeeklyPredictionModel.dart';

class WeeklyPredictionController extends GetxController{

  var loading = false.obs;
  var oldResponse = WeeklyPredictionModel().obs;

  List allDataweekly = [];

  Future<void> weeklyPredictionCont () async {

    try{
      loading(true);

      final new_response = await ApiServices().weeklyPrediction();

      if(new_response.responseCode == 1){
        oldResponse = new_response.obs;
        // Get.snackbar("", "${oldResponse.value.responseMessage.toString()}");
        print("weeklyPredictionCont sucessfully called...");

        allDataweekly.clear();
        oldResponse.value.data!.forEach((element) {
          allDataweekly.add(element);
        });
        var allDataweeklyLength = allDataweekly.length;
        print("allDataweeklyLength :$allDataweeklyLength");

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