import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/Predictions/model/DailyPredictionModel.dart';
import 'package:panchang/Predictions/model/MonthlyPredictionModel.dart';

class MonthlyPredictionController extends GetxController{

  var loading = false.obs;
  var oldResponse = MonthlyPredictionModel().obs;

  List allDataMonthly = [];

  Future<void> monthlyPredictionCont () async {

    try{
      loading(true);

      final new_response = await ApiServices().monthlyPrediction();

      if(new_response.responseCode == 1){
        oldResponse = new_response.obs;
        // Get.snackbar("", "${oldResponse.value.responseMessage.toString()}");
        print("monthlyPredictionCont sucessfully called...");

        allDataMonthly.clear();
        oldResponse.value.data!.forEach((element) {
          allDataMonthly.add(element);
        });
        var allDataMonthlyLength = allDataMonthly.length;
        print("allDataMonthlyLength :$allDataMonthlyLength");

        loading(false);

      }else{
        oldResponse = new_response.obs;
        print("monthlyPredictionCont failed...");
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