import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/festivals/model/festival_model.dart';

class FestivalController extends GetxController{

  var loading  = false.obs;
  var oldResponse = FestivalModel().obs;


  List<FestivalModel> festivalList = [];

  Future<void> festivalCont() async {
    try {
      loading(true);
      Dio dio = Dio();
      final response = await dio.get('https://festivals.premastrologer.com/api_custom_fastival.php'); // Replace with your API endpoint

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        festivalList.clear();
        List<FestivalModel> festivals = data.map((json) => FestivalModel.fromJson(json)).toList();
        festivalList = festivals;
        print("object: ${festivalList.length}");

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
    // TODO: implement onInit
    super.onInit();
  }
}