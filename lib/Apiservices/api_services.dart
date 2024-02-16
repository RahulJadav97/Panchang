import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panchang/Hora/model/hora_model.dart';
import 'package:panchang/Panchang_Model_controller/Model/PanchangModel.dart';
import 'package:panchang/Predictions/model/DailyPredictionModel.dart';
import 'package:panchang/Predictions/model/MonthlyPredictionModel.dart';
import 'package:panchang/Predictions/model/WeeklyPredictionModel.dart';
import 'package:panchang/Significance/model/significance_model.dart';
import 'package:panchang/auth/model/AddUserModel.dart';
import 'package:panchang/auth/model/GetAllCountryModel.dart';
import 'package:panchang/auth/model/GetCityByDistrictModel.dart';
import 'package:panchang/auth/model/GetDistrictByStateModel.dart';
import 'package:panchang/auth/model/GetStateByCountryModel.dart';
import 'package:panchang/auth/model/LoginUserModel.dart';
import 'package:panchang/changecity/model/city_data_model.dart';
import 'package:panchang/changecity/model/city_model.dart';
import 'package:panchang/chaughadia/model/choghadiya_model.dart';
import 'package:panchang/common/common_base_url.dart';
import 'package:panchang/common/common_sharedprefrence.dart';
import 'package:panchang/festivals/model/festival_date_model.dart';
import 'package:panchang/festivals/model/festival_model.dart';
import 'package:panchang/tithi/tithi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServices{

  final dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));


  //getAllCountry
  Future<GetAllCountryModel> getAllCountry ()async {
    FormData userForm = FormData();
    
    final userValue = await dio.get("$baseUrl/GetAllCountry");
    if(userValue.statusCode == 200){
      final result = GetAllCountryModel.fromJson(userValue.data);
      print("getAllCountry api called..");
      return result;
    }else{
      print("getAllCountry api failed..");
      throw "Something Went Wrong..";
    }

  }

  //GetStateByCountry
  Future<GetStateByCountryModel> getStateByCountry (CountryId)async {
    FormData userForm = FormData();
    
    userForm.fields.add(MapEntry("CountryId", CountryId));

    final userValue = await dio.post("$baseUrl/GetStateByCountry", data: userForm);
    if(userValue.statusCode == 200){
      final result = GetStateByCountryModel.fromJson(userValue.data);
      print("getStateByCountry api called..");
      return result;
    }else{
      print("getStateByCountry api failed..");
      throw "Something Went Wrong..";
    }

  }

  //GetDistrictByState
  Future<GetDistrictByStateModel> getDistrictByState (StateId)async {
    FormData userForm = FormData();

    userForm.fields.add(MapEntry("StateId", StateId));

    final userValue = await dio.post("$baseUrl/GetDistrictByState", data: userForm);
    if(userValue.statusCode == 200){
      final result = GetDistrictByStateModel.fromJson(userValue.data);
      print("getDistrictByState api called..");
      return result;
    }else{
      print("getDistrictByState api failed..");
      throw "Something Went Wrong..";
    }

  }

  //GetCityByDistrict
  Future<GetCityByDistrictModel> getCityByDistrict (DistrictId)async {
    FormData userForm = FormData();

    userForm.fields.add(MapEntry("DistrictId", DistrictId));

    final userValue = await dio.post("$baseUrl/GetCityByDistrict", data: userForm);
    if(userValue.statusCode == 200){
      final result = GetCityByDistrictModel.fromJson(userValue.data);
      print("getDistrictByState api called..");
      return result;
    }else{
      print("getDistrictByState api failed..");
      throw "Something Went Wrong..";
    }

  }

  //AddUser
  Future<AddUserModel> addUser (FullName, MobileNo, Email,Country,State, District,City,BirthDate,Password )async {
    FormData userForm = FormData();

    userForm.fields.add(MapEntry("FullName", FullName));
    userForm.fields.add(MapEntry("MobileNo", MobileNo));
    userForm.fields.add(MapEntry("Email", Email));
    userForm.fields.add(MapEntry("Country", Country));
    userForm.fields.add(MapEntry("State", State));
    userForm.fields.add(MapEntry("District", District));
    userForm.fields.add(MapEntry("City", City));
    userForm.fields.add(MapEntry("BirthDate", BirthDate));
    userForm.fields.add(MapEntry("Password", Password));

    final userValue = await dio.post("$baseUrl/AddUser", data: userForm);
    if(userValue.statusCode == 200){
      final result = AddUserModel.fromJson(userValue.data);
      print("addUser api called..");
      return result;
    }else{
      print("addUser api failed..");
      throw "Something Went Wrong..";
    }
  }


  Future<LoginUserModel> loginUser (Email,Password )async {
    FormData userForm = FormData();

    userForm.fields.add(MapEntry("Email", Email));
    userForm.fields.add(MapEntry("Password", Password));

    final userValue = await dio.post("$baseUrl/LoginUser", data: userForm);
    if(userValue.statusCode == 200){
      final result = LoginUserModel.fromJson(userValue.data);
      print("loginUser api called..");
      return result;
    }else{
      print("loginUser api failed..");
      throw "Something Went Wrong..";
    }

  }


  Future<PanchangModel> panchangApi (
      // dd,
      // mm,
      // yy,
      popupDatepicker,
      mycity,
      subcat,
      LatDeg,
      LatMin,
      LonDeg,
      LonMin,
      East,
      ZHour,
      ZMin,
      DST,
      WAR,
      Hour,
      Min,
      txtnm,
      Day,
      Month,
      Year,
      Asc,
      Asc2,
      AYNS,
      as,
      moon


      )async {

    print("====================================api open====================================================");
    SharedPreferences sh = await SharedPreferences.getInstance();

    print("dd:${sh.getString("sh_selectedDay")}");
    print("mm:${sh.getString("sh_selectedMonth")}");
    print("yy:${sh.getString("sh_selectedYear")}");
    print("popupDatepicker :$popupDatepicker");
    print("mycity :${sh.getString("sh_selectedCity")}");
    print("subcat :$subcat");
    print("LatDeg :${sh.getString("sh_selectedLtdDeg")}");
    print("LatMin :${sh.getString("sh_selectedLtdMin")}");
    print("LonDeg :${sh.getString("sh_selectedLongDeg")}");
    print("LonMin :${sh.getString("sh_selectedLongMin")}");
    print("East :${sh.getString("sh_selectedDirectionEast")}");
    print("ZHour :${sh.getString("sh_selectedZHour")}");
    print("ZMin :${sh.getString("sh_selectedZMin")}");
    print("DST :${sh.getString("sh_selectedDst")}");
    print("WAR :${sh.getString("sh_selectedWar")}");
    print("Hour :$Hour");
    print("Min :$Min");
    print("txtnm :$txtnm");
    print("Day :$Day");
    print("Month :$Month");
    print("Year :$Year");
    print("Asc :$Asc");
    print("Asc2 :$Asc2");
    print("AYNS :$AYNS");
    print("as :$as");
    print("moon :$moon");
    print("====================================api close====================================================");


    FormData userForm = FormData();

    // SharedPreferences sh = await SharedPreferences.getInstance();

    userForm.fields.add(MapEntry("dd","${sh.getString("sh_selectedDay")}"));
    userForm.fields.add(MapEntry("mm","${sh.getString("sh_selectedMonth")}"));
    userForm.fields.add(MapEntry("yy","${sh.getString("sh_selectedYear")}"));
    userForm.fields.add(MapEntry("popupDatepicker",popupDatepicker));
    userForm.fields.add(MapEntry("mycity","${sh.getString("sh_selectedCity")}"));
    userForm.fields.add(MapEntry("subcat",subcat));
    userForm.fields.add(MapEntry("LatDeg","${sh.getString("sh_selectedLtdDeg")}"));
    userForm.fields.add(MapEntry("LatMin","${sh.getString("sh_selectedLtdMin")}"));
    userForm.fields.add(MapEntry("LonDeg","${sh.getString("sh_selectedLongDeg")}"));
    userForm.fields.add(MapEntry("LonMin","${sh.getString("sh_selectedLongMin")}"));
    userForm.fields.add(MapEntry("East","${sh.getString("sh_selectedDirectionEast")}"));
    userForm.fields.add(MapEntry("ZHour"," ${sh.getString("sh_selectedZHour")}"));
    userForm.fields.add(MapEntry("ZMin","${sh.getString("sh_selectedZMin")}"));
    userForm.fields.add(MapEntry("DST","${sh.getString("sh_selectedDst")}"));
    userForm.fields.add(MapEntry("WAR","${sh.getString("sh_selectedWar")}"));
    userForm.fields.add(MapEntry("Hour"," ${sh.getString("sh_selectedZHour")}"));
    userForm.fields.add(MapEntry("Min","${sh.getString("sh_selectedZMin")}"));
    userForm.fields.add(MapEntry("txtnm",txtnm));
    userForm.fields.add(MapEntry("Day","${sh.getString("sh_selectedDay")}"));
    userForm.fields.add(MapEntry("Month","${sh.getString("sh_selectedMonth")}"));
    userForm.fields.add(MapEntry("Year","${sh.getString("sh_selectedYear")}"));
    userForm.fields.add(MapEntry("Asc","Scorpio"));
    userForm.fields.add(MapEntry("Asc2","7"));
    userForm.fields.add(MapEntry("AYNS","-24.19068856852845"));
    userForm.fields.add(MapEntry("as","225.28462936543343"));
    userForm.fields.add(MapEntry("moon","44.48635698113049"));

    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_panchang.php", data: userForm);
    if(userValue.statusCode == 200){
      final result = PanchangModel.fromJson(userValue.data);
      print("panchangApi api called..");
      return result;
    }else{
      print("panchangApi api failed..");
      throw "Something Went Wrong..";
    }

  }
  Future<CityModel> getCity ()async {
    FormData userForm = FormData();

    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_city_address.php", data: userForm);
    if(userValue.statusCode == 200){
      final result = CityModel.fromJson(userValue.data);
      print("city api called..");
      return result;
    }else{
      print("city api failed..");
      throw "Something Went Wrong..";
    }

  }

  Future<FestivalModel> getFestival ()async {
    FormData userForm = FormData();

    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_panchang.php", data: userForm);
    if(userValue.statusCode == 200){
      final result = FestivalModel.fromJson(userValue.data);
      print("city api called..");
      return result;
    }else{
      print("city api failed..");
      throw "Something Went Wrong..";
    }

  }

  Future<CityDataModel> getCityData ()async {
    FormData userForm = FormData();
    SharedPreferences sh = await SharedPreferences.getInstance();
    var dd = sh.getString("sh_selectedDay").toString();
    var mm = sh.getString("sh_selectedMonth").toString();
    var yy = sh.getString("sh_selectedYear").toString();

    final userValue = await dio.post("https://www.premastrologer.com/reference/panchang_api/api_coordinates.php?id=${sh.getString("sh_cityRowId")}&dob=$dd-$mm-$yy", data: userForm);
    if(userValue.statusCode == 200){
      final result = CityDataModel.fromJson(userValue.data);
      print("city api called..");
      return result;
    }else{
      print("city api failed..");
      throw "Something Went Wrong..";
    }

  }

  Future<ChoghadiyaModel> getChoghadiya (dd, mm, yy,)async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    print("ZHour==== :${sh.getString("sh_selectedDay")}");
    print("ZMin==== :${sh.getString("sh_selectedMonth")}");
    print("DST====== :${sh.getString("sh_selectedYear")}");
    FormData userForm = FormData();

    print("dd ${dd}");
    userForm.fields.add(MapEntry("dd","${sh.getString("sh_selectedDay")}"));
    userForm.fields.add(MapEntry("mm","${sh.getString("sh_selectedMonth")}"));
    userForm.fields.add(MapEntry("yy","${sh.getString("sh_selectedYear")}"));
    userForm.fields.add(MapEntry("popupDatepicker",""));
    userForm.fields.add(MapEntry("mycity","${sh.getString("sh_selectedCity")}"));
    userForm.fields.add(MapEntry("subcat",""));
    userForm.fields.add(MapEntry("LatDeg","${sh.getString("sh_selectedLtdDeg")}"));
    userForm.fields.add(MapEntry("LatMin","${sh.getString("sh_selectedLtdMin")}"));
    userForm.fields.add(MapEntry("LonDeg","${sh.getString("sh_selectedLongDeg")}"));
    userForm.fields.add(MapEntry("LonMin","${sh.getString("sh_selectedLongMin")}"));
    userForm.fields.add(MapEntry("East","${sh.getString("sh_selectedDirectionEast")}"));
    userForm.fields.add(MapEntry("ZHour"," ${sh.getString("sh_selectedZHour")}"));
    userForm.fields.add(MapEntry("ZMin","${sh.getString("sh_selectedZMin")}"));
    userForm.fields.add(MapEntry("DST","${sh.getString("sh_selectedDst")}"));
    userForm.fields.add(MapEntry("WAR","${sh.getString("sh_selectedWar")}"));
    userForm.fields.add(MapEntry("Hour"," ${sh.getString("sh_selectedZHour")}"));
    userForm.fields.add(MapEntry("Min","${sh.getString("sh_selectedZMin")}"));
    userForm.fields.add(MapEntry("txtnm",""));
    userForm.fields.add(MapEntry("Day","${sh.getString("sh_selectedDay")}"));
    userForm.fields.add(MapEntry("Month","${sh.getString("sh_selectedMonth")}"));
    userForm.fields.add(MapEntry("Year","${sh.getString("sh_selectedYear")}"));
    userForm.fields.add(MapEntry("Asc","Scorpio"));
    userForm.fields.add(MapEntry("Asc2","7"));
    userForm.fields.add(MapEntry("AYNS","-24.19068856852845"));
    userForm.fields.add(MapEntry("as","225.28462936543343"));
    userForm.fields.add(MapEntry("moon","44.48635698113049"));

    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_choghadiya.php", data: userForm);
    if(userValue.statusCode == 200){
      final result = ChoghadiyaModel.fromJson(userValue.data);
      print("city api called..");
      return result;
    }else{
      print("city api failed..");
      throw "Something Went Wrong..";
    }

  }



  Future<DailyPredictionModel> dailyPrediction ()async {
    FormData userForm = FormData();
    SharedPreferences sh = await SharedPreferences.getInstance();

    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_forecast_daily.php?date=${sh.getString("sh_selectedYear")}-0${sh.getString("sh_selectedMonth")}-${sh.getString("sh_selectedDay")}", data: userForm);
    if(userValue.statusCode == 200){
      final result = DailyPredictionModel.fromJson(userValue.data);
      print("dailyPrediction api called..");
      return result;
    }else{
      print("dailyPrediction api failed..");
      throw "Something Went Wrong..";
    }

  }

  Future<WeeklyPredictionModel> weeklyPrediction ()async {
    FormData userForm = FormData();
    SharedPreferences sh = await SharedPreferences.getInstance();

    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_forecast_weekly.php?date=${sh.getString("sh_selectedYear")}-0${sh.getString("sh_selectedMonth")}-${sh.getString("sh_selectedDay")}", data: userForm);
    if(userValue.statusCode == 200){
      final result = WeeklyPredictionModel.fromJson(userValue.data);
      print("weeklyPrediction api called..");
      return result;
    }else{
      print("weeklyPrediction api failed..");
      throw "Something Went Wrong..";
    }

  }

  Future<MonthlyPredictionModel> monthlyPrediction ()async {
    FormData userForm = FormData();
    SharedPreferences sh = await SharedPreferences.getInstance();

    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_forecast_monthly.php?date=${sh.getString("sh_selectedYear")}-0${sh.getString("sh_selectedMonth")}-${sh.getString("sh_selectedDay")}", data: userForm);
    if(userValue.statusCode == 200){
      final result = MonthlyPredictionModel.fromJson(userValue.data);
      print("monthlyPrediction api called..");
      return result;
    }else{
      print("monthlyPrediction api failed....");
      throw "Something Went Wrong..";
    }

  }



  Future<HoraModel> getHora (dd, mm, yy,)async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    print( "dd :$dd");
    print( "mm :$mm");
    print( "yy :$yy");
    print( "popupDatepicker : ");
    print("sh_selectedCity :${sh.getString("sh_selectedCity")}");
    print("subcat :54");
    print("LatDeg:${sh.getString("sh_selectedLtdDeg")}");
    print("LatMin:${sh.getString("sh_selectedLtdMin")}");
    print("East:${sh.getString("sh_selectedDirectionEast")}");
    print("LonDeg:${sh.getString("sh_selectedLongDeg")}");
    print("LonMin:${sh.getString("sh_selectedLongMin")}");
    print("ZHour:${sh.getString("sh_selectedZHour")}");
    print("ZMin:${sh.getString("sh_selectedZMin")}");
    print("DST :0");
    print("war :0");
    print(" Hour :${sh.getString("sh_selectedZHour")}");
    print("Min :${sh.getString("sh_selectedZMin")}");
    print("txtnm :");
    print( "dd :$dd");
    print( "mm :$mm");
    print( "yy :$yy");
    print("Asc :Capricorn");
    print("Asc2:9");
    print("AYNS :-24.191285219725508");
    print("as :272.8712593524042");
    print("moon :223.52345004497522");
    FormData userForm = FormData();

    print("dd ${dd}");
    userForm.fields.add(MapEntry("dd","${sh.getString("sh_selectedDay")}"));
    userForm.fields.add(MapEntry("mm","${sh.getString("sh_selectedMonth")}"));
    userForm.fields.add(MapEntry("yy","${sh.getString("sh_selectedYear")}"));
    userForm.fields.add(MapEntry("popupDatepicker",""));
    userForm.fields.add(MapEntry("mycity","sh_selectedCity :${sh.getString("sh_selectedCity")}"));
    userForm.fields.add(MapEntry("subcat","54"));

    userForm.fields.add(MapEntry("LatDeg","${sh.getString("sh_selectedLtdDeg")}"));
    userForm.fields.add(MapEntry("LatMin","${sh.getString("sh_selectedLtdMin")}"));
    userForm.fields.add(MapEntry("East","${sh.getString("sh_selectedDirectionEast")}"));
    userForm.fields.add(MapEntry("LonDeg","${sh.getString("sh_selectedLongDeg")}"));
    userForm.fields.add(MapEntry("LonMin","${sh.getString("sh_selectedLongMin")}"));
    userForm.fields.add(MapEntry("ZHour","5"));
    userForm.fields.add(MapEntry("ZMin","30"));

    userForm.fields.add(MapEntry("DST","0"));
    userForm.fields.add(MapEntry("WAR","0"));
    userForm.fields.add(MapEntry("Hour","5"));
    userForm.fields.add(MapEntry("Min","30"));
    userForm.fields.add(MapEntry("txtnm",""));
    userForm.fields.add(MapEntry("Day","${sh.getString("sh_selectedDay")}"));
    userForm.fields.add(MapEntry("Month","${sh.getString("sh_selectedMonth")}"));
    userForm.fields.add(MapEntry("Year","${sh.getString("sh_selectedYear")}"));
    userForm.fields.add(MapEntry("Asc","Capricorn"));
    userForm.fields.add(MapEntry("Asc2","9"));
    userForm.fields.add(MapEntry("AYNS","-24.191285219725508"));
    userForm.fields.add(MapEntry("as","272.8712593524042"));
    userForm.fields.add(MapEntry("moon","223.52345004497522"));

    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_hora.php", data: userForm);
    if(userValue.statusCode == 200){
      final result = HoraModel.fromJson(userValue.data);
      print("hora api called..");
      return result;
    }else{
      print("hora api failed..");
      throw "Something Went Wrong..";
    }

  }

  Future<SignificanceModel> significance ()async {
    FormData userForm = FormData();
    SharedPreferences sh = await SharedPreferences.getInstance();

    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_significance.php", data: userForm);
    if(userValue.statusCode == 200){
      final result = SignificanceModel.fromJson(userValue.data);
      print("significance api called..");
      return result;
    }else{
      print("significance api failed..");
      throw "Something Went Wrong..";
    }

  }

  Future<FestivalDateModel> festivalDate()async {
    FormData userForm = FormData();
    SharedPreferences sh = await SharedPreferences.getInstance();

    final userValue = await dio.get("https://festivals.premastrologer.com/api_datewiase.php?dateTime=${sh.getString("sh_selectedYear")}-${sh.getString("sh_selectedMonth")}-${sh.getString("sh_selectedDay")}", data: userForm);
    if(userValue.statusCode == 200){
      final result = FestivalDateModel.fromJson(userValue.data);
      print("festivals date api called..");
      return result;
    }else{
      print("festivals date api failed..");
      throw "Something Went Wrong..";
    }

  }

  Future<TithiModel> tithi (String tmonth, String tyear )async {
    FormData userForm = FormData();
    SharedPreferences sh = await SharedPreferences.getInstance();

    // final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_forecast_weekly.php?date=${sh.getString("sh_selectedYear")}-0${sh.getString("sh_selectedMonth")}-${sh.getString("sh_selectedDay")}", data: userForm);
    final userValue = await dio.post("https://www.premastrologer.com/bk_21sep2017/api_month_tithi.php?month=${tmonth}&year=${tyear}", data: userForm);
    if(userValue.statusCode == 200){
      final result = TithiModel.fromJson(userValue.data);
      print("Tithi api called..");
      return result;
    }else{
      print("Tithi api failed..");
      throw "Something Went Wrong..";
    }

  }


}
