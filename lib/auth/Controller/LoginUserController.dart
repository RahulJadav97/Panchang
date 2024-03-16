import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panchang/Apiservices/api_services.dart';
import 'package:panchang/auth/model/LoginUserModel.dart';
import 'package:panchang/auth/model/social_register_model.dart';
import 'package:panchang/common/common_sharedprefrence.dart';
import 'package:panchang/home/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class LoginUserController extends GetxController{

  var loading  = false.obs;
  var oldResponse = LoginUserModel().obs;
  var Response = SocialRegisterModel().obs;

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

  void appleSign() async {
    AuthorizationResult authorizationResult =
    await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    switch (authorizationResult.status) {
      case AuthorizationStatus.authorized:
        print("authorized");
        try {
          AppleIdCredential? appleCredentials = authorizationResult.credential;
          OAuthProvider oAuthProvider = OAuthProvider("apple.com");
          OAuthCredential oAuthCredential = oAuthProvider.credential(
              idToken: String.fromCharCodes(appleCredentials!.identityToken!),
              accessToken:
              String.fromCharCodes(appleCredentials.authorizationCode!));
          print(appleCredentials.email);
          print(appleCredentials.fullName);
          UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
          if (userCredential.user != null) {
            var res = await ApiServices().social_register(userCredential.user!.email.toString());
            if (res.responseCode == '1') {
              Response = res.obs;
              SharedPreferences sh = await SharedPreferences.getInstance();
              sh.setString("sh_userId",oldResponse.value.userData!.id.toString());
              Get.to(HomeScreen());
            } else {
              Get.snackbar(
                "Apple Login Error",
                "${res.message}",
                // backgroundColor: Colors.black,
                icon: const Icon(Icons.error, color: Colors.deepOrange),
                snackPosition: SnackPosition.TOP,
              );
            }
          }
        } catch (e) {
          print("apple auth failed $e");
        }

        break;
      case AuthorizationStatus.error:
        print("error" + authorizationResult.error.toString());
        break;
      case AuthorizationStatus.cancelled:
        print("cancelled");
        break;
      default:
        print("none of the above: default");
        break;
    }
  }

}