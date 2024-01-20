
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:panchang/common/teststyle.dart';

import '../../common/common_colour.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController emailController = TextEditingController();

  final _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        },icon: Icon(Icons.arrow_back_ios,color: common_red,),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/forgotPassword.png"),
                  SizedBox(height: Get.height*0.015,),
                  Text("Forgot Password",style: font_style.Black_700_24,),
                  Text("Don’t Worry it happens, please enter the Email associated with your account.",style: font_style.Grey_400_16,),
                  SizedBox(height: Get.height*0.03,),
                  // Text("Mobile No.",style: font_style.Black_700_15,),
                  // SizedBox(height: Get.height*0.015,),
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
                      labelStyle:  TextStyle(color: common_red, fontWeight: FontWeight.w600),
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
                  SizedBox(height: Get.height*0.060,),

                  GestureDetector(
                    onTap: (){

                      if(_formKey.currentState!.validate()){
                        print("password send to your email..");
                      }

                      // Get.to(()=>LoginScreen());
                    },
                    child: Container(
                      height: Get.height*0.06,
                      child: Center(child: Text("Continue",style: font_style.White_700_20,)),
                      decoration: BoxDecoration(
                          color: common_red,
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                  )

                  // InkWell(
                  //   onTap: (){
                  //     Get.to(()=>OtpVerifyScreen());
                  //   },
                  //   child: Container(
                  //     height: Get.height*0.06,
                  //     child: Center(child: Text("Continue",style: font_style.White_700_20,)),
                  //     decoration: BoxDecoration(
                  //         color: common_color,
                  //         borderRadius: BorderRadius.circular(15)
                  //     ),
                  //   ),
                  // ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
