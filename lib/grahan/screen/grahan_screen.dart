import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panchang/common/common_colour.dart';
import 'package:panchang/festivals/screen/festival_web_view.dart';
import 'package:panchang/grahan/controller/grahan_controller.dart';
import 'package:translator/translator.dart';

class GrahanScreen extends StatefulWidget {
  final String year;

  GrahanScreen({Key? key, required this.year}) : super(key: key);

  @override
  State<GrahanScreen> createState() => _GrahanScreenState();
}

class _GrahanScreenState extends State<GrahanScreen> {
  var grahan = Get.put(GrahanController());

  List<int> colo = [
    0xff8E24AA,
    0xff2E7D32,
    0xfff21905,
    0xff1b567a,
    0xffaf69db,
    0xff0db9db,
    0xff1b567a,
    0xff1b567a,
  ];

  List<String> yearss = [
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
  ];

  String? currentY;

  final translator = GoogleTranslator();

  void translateList(String language) async {
    List<Future<String>> futures = [];
    for (String item in yearss) {
      futures.add(translator.translate(item, to: language).then((value) => value.text));
    }

    List<String> translatedList = await Future.wait(futures);
    setState(() {
      yearss = translatedList;
    });
  }
  var ll = "hi";
  @override
  void initState() {
    super.initState();
    translateList("gu"); // Initial translation to Hindi
    DateTime dateTime = DateFormat("dd-MM-yyyy").parse(widget.year.toString());
    int year = dateTime.year;
    currentY = year.toString();
    grahan.grahanCont("$year");
  }

  String selectedLanguage = "en"; // Default language key

  final Map<String, String> languageKeys = {
    "Afrikaans": "af",
    "Albanian": "sq",
    "Amharic": "am",
    "Arabic": "ar",
    "Armenian": "hy",
    "Azerbaijani": "az",
    "Basque": "eu",
    "Belarusian": "be",
    "Bengali": "bn",
    "Bosnian": "bs",
    "Bulgarian": "bg",
    "Catalan": "ca",
    "Cebuano": "ceb",
    "Chinese (Simplified)": "zh-CN",
    "Chinese (Traditional)": "zh-TW",
    "Corsican": "co",
    "Croatian": "hr",
    "Czech": "cs",
    "Danish": "da",
    "Dutch": "nl",
    "English": "en",
    "Esperanto": "eo",
    "Estonian": "et",
    "Finnish": "fi",
    // Add more languages as needed
  };
  void cc(String pp){
    ll = pp;
    setState(() {
      translateList(ll); // Initial translation to Hindi
      DateTime dateTime = DateFormat("dd-MM-yyyy").parse(widget.year.toString());
      int year = dateTime.year;
      currentY = year.toString();
      grahan.grahanCont("$year");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     cc();
        //     // Get.back();
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_rounded,
        //     color: Colors.white,
        //   ),
        // ),
        leading: DropdownButton<String>(
          value: selectedLanguage,
          onChanged: (String? newValue) {
            setState(() {
              selectedLanguage = newValue!;
              cc(selectedLanguage);
            });
          },
          items: languageKeys.keys.map<DropdownMenuItem<String>>((String key) {
            return DropdownMenuItem<String>(
              value: languageKeys[key],
              child: Text(key),
            );
          }).toList(),
        ),
        centerTitle: true,
        backgroundColor: common_red,
        title: Text(
          "Eclipse",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: yearss.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentY = yearss[index];
                        grahan.grahanCont("$currentY");
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(colo[index]),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        "${yearss[index]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  currentY == yearss[index]
                      ? Obx(
                        () => grahan.loading.value
                        ? Center(
                      child: CircularProgressIndicator(
                        color: common_red,
                      ),
                    )
                        : Container(
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        itemCount: grahan.grahanList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                // Get.to(()=>FestivalWebScreen(webUrl: "${grahan.grahanList[index].link}",));
                              },
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: common_red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FutureBuilder<Translation>(
                                            future: translator.translate(grahan.grahanList[index].title.toString(), to: "${ll}"), // Translate to Hindi ("hi")
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!.text,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                  "${grahan.grahanList[index].title}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          FutureBuilder<Translation>(
                                            future: translator.translate(grahan.grahanList[index].date.toString(), to: "${ll}"), // Translate to Hindi ("hi")
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!.text,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                  "${grahan.grahanList[index].date}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),



                                      TextButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: "Description",
                                            titleStyle: TextStyle(color: common_red),
                                            content: Container(
                                              height: Get.height * 0.8,
                                              width: Get.width,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child:
                                                FutureBuilder<Translation>(
                                                  future: translator.translate(grahan.grahanList[index].description.toString(), to: "${ll}"), // Translate to Hindi ("hi")
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        snapshot.data!.text,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                        "${grahan.grahanList[index].description}",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Know more",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                      : SizedBox()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
