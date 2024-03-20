import 'package:get/get.dart';
import 'package:panchang/Significance/model/month_significanse_model.dart';

import '../../Apiservices/api_services.dart';

class MonthlySignificanceController extends GetxController{

  var loading = false.obs;
  var oldResponse = MonthSignificanceModel().obs;

  List<Data> allMonthlySignificance = [];

  Future<void> monthlySignificanceCont (month) async {

    try{
      loading(true);

      final new_response = await ApiServices().monthlySignificance(month);

      if(new_response.responseCode == 1){
        oldResponse = new_response.obs;
        print("monthlyPredictionCont sucessfully called...");

        allMonthlySignificance.clear();
        oldResponse.value.data!.forEach((element) {
          allMonthlySignificance.add(element);
        });
        var allDataMonthlyLength = allMonthlySignificance.length;
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