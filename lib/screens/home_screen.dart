import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:lg_ai_touristic_explorer/components/connection_flag.dart';
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/components/recommended_cities.dart';
import 'package:lg_ai_touristic_explorer/components/upper_bar.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:lg_ai_touristic_explorer/screens/city_information_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool lgStatus = false;
  bool aiStatus = false;
  late LGConnection lg;
  TextEditingController _textEditingController = TextEditingController();
  bool isCity = false;
  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      lgStatus = result!;
    });
    await lg.logosLG(logosLG, factorLogo);
  }

  _connectToAIServer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String ipAIServer = prefs.getString("ipAIServer") ?? "127.0.0.1";
      String portAIServer = prefs.getString("portAIServer") ?? "8107";
      String apiURL = "http://$ipAIServer:$portAIServer/hello";
      http.Response response = await http.get(Uri.parse(apiURL));
      if (response.statusCode == 200) {
        setState(() {
          aiStatus = true;
        });
      } else {}
    } catch (e) {
      print('Error checking AI server connection: $e');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
    _connectToAIServer();
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool("keyIsFirstLoaded");
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Important Notice",
                style:
                    googleTextStyle(50.sp, FontWeight.w700, Colors.blueAccent)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Be aware of AI hallucinations.",
                      style: googleTextStyle(
                          35.sp, FontWeight.w500, Colors.black)),
                  const SizedBox(height: 10),
                  Text(
                      "The state of the art of most AI tools as of 2024 can sometimes give you incorrect answers, or even the so-called Hallucinations. AI hallucinations are incorrect or misleading results that AI models generate. These errors can be caused by a variety of factors, including insufficient training data, incorrect assumptions made by the model, or biases in the data used to train the model.",
                      style: googleTextStyle(
                          28.sp, FontWeight.w400, Colors.black)),
                  const SizedBox(height: 15),
                  Text(
                      "The Liquid Galaxy project has no control over this, and the contents responsibility is of the owners of the respective Large Language models used.",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      )),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text("Agree",
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  prefs.setBool("keyIsFirstLoaded", false);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: darkBackgroundColor,
        endDrawer: AppDrawer(
          size: size,
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140.0),
          child: UpperBar(
              lgStatus: lgStatus,
              aiStatus: aiStatus,
              scaffoldKey: _scaffoldKey),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * .82,
                    height: 75,
                    padding: EdgeInsets.fromLTRB(0, 0, 125.w, 0),
                    decoration: BoxDecoration(
                      color: darkSecondaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: GooglePlaceAutoCompleteTextField(
                        textEditingController: _textEditingController,
                        googleAPIKey: "",
                        boxDecoration:
                            BoxDecoration(border: Border.all(width: 0)),
                        textStyle: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 66, 160, 237),
                                    Color.fromARGB(255, 106, 225, 110)
                                  ],
                                ).createShader(
                                    const Rect.fromLTWH(0.0, 0.0, 400.0, 70.0)),
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 66, 160, 237),
                                    Color.fromARGB(255, 106, 225, 110)
                                  ],
                                ).createShader(
                                    const Rect.fromLTWH(0.0, 0.0, 800.0, 70.0)),
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          hintText: "Search for a city",
                          prefixIcon: GestureDetector(
                            onTap: () {
                              print("Mic");
                            },
                            child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(26.w, 12.h, 26.w, 12.h),
                                child: const Icon(
                                  Icons.mic_rounded,
                                  size: 30,
                                  color: darkBackgroundColor,
                                )),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              top: 15.h, right: 30.w, bottom: 15.h),
                        ),
                        debounceTime: 800,
                        isLatLngRequired: true,
                        seperatedBuilder: const Divider(),
                        isCrossBtnShown: true,
                        itemClick: (Prediction prediction) async {
                          print(prediction.types);
                          for (var type in prediction.types!) {
                            if (type == "locality" ||
                                type == "administrative_area_level_3") {
                              isCity = true;
                              break;
                            }
                          }
                          if (isCity) {
                            await Future.delayed(Duration(seconds: 1));
                            print("It is a city");
                            print("placeDetails 2nd ${prediction.description}");
                            List<String> components =
                                prediction.description!.split(',');
                            String cityName = components[0].trim();
                            String secondName = components.length > 1
                                ? components[1].trim()
                                : "";

                            print("City Name: $cityName");
                            print("Country Name: $secondName");
                            print("City Name: $cityName");
                            double cityLat = double.parse(prediction.lat!);
                            double cityLong = double.parse(prediction.lng!);
                            LatLng coordinates = LatLng(cityLat, cityLong);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CityInformationScreen(
                                    cityName: cityName,
                                    countryName: secondName,
                                    coordinates: coordinates,
                                  ),
                                ));
                          } else {
                            // ToastService.showErrorToast(
                            //   context,
                            //   length: ToastLength.medium,
                            //   expandedHeight: 100,
                            //   message: "It is not a city, try again!",
                            // );
                            print("It is not a city, try again later");
                          }
                          setState(() {
                            isCity = false;
                          });
                        },
                        itemBuilder: (context, index, Prediction prediction) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: darkBackgroundColor,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      prediction
                                              .structuredFormatting!.mainText ??
                                          "",
                                      style: googleTextStyle(25.sp,
                                          FontWeight.w600, darkSecondaryColor),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                        prediction.structuredFormatting!
                                                .secondaryText ??
                                            "",
                                        style: googleTextStyle(20.sp,
                                            FontWeight.w500, Colors.black)),
                                  ],
                                ))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 55.h,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                width: size.width * .82,
                child: Text(
                  "Recommended Locations",
                  style: googleTextStyle(48.sp, FontWeight.w600, white),
                ),
              ),
              SizedBox(
                height: 55.h,
              ),
              const RecomendCities()
            ],
          ),
        )));
  }
}
