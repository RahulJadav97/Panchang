import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/festivals/model/festival_date_model.dart';

class FestivalDateList extends GetxController{

  var loading1 = false.obs;
  var oldResponse = FestivalDateModel().obs;

  List FestivalData = [];

  // int? allDataLength;

  Future<void> festivalDateCont () async {

    try{
      loading1(true);

      final new_response = await ApiServices().festivalDate();

      if(new_response.responseCode == 1){
        oldResponse = new_response.obs;
        // Get.snackbar("", "${oldResponse.value.responseMessage.toString()}");
        print("festivalDate successfully called...");

        FestivalData.clear();
        oldResponse.value.data!.forEach((element) {
          FestivalData.add(element);
        });

        print("FestivalData ${FestivalData.length}");
        loading1(false);

      }else{
        oldResponse = new_response.obs;
        print("FestivalData Cont failed...");
        // Get.snackbar("", "${oldResponse.value.responseMessage.toString()}");
      }

    }catch(e){
      print("Error FestivalData:$e");
      loading1(false);
    }finally{
      loading1(false);
    }

  }

}