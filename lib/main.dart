import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String shortlink = "None";
  String fullshortlink = "None";
  String shortlink2 = "None";
  String fullshortlink2 = "None";
  String sharelink = "None";
  String original = '';

  TextEditingController urlcontroller = TextEditingController();

  getdata() async {
    var url = 'https://api.shrtco.de/v2/shorten?url=${urlcontroller.text}';
    var response = await http.get(url);
    var result = jsonDecode(response.body);

    setState(() {
      shortlink = result['result']['short_link'];
      fullshortlink = result['result']['full_short_link'];
      shortlink2 = result['result']['short_link2'];
      fullshortlink2 = result['result']['full_short_link2'];
      sharelink = result['result']['share_link'];
      original = result['result']['original_link'];
    });
  }

  copy(String texttocopy) {
    FlutterClipboardManager.copyToClipBoard(texttocopy).then((value) {
      SnackBar snackbar = SnackBar(
        content: Text("$texttocopy has been copied"),
        duration: Duration(seconds: 2),
      );

      _globalKey.currentState.showSnackBar(snackbar);
    });
  }

  buildrow(String title, String data, bool original) {
    return SingleChildScrollView(
      child: original == true
          ? Container(
              alignment: Alignment.center,
              child: Text(
                data,
                style: GoogleFonts.montserrat(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data,
                  style: GoogleFonts.montserrat(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                    onTap: () => copy(data), child: Icon(Icons.content_copy)),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  gradient: SweepGradient(colors: [
                    
                    Colors.lightGreen,
                    Colors.lightGreenAccent,
                    Colors.yellow[200]
                    
                  ],
                  
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "URL SHORTENER",
                        style: GoogleFonts.montserrat(
                          fontSize: 30.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        margin: EdgeInsets.only(left: 40, right: 40.0),
                        child: TextField(
                          controller: urlcontroller,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              prefixIcon: Icon(Icons.search,color: Colors.black,),
                              labelText: "Type the url",
                              
                              labelStyle: GoogleFonts.montserrat(
                                fontSize: 25.0,
                                color: Colors.black45,
                              ),
                              
                              
                              border: OutlineInputBorder(
                                
                                borderRadius: BorderRadius.circular(20.0),
                                
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  onPressed: () => getdata(),
                  color: Colors.lightGreen,
                  child: Center(
                    child: Text(
                      "Shorten Link",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.9,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20.0),
                    buildrow("Shortlink", shortlink, false),
                    SizedBox(height: 20.0),
                    buildrow("Full Shortlink", fullshortlink, false),
                    SizedBox(height: 20.0),
                    buildrow("Shortlink 2", shortlink2, false),
                    SizedBox(height: 20.0),
                    buildrow("Full Shortlink 2", fullshortlink2, false),
                    SizedBox(height: 20.0),
                    buildrow("Sharelink", sharelink, false),
                    SizedBox(height: 20.0),
                    buildrow("Original link", original, true),
                    SizedBox(height: 20.0),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
