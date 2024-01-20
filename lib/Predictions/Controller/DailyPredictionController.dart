import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/Predictions/model/DailyPredictionModel.dart';

class DailyPredictionController extends GetxController{

  var loading = false.obs;
  var oldResponse = DailyPredictionModel().obs;

  List allData = [];
  // int? allDataLength;

  Future<void> dailyPredictionCont () async {

    try{
      loading(true);

      final new_response = await ApiServices().dailyPrediction();

      if(new_response.responseCode == 1){
        oldResponse = new_response.obs;
        // Get.snackbar("", "${oldResponse.value.responseMessage.toString()}");
        print("dailyPredictionCont sucessfully called...");

        allData.clear();
        oldResponse.value.data!.forEach((element) {
          allData.add(element);
        });
        var allDataLength = allData.length;
        print("allDataLength :$allDataLength");

        loading(false);

      }else{
        oldResponse = new_response.obs;
        print("dailyPredictionCont failed...");
        Get.snackbar("", "${oldResponse.value.responseMessage.toString()}");
      }

    }catch(e){
      print("Error:$e");
      loading(false);
    }finally{
      loading(false);
    }

  }

}