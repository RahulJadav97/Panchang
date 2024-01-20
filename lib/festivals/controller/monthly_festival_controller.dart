import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/festivals/model/festival_model.dart';
import 'package:panchang/festivals/model/monthly_festival_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonthlyFestivalController extends GetxController{

  var loading  = false.obs;
  var oldResponse = MonthlyFestivalModel().obs;


  List<MonthlyFestivalModel> monthFestivalList = [];
  
  RxString monthNo = ''.obs;

  Future<void> monthlyFestivalCont(val) async {
    try {
      loading(true);
      Dio dio = Dio();
      final response = await dio.get('https://festivals.premastrologer.com/api_month_fastival.php?month=$val'); // Replace with your API endpoint

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        monthFestivalList.clear();
        List<MonthlyFestivalModel> festivals = data.map((json) => MonthlyFestivalModel.fromJson(json)).toList();
        monthFestivalList = festivals;
        print("object: ${monthFestivalList.length}");

      } else {

        loading(false);
        // Handle error
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      loading(false);
      // Handle exceptions
      print("Exception: $e");
    }
    finally{
      loading(false);
    }
  }
  @override
  void onInit() {
    super.onInit();
  }

}