
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/auth/model/forgot_pass_model.dart';
import 'package:panchang/auth/screen/login_screen.dart';

class ForgotPassController extends GetxController{
  var isLoading = false.obs;
  var response = ForgotPassModel().obs;
  TextEditingController emailCTC = TextEditingController();

  Future<void> forgotPassCont () async {
    try{
      isLoading(true);
      final newResponse = await ApiServices().forgotPass(emailCTC.text.toString());
      if(newResponse.responseCode == "1"){

        response = newResponse.obs;
        Fluttertoast.showToast(msg: "Forgot Password Successfully Reset Please Check Email ");
        Get.to(()=>LoginScreen());
      }else{
        response = newResponse.obs;
        Fluttertoast.showToast(msg: '${response.value.message}');

        print("forgot password failed..");
      }

    }finally{
      isLoading(false);
    }

  }
}