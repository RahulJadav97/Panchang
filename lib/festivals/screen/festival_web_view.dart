import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:panchang/common/common_colour.dart';

class FestivalWebScreen extends StatefulWidget {
  var webUrl;
  FestivalWebScreen({super.key,required this.webUrl});

  @override
  State<FestivalWebScreen> createState() => _FestivalWebScreenState();
}

class _FestivalWebScreenState extends State<FestivalWebScreen> {
  final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController  inAppWebViewController;
  double _progress = 0;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back,color: Colors.white,),),
        backgroundColor: common_red,
        title: Text("Premastrologer",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body:Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(widget.webUrl.toString())
              ),
              onWebViewCreated: (InAppWebViewController controller){
                inAppWebViewController = controller;
              },
              onProgressChanged: (InAppWebViewController controller , int progress){
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
          ),
          _progress < 1 ? Container(
            child: LinearProgressIndicator(
              value: _progress,
            ),
          ):SizedBox()
        ],
      ),


    );
  }
}
