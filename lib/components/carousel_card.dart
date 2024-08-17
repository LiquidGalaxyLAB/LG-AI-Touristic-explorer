import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:lg_ai_touristic_explorer/models/orbit.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class CarouselCard extends StatefulWidget {
  final String factTitle;
  final String cityname;
  final String factDesc;
  final bool isOrbitable;
  final LatLng coordinates;
  final String imageURL;
  const CarouselCard({
    super.key,
    required this.factTitle,
    required this.factDesc,
    required this.cityname,
    required this.isOrbitable,
    required this.coordinates,
    required this.imageURL,
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
              backgroundColor: white,
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
                      style: googleTextStyle(50.sp, FontWeight.w700,
                          Theme.of(context).dividerColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          child: Container(),
                          visible: !widget.isOrbitable,
                        ),
                        GestureDetector(
                          onTap: () async {
                            try {
                              print(widget.imageURL);
                              await lg.cleanRightBalloon();
                              await lg.cleanVisualization();
                              await lg.sendStaticBalloon(
                                  "orbitballoon",
                                  widget.factTitle,
                                  widget.cityname,
                                  500,
                                  widget.factDesc,
                                  widget.imageURL);
                            } catch (e) {
                              ToastService.showErrorToast(
                                context,
                                length: ToastLength.medium,
                                expandedHeight: 100,
                                child: Text(
                                  translate('city.errorNotLG'),
                                  style: googleTextStyle(
                                      32.sp, FontWeight.w500, white),
                                ),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * .20,
                            width: widget.isOrbitable
                                ? size.width * 0.15
                                : size.width * 0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(70, 106, 150, 118),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Icon(
                                  Icons.public,
                                  color: Theme.of(context).primaryColor,
                                  size: 50,
                                ),
                                SizedBox(height: 17),
                                Text(
                                  translate('city.showin') + " LG",
                                  style: googleTextStyle(35.sp, FontWeight.w700,
                                      Theme.of(context).dividerColor),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            try {
                              await lg.cleanRightBalloon();
                            } catch (e) {
                              ToastService.showErrorToast(
                                context,
                                length: ToastLength.medium,
                                expandedHeight: 100,
                                child: Text(
                                  translate('city.errorNotLG'),
                                  style: googleTextStyle(
                                      32.sp, FontWeight.w500, white),
                                ),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * .20,
                            width: widget.isOrbitable
                                ? size.width * 0.15
                                : size.width * 0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(70, 106, 150, 118),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Icon(
                                  Icons.cleaning_services_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 50,
                                ),
                                SizedBox(height: 17),
                                Center(
                                  child: Text(
                                    translate('city.clean') + " Balloon",
                                    style: googleTextStyle(
                                        35.sp,
                                        FontWeight.w700,
                                        Theme.of(context).dividerColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        !widget.isOrbitable
                            ? GestureDetector(
                                onTap: () async {
                                  try {
                                    await lg.cleanVisualization();
                                    await lg.cleanRightBalloon();
                                    await lg.sendStaticBalloon(
                                        "orbitballoon",
                                        widget.factTitle,
                                        widget.cityname,
                                        500,
                                        widget.factDesc,
                                        widget.imageURL);
                                  } catch (e) {
                                    ToastService.showErrorToast(
                                      context,
                                      length: ToastLength.medium,
                                      expandedHeight: 100,
                                      child: Text(
                                        translate('city.errorNotLG'),
                                        style: googleTextStyle(
                                            32.sp, FontWeight.w500, white),
                                      ),
                                    );
                                    print(e);
                                  }
                                  var kml = Orbit().buildKmlForPlace(
                                      Orbit().generateOrbitContent(
                                          widget.coordinates),
                                      widget.coordinates,
                                      widget.factTitle);
                                  print(kml);
                                  try {
                                    for (var i = 0; i < 2; i++) {
                                      await lg.buildOrbit(kml);
                                      await Future.delayed(
                                          Duration(seconds: 1));
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
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
                                        color: Theme.of(context).primaryColor,
                                        size: 50,
                                      ),
                                      SizedBox(height: 17),
                                      Text(
                                        translate('city.orbit'),
                                        style: googleTextStyle(
                                            35.sp,
                                            FontWeight.w700,
                                            Theme.of(context).dividerColor),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox()
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
                          color: Theme.of(context).dividerColor,
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
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadiusDirectional.circular(25)),
        child: Container(
          width: size.width * 0.35,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                widget.factTitle,
                style: googleTextStyle(
                    40.sp, FontWeight.w700, Theme.of(context).dividerColor),
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
