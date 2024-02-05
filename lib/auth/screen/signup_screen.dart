import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panchang/auth/Controller/AddUserController.dart';
import 'package:panchang/auth/Controller/GetAllCountryController.dart';
import 'package:panchang/auth/Controller/GetCityByDistrictController.dart';
import 'package:panchang/auth/Controller/GetDistrictByStateControler.dart';
import 'package:panchang/auth/Controller/GetStateByCountryController.dart';
import 'package:panchang/auth/screen/login_screen.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/sizeConfig/sizeConfig.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _mobNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cfmpasswordController = TextEditingController();

  TextEditingController _birthController = TextEditingController();
  TextEditingController _birthController1 = TextEditingController();

  TextEditingController _searchController = TextEditingController();
  TextEditingController _searchControllerState = TextEditingController();
  TextEditingController _searchControllerDistrict = TextEditingController();

  final GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  final GlobalKey<AutoCompleteTextFieldState<String>> keyState = GlobalKey();
  final GlobalKey<AutoCompleteTextFieldState<String>> keyDistrict = GlobalKey();

  DateTime? _selectedDate;
  var passCheck = true;
  var compassCheck = true;
  var checkSelectedCountry;
  var checkSelectedState;
  var checkSelectedDistrict;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1800),
        lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        _birthController1.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
      });
    }
  }

  var _characterCount = 0;
  final _formKey = GlobalKey<FormState>();

  List abc = [];

  GetAllCountryController _getAllCountryController_obj = Get.put(GetAllCountryController());
  GetStateByCountryroller _getStateByCountryroller_obj =Get.put(GetStateByCountryroller());
  GetDistrictByStateController _getDistrictByStateController_obj =Get.put(GetDistrictByStateController());
  GetCityByDistrictController _getCityByDistrictController_obj = Get.put(GetCityByDistrictController());
  AddUserController _addUserController_obj = Get.put(AddUserController());


  var countryId;
  var stateId;
  var districtId;
  var cityId;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      _getAllCountryController_obj.getAllCountryCont();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.1),
          child: Container(
            height: Get.height * 0.100,
            padding: EdgeInsets.only(
                left: Get.width * 0.050, top: Get.height * 0.025),
            color: common_red,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
               IconButton(onPressed: (){
                 Get.back();
               }, icon:  Icon(
                 Icons.arrow_back_ios,
                 size: 25,
                 color: Colors.white,
               ),),
                SizedBox(
                  width: Get.width * 0.030,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontFamily: 'calibri',
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )),
      body: Obx(
         () {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: Get.width * 0.9,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.030,
                      ),
                      Container(
                        height: Get.height * 0.200,
                        width: Get.width,
                        color: Colors.transparent,
                        padding: EdgeInsets.all(Get.width * 0.020),
                        child: Image.asset(
                          "assets/images/PremAstrologer_FinalLOGO-01-01.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      // SizedBox(height: Get.height*0.050),

                      //Full Name
                      TextFormField(
                        controller: _fNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Full name is required';
                          } else {
                            return null; // Return null if the entered email is valid
                          }
                        },
                        decoration: InputDecoration(
                            prefixIcon: Container(
                                margin: EdgeInsets.all(Get.width * 0.030),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: common_red),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 20,
                                )),
                            label: const Text(
                              "Full Name",
                            ),
                            labelStyle: TextStyle(
                                fontFamily: 'calibri',
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_red))),
                      ),
                      SizedBox(
                        height: Get.height * 0.020,
                      ),

                      //Mobile
                      TextFormField(
                        controller: _mobNoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mobile Number is required';
                          } else if (value.length != 10) {
                            return 'Mobile Number must be 10 digits';
                          } else {
                            return null; // Return null if the entered mobile number is valid
                          }
                        },
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: EdgeInsets.all(Get.width * 0.020),
                            height: Get.height * 0.020,
                            width: Get.width * 0.030,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              // color: common_colour
                            ),
                            // child: Text("#", style: TextStyle(fontFamily: 'calibri',color: common_colour, fontSize: 30, fontWeight: FontWeight.w700),),),
                            child: Icon(
                              Icons.call,
                              color: common_red,
                              size: 25,
                            ),
                          ),
                          label: const Text(
                            "Mobile No",
                          ),
                          labelStyle: TextStyle(
                              fontFamily: 'calibri',
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: common_red)),
                        ),
                        onChanged: (value) {
                          // Update the character count in the row dynamically
                          int currentLength = value.length;
                          int maxLength = 0; // Set your maximum length here
                          int remainingLength = maxLength + currentLength;

                          // You can update any widget that needs to reflect the character count here
                          setState(() {
                            // If you're using a StatefulWidget, make sure to call setState
                            _characterCount = remainingLength;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("$_characterCount/10",
                              style: TextStyle(
                                  fontFamily: 'calibri',
                                  color: Colors.grey,
                                  fontSize: 15)),
                          SizedBox(
                            width: Get.width * 0.030,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.010,
                      ),

                      //Email
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          // Use a regular expression to check if the entered email is valid
                          if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null; // Return null if the entered email is valid
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: common_red,
                            ),
                            label: const Text(
                              "Email",
                            ),
                            labelStyle: TextStyle(
                                fontFamily: 'calibri',
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_red))),
                      ),
                      SizedBox(
                        height: Get.height * 0.020,
                      ),

                      /// --------- Country:----------///
                      _getAllCountryController_obj.loading.value
                          ? Container(
                        height: Get.height * 0.030,
                        width: Get.width * 0.030,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: common_red,
                        ),
                      ):
                      AutoCompleteTextField<String>(
                        key: key,
                        clearOnSubmit: false,
                        suggestions:_getAllCountryController_obj.allCountryName, // List of suggestions
                        // style: FontStyles.regular_16_white, // Your text style
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: common_red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Please Select Country",
                          hintStyle: TextStyle(
                            fontFamily: 'calibri',
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        itemFilter: (item, query) {
                          return item.toLowerCase().contains(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (value) async {
                          setState(() {
                            checkSelectedCountry = value.toString();
                            _searchController.text = value.toString();
                            print("checkSelectedCountry ${checkSelectedCountry}");
                            var index = _getAllCountryController_obj.allCountryName.indexOf(value);
                            print("country index :$index");
                            countryId = _getAllCountryController_obj.allCountryid[index];
                            print("CountryId :$countryId");
                            _getStateByCountryroller_obj.getStateByCountry(countryId.toString());
                            // var index = cityController.allCityName.indexOf(value);
                            // cityRowId = cityController.CityRowId[index].toString();


                          });
                        },
                        itemBuilder: (context, item) {
                          return ListTile(
                            title: Text(item),
                          );
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.020,
                      ),

                      // Country:
                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide: BorderSide(color: Colors.grey),
                      //     ),
                      //     contentPadding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.grey),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: common_red),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     filled: true,
                      //     fillColor: Colors.transparent,
                      //     hintText: "Please Select Country",
                      //     hintStyle: TextStyle(
                      //       fontFamily: 'calibri',
                      //       color: Colors.grey,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      //   icon: _getAllCountryController_obj.loading.value
                      //       ? Container(
                      //     height: Get.height * 0.030,
                      //     width: Get.width * 0.030,
                      //     alignment: Alignment.center,
                      //     child: CircularProgressIndicator(
                      //       color: common_red,
                      //     ),
                      //   )
                      //       : Icon(
                      //     Icons.arrow_drop_down,
                      //     color: Colors.red,
                      //   ),
                      //   onTap: () {
                      //     print('object');
                      //     _getAllCountryController_obj.getAllCountryCont();
                      //   },
                      //   onChanged: (String? value) {
                      //     var index = _getAllCountryController_obj.allCountryName.indexOf(value!);
                      //     print("country index :$index");
                      //      countryId = _getAllCountryController_obj.allCountryid[index];
                      //     print("CountryId :$countryId");
                      //     _getStateByCountryroller_obj.getStateByCountry(countryId.toString());
                      //   },
                      //   items: _getAllCountryController_obj.allCountryName.map<DropdownMenuItem<String>>((var value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Container(
                      //         margin: EdgeInsets.symmetric(horizontal: 5),
                      //         child: Row(
                      //           children: [
                      //             Text(
                      //               value.toString(),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );}).toList(),
                      //   validator: (String? value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Country is required';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),

                      /// --------- State --------///
                      _getStateByCountryroller_obj.loading.value
                          ? Container(
                        height: Get.height * 0.030,
                        width: Get.width * 0.030,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: common_red,
                        ),
                      ):
                      AutoCompleteTextField<String>(
                        key: keyState,
                        clearOnSubmit: false,
                        suggestions:_getStateByCountryroller_obj.allstateName, // List of suggestions
                        // style: FontStyles.regular_16_white, // Your text style
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: common_red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Please Select State",
                          hintStyle: TextStyle(
                            fontFamily: 'calibri',
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        itemFilter: (item, query) {
                          return item.toLowerCase().contains(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (value) async {
                          setState(() {
                            checkSelectedCountry = value.toString();
                            _searchControllerState.text = value.toString();
                            var index = _getStateByCountryroller_obj.allstateName.indexOf(value);
                            print("State index :$index");
                            stateId = _getStateByCountryroller_obj.allstateid[index];
                            print("stateId :$stateId");
                            _getDistrictByStateController_obj.getDistrictByStateCont(stateId.toString());


                          });
                        },
                        itemBuilder: (context, item) {
                          return ListTile(
                            title: Text(item),
                          );
                        },
                      ),
                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide: BorderSide(color: Colors.grey),
                      //     ),
                      //     contentPadding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.grey),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: common_red),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     filled: true,
                      //     fillColor: Colors.transparent,
                      //     hintText: "Please Select State",
                      //     hintStyle: TextStyle(
                      //       fontFamily: 'calibri',
                      //       color: Colors.grey,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      //   icon: _getStateByCountryroller_obj.loading.value
                      //       ? Container(
                      //     height: Get.height * 0.030,
                      //     width: Get.width * 0.030,
                      //     alignment: Alignment.center,
                      //     child: CircularProgressIndicator(
                      //       color: common_red,
                      //     ),
                      //   )
                      //       : Icon(
                      //     Icons.arrow_drop_down,
                      //     color: Colors.red,
                      //   ),
                      //   onTap: () {
                      //     print('object');
                      //     // _getAllCountryController_obj.getAllCountryCont();
                      //   },
                      //   onChanged: (String? value) {
                      //     var index = _getStateByCountryroller_obj.allstateName.indexOf(value!);
                      //     print("State index :$index");
                      //      stateId = _getStateByCountryroller_obj.allstateid[index];
                      //     print("stateId :$stateId");
                      //     _getDistrictByStateController_obj.getDistrictByStateCont(stateId.toString());
                      //   },
                      //   items: _getStateByCountryroller_obj.allstateName.map<DropdownMenuItem<String>>((var value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Container(
                      //         width: Get.width*0.75,
                      //         margin: EdgeInsets.symmetric(horizontal: 5),
                      //         child: Row(
                      //           children: [
                      //             Text(
                      //               value.toString(),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );}).toList(),
                      //   validator: (String? value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Country is required';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      SizedBox(height: Get.height * 0.020,),

                      /// --------- District ---------///
                      AutoCompleteTextField<String>(
                        key: keyDistrict,
                        clearOnSubmit: false,
                        suggestions:_getDistrictByStateController_obj.allDistrictName, // List of suggestions
                        // style: FontStyles.regular_16_white, // Your text style
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: common_red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Please Select City",
                          hintStyle: TextStyle(
                            fontFamily: 'calibri',
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        itemFilter: (item, query) {
                          return item.toLowerCase().contains(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (value) async {
                          setState(() {
                            checkSelectedDistrict = value.toString();
                            _searchControllerDistrict.text = value.toString();
                            var index = _getDistrictByStateController_obj.allDistrictName.indexOf(value);
                            print("district index :$index");
                            districtId = _getDistrictByStateController_obj.allDistrictId[index];
                            print("districtId :$districtId");
                            _getCityByDistrictController_obj.getCityByDistrictCont(districtId.toString());

                          });
                        },
                        itemBuilder: (context, item) {
                          return ListTile(
                            title: Text(item),
                          );
                        },
                      ),

                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide: BorderSide(color: Colors.grey),
                      //     ),
                      //     contentPadding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.grey),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: common_red),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     filled: true,
                      //     fillColor: Colors.transparent,
                      //     hintText: "Please Select City",
                      //     hintStyle: TextStyle(
                      //       fontFamily: 'calibri',
                      //       color: Colors.grey,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      //   icon: _getDistrictByStateController_obj.loading.value
                      //       ? Container(
                      //     height: Get.height * 0.030,
                      //     width: Get.width * 0.030,
                      //     alignment: Alignment.center,
                      //     child: CircularProgressIndicator(
                      //       color: common_red,
                      //     ),
                      //   )
                      //       : Icon(
                      //     Icons.arrow_drop_down,
                      //     color: Colors.red,
                      //   ),
                      //   onTap: () {
                      //     print('object');
                      //     // _getAllCountryController_obj.getAllCountryCont();
                      //   },
                      //   onChanged: (String? value) {
                      //     var index = _getDistrictByStateController_obj.allDistrictName.indexOf(value!);
                      //     print("district index :$index");
                      //      districtId = _getDistrictByStateController_obj.allDistrictId[index];
                      //     print("districtId :$districtId");
                      //     _getCityByDistrictController_obj.getCityByDistrictCont(districtId.toString());
                      //
                      //   },
                      //   items: _getDistrictByStateController_obj.allDistrictName.map<DropdownMenuItem<String>>((var value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Container(
                      //         width: Get.width*0.75,
                      //         margin: EdgeInsets.symmetric(horizontal: 5),
                      //         child: Row(
                      //           children: [
                      //             Text(
                      //               value.toString(),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );}).toList(),
                      //   validator: (String? value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Country is required';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      SizedBox(height: Get.height * 0.020,),

                      //City
                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide: BorderSide(color: Colors.grey),
                      //     ),
                      //     contentPadding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.grey),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: common_red),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     filled: true,
                      //     fillColor: Colors.transparent,
                      //     hintText: "Please Select City",
                      //     hintStyle: TextStyle(
                      //       fontFamily: 'calibri',
                      //       color: Colors.grey,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      //   icon: _getCityByDistrictController_obj.loading.value
                      //       ? Container(
                      //     height: Get.height * 0.030,
                      //     width: Get.width * 0.030,
                      //     alignment: Alignment.center,
                      //     child: CircularProgressIndicator(
                      //       color: common_red,
                      //     ),
                      //   )
                      //       : Icon(
                      //     Icons.arrow_drop_down,
                      //     color: Colors.red,
                      //   ),
                      //   onTap: () {
                      //     print('object');
                      //     // _getAllCountryController_obj.getAllCountryCont();
                      //   },
                      //   onChanged: (String? value) {
                      //     var index = _getCityByDistrictController_obj.allCityName.indexOf(value);
                      //     print("City index :$index");
                      //      cityId = _getCityByDistrictController_obj.allCityId[index];
                      //     print("cityId :$cityId");
                      //   },
                      //   items: _getCityByDistrictController_obj.allCityName.map<DropdownMenuItem<String>>((var value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Container(
                      //         margin: EdgeInsets.symmetric(horizontal: 5),
                      //         child: Row(
                      //           children: [
                      //             Text(
                      //               value.toString(),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );}).toList(),
                      //   validator: (String? value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Country is required';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      // SizedBox(height: Get.height * 0.020,),


                      //Birth
                      TextFormField(
                        controller: _birthController1,
                        keyboardType: TextInputType.none,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Birth Date is required';
                          } else {
                            return null; // Return null if the entered email is valid
                          }
                        },
                        onTap: () {
                          _selectDate();
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              color: common_red,
                            ),
                            label: const Text(
                              "Birth Date",
                            ),
                            labelStyle: TextStyle(
                                fontFamily: 'calibri',
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: common_red))),
                      ),
                      SizedBox(height: Get.height * 0.020,),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: passCheck, // Hide the entered text
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is Required';
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
                          labelStyle: TextStyle(
                              fontFamily: 'calibri',
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: common_red),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.030,),

                      //Confirm Password
                      TextFormField(
                        controller: _cfmpasswordController,
                        obscureText: compassCheck, // Hide the entered text
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: (){
                                setState(() {
                                  compassCheck = !compassCheck;
                                  print("passCheck:$compassCheck");
                                });
                              },
                              child: Icon(compassCheck==false?Icons.remove_red_eye_outlined:Icons.remove_red_eye, color: common_red)),
                          prefixIcon: Icon(Icons.key, color: common_red),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                              fontFamily: 'calibri',
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: common_red),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.030,
                      ),


                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordController.text !=_cfmpasswordController.text) {
                              Fluttertoast.showToast(msg: "Password And Confirm Password Not Match...");
                            }else{
                              _addUserController_obj.addUserCont(
                                  _fNameController.text,
                                  _mobNoController.text,
                                  _emailController.text,
                                  countryId.toString(),
                                  stateId.toString(),
                                  districtId.toString(),
                                  cityId.toString(),
                                  _birthController.text,
                                  _passwordController.text
                              );
                            }
                          }
                        },
                        child: Container(
                          height: Get.height * 0.060,
                          width: Get.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: common_red,
                              borderRadius: BorderRadius.circular(20)),
                          child: _addUserController_obj.loading.value?CircularProgressIndicator(color: Colors.white,):Text(
                            "Sign Up",
                            style: TextStyle(
                                fontFamily: 'calibri',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.030,
                      ),

                      InkWell(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have Account!  ",
                              style: TextStyle(
                                  fontFamily: 'calibri',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17),
                            ),
                            Text(
                              "Sign In",
                              style: TextStyle(
                                  fontFamily: 'calibri',
                                  color: common_red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.030,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}
