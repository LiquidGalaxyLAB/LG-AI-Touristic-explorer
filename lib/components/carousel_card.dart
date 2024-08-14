import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';

class CarouselCard extends StatefulWidget {
  final String factTitle;
  final String cityname;
  final String factDesc;
  const CarouselCard({
    super.key,
    required this.factTitle,
    required this.factDesc,
    required this.cityname,
  });

  @override
  State<CarouselCard> createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
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
    // TODO: implement initState
    super.initState();
    lg = LGConnection();
    _connectToLG();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              backgroundColor: greenShade,
              child: Container(
                width: size.width * 0.5, // Adjust the width to make it a square
                height:
                    size.width * 0.5, // Adjust the height to make it a square
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      widget.factTitle,
                      style: googleTextStyle(50.sp, FontWeight.w700, fontGreen),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await lg.cleanRightBalloon();
                            await lg.cleanVisualization();
                            await lg.sendStaticBalloon(
                                "orbitballoon",
                                widget.factTitle,
                                widget.cityname,
                                500,
                                widget.factDesc,
                                mainLogoAWS);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * .20,
                            width: size.width * 0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(70, 106, 150, 118),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Icon(
                                  Icons.public,
                                  color: darkBackgroundColor,
                                  size: 50,
                                ),
                                SizedBox(height: 17),
                                Text(
                                  translate('city.showin') + " LG",
                                  style: googleTextStyle(
                                      35.sp, FontWeight.w700, fontGreen),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await lg.cleanRightBalloon();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * .20,
                            width: size.width * 0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(70, 106, 150, 118),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Icon(
                                  Icons.cleaning_services_outlined,
                                  color: darkBackgroundColor,
                                  size: 50,
                                ),
                                SizedBox(height: 17),
                                Center(
                                  child: Text(
                                    translate('city.clean') + " Balloon",
                                    style: googleTextStyle(
                                        35.sp, FontWeight.w700, fontGreen),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await lg.sendStaticBalloon(
                                "orbitballoon",
                                widget.factTitle,
                                widget.cityname,
                                500,
                                widget.factDesc,
                                mainLogoAWS);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * .20,
                            width: size.width * 0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(70, 106, 150, 118),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Icon(
                                  Icons.restart_alt,
                                  color: darkBackgroundColor,
                                  size: 50,
                                ),
                                SizedBox(height: 17),
                                Text(
                                  translate('city.orbit'),
                                  style: googleTextStyle(
                                      35.sp, FontWeight.w700, fontGreen),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.factDesc,
                          style: googleTextStyle(
                              38.sp, FontWeight.w500, Colors.black),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: fontGreen,
                        ),
                        child: Text(
                          translate('city.close'),
                          style: googleTextStyle(30.sp, FontWeight.w500, white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: greenShade,
            borderRadius: BorderRadiusDirectional.circular(25)),
        child: Container(
          width: size.width * 0.35,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                widget.factTitle,
                style: googleTextStyle(40.sp, FontWeight.w700, fontGreen),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.35,
                child: Text(
                  widget.factDesc,
                  style: googleTextStyle(28.sp, FontWeight.w500, Colors.black),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }
}
