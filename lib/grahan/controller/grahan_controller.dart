import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:panchang/grahan/model/grahan_model.dart';

class GrahanController extends GetxController{

  var loading  = false.obs;
  var oldResponse = GrahanModel().obs;


  List<GrahanModel> grahanList = [];

  Future<void> grahanCont(year) async {
    try {
      loading(true);
      Dio dio = Dio();
      final response = await dio.get('https://www.premastrologer.com/bk_21sep2017/api_month_grahan.php?Y=${year}'); // Replace with your API endpoint

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        grahanList.clear();
        List<GrahanModel> festivals = data.map((json) => GrahanModel.fromJson(json)).toList();
        grahanList = festivals;
        print("object: ${grahanList.length}");

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