import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/components/upper_bar.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool lgStatus = false;
  late LGConnection lg;

  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      lgStatus = result!;
    });
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
  }

  _launchURL(Uri url) async {
    await launchUrl(url);
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 0, 16, 44),
      endDrawer: AppDrawer(size: size),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child: UpperBar(lgStatus: lgStatus, scaffoldKey: _scaffoldKey),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Image.asset(splash),
              SizedBox(height: 30.h),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
                child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: darkSecondaryColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          translate('about.description1'),
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              letterSpacing: 1,
                              color: white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 20),
                        Text(
                          translate('about.description2'),
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              letterSpacing: 1,
                              color: white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 20),
                        Text(
                          translate('about.description3'),
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              letterSpacing: 1,
                              color: white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    )),
              ),
              SizedBox(height: 40),
              Container(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: translate('about.contributor'),
                            style: googleTextStyle(22, FontWeight.w500,
                                Colors.cyan), // Title style
                          ),
                          TextSpan(
                            text: 'Manas Dalvi',
                            style: googleTextStyle(22, FontWeight.w500, white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: translate('about.mentor'),
                            style: googleTextStyle(22, FontWeight.w500,
                                Colors.cyan), // Title style
                          ),
                          TextSpan(
                            text: 'Alfredo Bautista',
                            style: googleTextStyle(22, FontWeight.w500, white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: translate('about.admin'),
                            style: googleTextStyle(22, FontWeight.w500,
                                Colors.cyan), // Title style
                          ),
                          TextSpan(
                            text: 'Andreu Ibanez',
                            style: googleTextStyle(22, FontWeight.w500, white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      translate('about.contact'),
                      style: googleTextStyle(22, FontWeight.w500, Colors.white),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: white.withOpacity(1),
                      ),
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                  "https://w7.pngwing.com/pngs/817/967/png-transparent-gmail-logo-gmail-email-icon-logo-gmail-logo-angle-text-rectangle.png",
                                  scale: 15),
                              SizedBox(
                                height: 15.h,
                              ),
                              Linkify(
                                onOpen: _onOpen,
                                text: "dalvimana33@gmail.com",
                                style:
                                    googleTextStyle(22, FontWeight.w500, white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.network(
                                  "https://seeklogo.com/images/G/github-logo-7880D80B8D-seeklogo.com.png",
                                  scale: 5),
                              SizedBox(
                                height: 15.h,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _launchURL(Uri.parse(
                                        'https://github.com/Manas-33'));
                                  },
                                  child: Text(
                                    "Github",
                                    textAlign: TextAlign.center,
                                    style: googleTextStyle(
                                        22, FontWeight.w600, Colors.black),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              Image.network(
                                  "https://cdn1.iconfinder.com/data/icons/logotypes/32/circle-linkedin-1024.png",
                                  scale: 18),
                              SizedBox(
                                height: 15.h,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _launchURL(Uri.parse(
                                        'https://www.linkedin.com/in/manasdalvi/'));
                                  },
                                  child: Text(
                                    "LinkedIn",
                                    textAlign: TextAlign.center,
                                    style: googleTextStyle(
                                        22, FontWeight.w600, Colors.black),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              Image.network(
                                  "https://logowik.com/content/uploads/images/twitter-x5265.logowik.com.webp",
                                  scale: 15),
                              SizedBox(
                                height: 15.h,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        Uri.parse('https://x.com/manas__33'));
                                  },
                                  child: Text(
                                    "Twitter",
                                    textAlign: TextAlign.center,
                                    style: googleTextStyle(
                                        22, FontWeight.w600, Colors.black),
                                  )),
                            ],
                          ),
                          //
                        ],
                      ),
                    ),
                    SizedBox(height: 50)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
