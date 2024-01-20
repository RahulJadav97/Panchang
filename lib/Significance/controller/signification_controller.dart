import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/Significance/model/significance_model.dart';

class SignificanceController extends GetxController{

  var loading = false.obs;
  var oldResponse = SignificanceModel().obs;

  List<Data> significationList = [];

  Future<void> significanceCont () async {

    try{
      loading(true);

      final new_response = await ApiServices().significance();

      if(new_response.responseCode == 1){
        oldResponse = new_response.obs;
        significationList.clear();
        new_response.data!.forEach((element) {
          significationList.add(element);
          // print(countries);
        });
        print("Significance successfully called...");


      }else{
        print("dailyPredictionCont failed...");
      }

    }catch(e){
      print("Error:$e");
      loading(false);
    }finally{
      loading(false);
    }

  }

}