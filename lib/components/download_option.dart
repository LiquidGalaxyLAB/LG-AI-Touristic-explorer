import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/connections/orbit_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:lg_ai_touristic_explorer/models/flyto.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/cityKMLData.dart';

class DownloadWidget extends StatefulWidget {
  final String option;
  final Size size;
  final String cityName;
  final String country;
  final LatLng coordinates;

  DownloadWidget({
    required this.option,
    required this.size,
    required this.cityName,
    required this.coordinates,
    required this.country,
  });

  @override
  _DownloadWidgetState createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  bool isDownloaded = false;
  bool isLoading = false; // Added loading state
  late LGConnection lg;

  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
    _checkInitialDownloadStatus();
  }

  void _checkInitialDownloadStatus() async {
    String name = widget.cityName.toLowerCase().replaceAll(" ", "");
    String optionNew = widget.option.toLowerCase().replaceAll(" ", "");
    if (optionNew == "historical fact") {
      optionNew = "historical";
    }
    if (optionNew == "outline" || optionNew == "historical") {
      isDownloaded = await _checkKmlDownloaded(name, optionNew);
      setState(() {});
    }
  }

  Future<void> sendData(
      Directory localPath, String cityName, String kmlName) async {
    print('${localPath.path}/$cityName/$kmlName.kml');
    double range = 10000;
    double tilt = 70;
    double heading = 0;
    FlyToView city = FlyToView(
        longitude: widget.coordinates.longitude,
        latitude: widget.coordinates.latitude,
        range: range,
        tilt: tilt,
        heading: heading);
    await lg.cleanVisualization();
    await lg.sendKMLFile(
        File('${localPath.path}/$cityName/$kmlName.kml'), kmlName);
    await lg.flyTo(city.getCommand());
    await lg.runKMLFile(kmlName);
  }

  Future<bool> _checkKmlDownloaded(String cityName, String option) async {
    String filePath =
        "/data/user/0/lg.ai_touristic_explorer/app_flutter/$cityName/${cityName}${option}.kml";
    print(filePath);
    File file = File(filePath);
    bool exists = await file.exists();
    print(exists);
    return exists;
  }

  Future<void> _downloadAndCheck() async {
    setState(() {
      isLoading = true; // Start loading
    });

    var localPath = await getApplicationDocumentsDirectory();
    String name = widget.cityName.toLowerCase().replaceAll(" ", "");
    String optionNew = widget.option.toLowerCase().replaceAll(" ", "");

    if (optionNew == "historicalfact") {

      optionNew = "historical";
    }
    if (!isDownloaded) {

      if (optionNew == "outline") {
        var url = data[name]?[0]['link'] ?? "";
        await downloadKml(url, "$name$optionNew", name);
      } else if (optionNew == "historical") {

        var url = data[name]?[1]['link'] ?? "";
        await downloadKml(url, "$name$optionNew", name);
      }
      isDownloaded = await _checkKmlDownloaded(name, optionNew);
      setState(() {});
    } else {
      String kmlName = "$name$optionNew";
      print(kmlName);
      await sendData(localPath, name, kmlName);
      String imageURL =
          await getPlaceIdFromName('${widget.cityName} ${widget.country}');
      print(imageURL);
      if (optionNew == "outline") {
        await lg.sendStaticBalloon("orbitballoon", "", widget.cityName, 500,
            data[name]?[0]['description'] ?? "Description", imageURL);
      } else if (optionNew == "historical") {
        await lg.sendStaticBalloon("orbitballoon", "", widget.cityName, 500,
            data[name]?[1]['description'] ?? "Description", imageURL);
      }

      print("Already Downloaded");
    }

    setState(() {
      isLoading = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _downloadAndCheck,
          child: Row(
            children: [
              isLoading
                  ? CircularProgressIndicator() // Show loader when downloading
                  : !isDownloaded
                      ? Image.asset(downloadIcon)
                      : Icon(
                          Icons.play_arrow,
                          color: Colors.green,
                          size: 30,
                        ),
              SizedBox(width: 20),
              Text(
                widget.option,
                style: googleTextStyle(40.sp, FontWeight.w600, Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 1,
          width: widget.size.width * 0.33,
          color: Colors.white.withOpacity(0.4),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
