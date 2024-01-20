import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Color? cursorColor;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter> textInputFormatter;
  final Icons;
  final Color ?color;

  const CustomTextFormField(
      {Key? key,
        required this.textInputFormatter,
         this.color,
        this.Icons,
        this.controller,
        this.validator,
        required this.obscureText,
        this.keyboardType,
        this.cursorColor,
        this.hintText,
        this.contentPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Get.height*0.06,
      child: TextFormField(
        inputFormatters: [],
        controller: controller,
        validator: validator,
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        keyboardType: keyboardType,
        cursorColor: cursorColor,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          // constraints: BoxConstraints(
          //   minHeight: Get.height*0.06,
          //   maxHeight: Get.height*0.07
          // ),
            prefixIcon:Icon(Icons,color: color,),
            filled: true,
            border: InputBorder.none,
            hintText: hintText,
            fillColor: const Color(0xffF2F2F2),
            contentPadding: contentPadding,
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15)),
            errorBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}