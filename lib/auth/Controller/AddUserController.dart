import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/auth/model/AddUserModel.dart';
import 'package:panchang/home/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController{

  var loading  = false.obs;
  var oldResponse = AddUserModel().obs;


  Future<void> addUserCont (FullName, MobileNo, Email, Country, State, District, City, BirthDate, Password) async {
    try{
      loading(true);

      final newResponse = await ApiServices().addUser(FullName, MobileNo, Email, Country, State, District, City, BirthDate, Password);
      if(newResponse.responseCode == "1"){

        oldResponse = newResponse.obs;
        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString("sh_userId",oldResponse.value.userData!.id.toString());

        print("addUserCont called..");
        Fluttertoast.showToast(msg: "SignUp Successful");
        // Get.snackbar(
        //     '',
        //     '${oldResponse.value.message}',
        //     snackPosition: SnackPosition.TOP
        // );
        Get.to(HomeScreen());
      }else{
        oldResponse = newResponse.obs;
        Get.snackbar(
            '',
            '${oldResponse.value.message}',
            snackPosition: SnackPosition.TOP
        );
        print("addUserCont failed..");
      }

    }finally{
      loading(false);
    }

  }

}