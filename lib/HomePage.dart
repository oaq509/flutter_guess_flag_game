// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

// HomePage #################################################
class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  static late WebViewController controller;

  var currentYear;
  static var indexPosition = 0;
  final key = UniqueKey();
  static String title = "العقد الالكتروني";

  completeLoading(String A) {
    setState(() {
      indexPosition = 0;
    });
  }

  beginLoading(String A) {
    setState(() {
      indexPosition = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    currentYear = DateTime.now().year;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawer: Al3gdMenu(currentYear: currentYear),
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          elevation: 1,
          centerTitle: true,
          title: Text(title,
              style: GoogleFonts.getFont("Tajawal",
                  color: Colors.white, fontWeight: FontWeight.w500)),
          backgroundColor: Color(0xFF22b473),
        ),
        body: IndexedStack(
          index: indexPosition,
          children: [
            WebView(
              key: key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'https://al3gd.com/ar/app',
              zoomEnabled: false,
              onPageStarted: beginLoading,
              onPageFinished: (controller) async {
                final url = await _HomePage.controller.currentUrl();
                //print(url);
                if (url == "https://www.ejar.sa/ar/faqs") {
                  await _HomePage.controller.runJavascript(
                      "document.getElementsByClassName('header-top-info')[0].style.display = 'none';");
                  await _HomePage.controller.runJavascript(
                      "document.getElementsByClassName('breadcrumb')[0].style.display = 'none';");
                  await _HomePage.controller.runJavascript(
                      "document.getElementsByClassName('region-content-type-header')[0].style.display = 'none';");
                  await _HomePage.controller.runJavascript(
                      "document.getElementsByTagName('footer')[0].style.display = 'none';");
                  await _HomePage.controller.runJavascript(
                      "document.getElementsByClassName('topbar-nav1 clearfix')[0].style.display = 'none';");
                }
                await completeLoading('');
              },
              gestureNavigationEnabled: true,
              onWebViewCreated: (controller) {
                _HomePage.controller = controller;
              },
            ),
            Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            )),
            Center(
              child: Text('About us'),
            )
          ],
        ));
  }
}

// Drawer Menu #################################################
class Al3gdMenu extends StatefulWidget {
  const Al3gdMenu({
    Key? key,
    required this.currentYear,
  }) : super(key: key);

  final currentYear;

  @override
  State<Al3gdMenu> createState() => _Al3gdMenuState();
}

class _Al3gdMenuState extends State<Al3gdMenu> {
  // TODO about us
  aboutUs() {
    setState(() {
      _HomePage.title = "من نحن";
      _HomePage.indexPosition = 2;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Drawer(
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 250,
              ),
              ListTile(
                title: Text(
                  'الرئيسية',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.getFont("Tajawal",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 28,
                ),
                onTap: () async {
                  setState(() {
                    _HomePage.title = "العقد الالكتروني";
                  });
                  _HomePage.controller.loadUrl("https://al3gd.com/ar/app");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.feed_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text('اطلب عقدك',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.getFont("Tajawal",
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                onTap: () async {
                  setState(() {
                    _HomePage.title = "اطلب عقدك";
                  });
                  _HomePage.controller.loadUrl("https://al3gd.com/ar/req");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.tag_faces,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text('من نحن',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.getFont("Tajawal",
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                onTap: aboutUs,
              ),
              ListTile(
                leading: Icon(
                  Icons.question_mark,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text('الأسئلة المتكررة',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.getFont("Tajawal",
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                onTap: () async {
                  _HomePage.controller.loadUrl("https://www.ejar.sa/ar/faqs");
                  setState(() {
                    _HomePage.title = "الأسئلة المتكررة";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                title: Text('اتصل بنا',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.getFont("Tajawal",
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                onTap: () async {},
              ),
              SizedBox(
                height: 80,
              ),
              Image(
                image: AssetImage("assets/images/Logos.png"),
                height: 90,
              ),
              SizedBox(
                height: 18,
              ),
              Text("Amiral.sa ${widget.currentYear} - al3gd.com v1.2",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        backgroundColor: Color(0xFF24bf79),
      ),
    );
  }
}
