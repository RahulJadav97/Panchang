import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/Panchang_Model_controller/Model/PanchangModel.dart';
import 'package:panchang/panchang/screen/panchang_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class PanchangController extends GetxController{

  var loading  = false.obs;
  var oldResponse = PanchangModel().obs;

  String ?sunrise;
  String ?sunset;

  String ?moonrise;
  String ?moonset;
  String ?tithi;
  String ?nakshatra;
  String ?yoga;
  String ?karan;
  String ?Bhadra;
  String ?rashi;
  String ?rahu_kaal;
  String ?gandmool;
  String ?panchak;
  String ?fastival;
  int? vikramSamvat;
  int? shakaSamvat;
  String? ritu;
  String? dishaShool;
  String? mass;
  String? horas;
  String? yamagamdam;
  String? gulikaKaal;
  String? durMuhurat;

  Future<void> panchangCont (
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
      ) async {
    try{
      loading(true);

      final newResponse = await ApiServices().panchangApi(
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
      );
      // print("PanchangCont data. :${newResponse.}.");
      if(newResponse.responseCode == 1){

        oldResponse = newResponse.obs;

        sunrise = oldResponse.value.data!.sunrise.toString();
        sunset = oldResponse.value.data!.sunset.toString();

        moonrise = oldResponse.value.data!.moonrise.toString();
        moonset = oldResponse.value.data!.moonset.toString();
        tithi = oldResponse.value.data!.tithi.toString();
        nakshatra = oldResponse.value.data!.nakshatra.toString();
        yoga = oldResponse.value.data!.yoga.toString();
        karan = oldResponse.value.data!.karan.toString();
        Bhadra = oldResponse.value.data!.bhadra.toString();
        rashi = oldResponse.value.data!.rashi.toString();
        rahu_kaal = oldResponse.value.data!.rahuKaal.toString();
        gandmool = oldResponse.value.data!.gandmool.toString();
        panchak = oldResponse.value.data!.panchak.toString();
        fastival = oldResponse.value.data!.fastival.toString();
        vikramSamvat = oldResponse.value.data!.vikramSamvat;
        shakaSamvat = oldResponse.value.data!.shakaSamvat;
        ritu = oldResponse.value.data!.ritu.toString();
        dishaShool = oldResponse.value.data!.dishaShool.toString();
        mass = oldResponse.value.data!.mass.toString();
        // horas = oldResponse.value.data!.horas.toString();
        yamagamdam = oldResponse.value.data!.yamagamdam.toString();
        gulikaKaal = oldResponse.value.data!.gulikaKaal.toString();
        durMuhurat = oldResponse.value.data!.durMuhurat.toString();


        print("========================================panchangCont=============================================");
        print("sunrise: $sunrise");
        print("sunset: $sunset");
        print("tithi: $tithi");
        print("nakshatra: $nakshatra");
        print("yoga: $yoga");
        print("karan: $karan");
        print("Bhadra: $Bhadra");
        print("rashi: $rashi");
        print("rahu_kaal: $rahu_kaal");
        print("gandmool: $gandmool");
        print("panchak: $panchak");
        print("fastival: $fastival");
        print("vikramSamvat: $vikramSamvat");
        print("shakaSamvat: $shakaSamvat");
        print("ritu: $ritu");
        print("dishaShool: $dishaShool");
        print("mass: $mass");
        print("horas: $horas");
        print("yamagamdam: $yamagamdam");
        print("gulikaKaal: $gulikaKaal");
        print("durMuhurat: $durMuhurat");

        print("========================================panchangCont close=============================================");

        Get.to(PanchangScreen());

        print("PanchangCont called..");
      }else{
        oldResponse = newResponse.obs;
        // Fluttertoast.showToast(msg: "");
        print("PanchangCont failed. :${newResponse.isBlank}.");
      }

    }finally{
      loading(false);
    }

  }

}