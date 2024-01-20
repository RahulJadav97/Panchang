import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/auth/model/LoginUserModel.dart';
import 'package:panchang/common/common_sharedprefrence.dart';
import 'package:panchang/home/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class LoginUserController extends GetxController{

  var loading  = false.obs;
  var oldResponse = LoginUserModel().obs;

  Future<void> loginUserCont (Email, Password) async {
    try{
      loading(true);

      final newResponse = await ApiServices().loginUser(Email, Password);
      if(newResponse.responseCode == "1"){

        oldResponse = newResponse.obs;
        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString("sh_userId",oldResponse.value.userData!.id.toString());
        print("loginUserCont called..");
        Fluttertoast.showToast(msg: "Sign In Successful");
        // Get.snackbar(
        //     'Sign In',
        //     'Sign In Successful',
        //     snackPosition: SnackPosition.TOP
        // );
        Get.to(HomeScreen());
      }else{
        oldResponse = newResponse.obs;
        Get.snackbar(
            'Sign In',
            '${oldResponse.value.message}',
            snackPosition: SnackPosition.TOP
        );
        print("loginUserCont failed..");
      }

    }finally{
      loading(false);
    }

  }

}