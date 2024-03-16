import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:panchang/auth/Controller/LoginUserController.dart';
import 'package:panchang/auth/screen/forgotPassword_screen.dart';
import 'package:panchang/auth/screen/signup_screen.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/common/teststyle.dart';

import 'package:panchang/sizeConfig/sizeConfig.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginUserController _loginUserController_OBJ  = Get.put(LoginUserController());
  var passCheck = true;
  @override
  void initState() {
    plateformCheck();
    super.initState();
  }

  String? plateForm;
  Future<void>plateformCheck()async{
    if (Platform.isAndroid) {
      plateForm = 'Android';
    } else if (Platform.isIOS) {
      plateForm = 'IOS';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:PreferredSize(preferredSize: Size.fromHeight(SizeConfig.screenHeight*0.1),
          child: Container(
            height: SizeConfig.screenHeight*0.100,
            padding: EdgeInsets.only(left: SizeConfig.screenWidth*0.050, top: SizeConfig.screenHeight*0.025),
            color: common_red,
              alignment: Alignment.centerLeft,
              child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w400, fontFamily: 'calibri'),),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: SizeConfig.screenWidth*0.9,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.screenHeight*0.350,
                    width: SizeConfig.screenWidth,
                    color: Colors.transparent,
                    padding: EdgeInsets.all(SizeConfig.screenWidth*0.100),
                    child: Image.asset("assets/images/PremAstrologer_FinalLOGO-01-01.png", fit: BoxFit.contain,),
                  ),
                  // SizedBox(height: SizeConfig.screenHeight*0.050),

                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      // Use a regular expression to check if the entered email is valid
                      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null; // Return null if the entered email is valid
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail, color: common_red,),
                      label: const Text("Email", ),
                      labelStyle:  TextStyle(color: common_red, fontWeight: FontWeight.w600, fontFamily: 'calibri'),
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: common_red)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: common_red)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: common_red)
                      )
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.020,),

                  TextFormField(
                    controller: passwordController,
                    obscureText: passCheck, // Hide the entered text
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              passCheck = !passCheck;
                              print("passCheck:$passCheck");
                            });
                          },
                          child: Icon(passCheck==false?Icons.remove_red_eye_outlined:Icons.remove_red_eye, color: common_red)),
                      prefixIcon: Icon(Icons.key, color: common_red),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: common_red, fontWeight: FontWeight.w600, fontFamily: 'calibri'),
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: common_red)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: common_red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: common_red),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.030,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: (){
                            Get.to(const ForgotPasswordScreen());
                          },
                          child: Text("Forgot Password?", style: TextStyle(color: common_red, fontWeight: FontWeight.w700, fontSize: 22,fontFamily: 'calibri'),))
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.030,),

                  Obx(
                     () {
                      return InkWell(
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                            _loginUserController_OBJ.loginUserCont(emailController.text, passwordController.text);
                          }

                        },
                        child: Container(
                          height: SizeConfig.screenHeight*0.060,
                          width: SizeConfig.screenWidth,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: common_red,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: _loginUserController_OBJ.loading.value?CircularProgressIndicator(color: Colors.white,):Text("Sign In", style: font_style.white_500_22_ff,),
                        ),
                      );
                    }
                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.030,),
                  plateForm == 'IOS'?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          _loginUserController_OBJ.appleSign();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: Get.height*0.070,
                          width: Get.width*0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black),
                          ),
                          child:  Icon(Icons.apple, color: Color(0xff3F3E3E).withOpacity(0.9),size: 35,),
                        ),
                      )
                    ],
                  ):SizedBox(),

                  InkWell(
                    onTap: (){
                      Get.to(SignupScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Does not have account? ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w200, fontSize: 20,fontFamily: 'calibri'   ),),
                        Text("Sign Up", style: TextStyle(color: common_red, fontWeight: FontWeight.w500, fontSize: 23, fontFamily: 'calibri'),)
                      ],
                    ),
                  ),




                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
