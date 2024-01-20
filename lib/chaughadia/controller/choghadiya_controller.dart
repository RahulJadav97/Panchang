import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/chaughadia/model/choghadiya_model.dart';

class ChogadiyaController extends GetxController{

  var loading  = false.obs;
  var oldResponse = ChoghadiyaModel().obs;



  Future<void> choghadiyaCont () async {
    try{
      loading(true);

      final newResponse = await ApiServices().getChoghadiya(currentDate.toString(),currentMonth.toString(),currentYear.toString());
      if(newResponse.responseCode == 1){
        oldResponse = newResponse.obs;
        print("Choghadiya Data Cont Successful");
      }else{
        print("Choghadiya Data Cont failed..");
      }
    }finally{
      loading(false);
    }

  }
  var currentDate;
  var currentDay;
  var currentMonth;
  var currentYear;
  void getCurrentDate() async {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(now);
    currentDate = formattedDate;

    // Split the formatted date into day, month, and year
    List<String> dateComponents = formattedDate.split('-');

    // Extract day, month, and year from the list
    String day = dateComponents[0];
    String month = dateComponents[1];
    String year = dateComponents[2];
    currentDate = formattedDate;
    currentDay = day;
    currentMonth = month;
    currentYear = year;
    print("currentDay $currentDay");
    print("currentMonth $currentMonth");
    print("currentYear $currentYear");
  }
  @override
  void onInit() {
    getCurrentDate();
    choghadiyaCont ();
    super.onInit();
  }

}