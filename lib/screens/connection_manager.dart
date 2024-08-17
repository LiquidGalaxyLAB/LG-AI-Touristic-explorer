import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lg_ai_touristic_explorer/components/connection_flag.dart';
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/components/upper_bar.dart';

import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConnectionManager extends StatefulWidget {
  bool discovery;
  final GlobalKey<State<StatefulWidget>> apiKeysKey;
  ConnectionManager(
      {super.key, required this.discovery, required this.apiKeysKey});

  @override
  State<ConnectionManager> createState() => _ConnectionManagerState();
}

class _ConnectionManagerState extends State<ConnectionManager> {
  bool lgStatus = false;
  bool passwordVisible = false;
  bool geminiVisible = false;
  bool deepgramVisible = false;
  bool mapsAPIVisible = false;

  late LGConnection lg;
  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      lgStatus = result!;
    });
  }

  _checkOrigin() {
    if (widget.discovery == true) {
      setState(() {
        isLGScreen = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _loadSettings();
    _connectToLG();
    _checkOrigin();
  }

  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _sshPortController = TextEditingController();
  final TextEditingController _rigsController = TextEditingController();
  final TextEditingController _geminiAPIKey = TextEditingController();
  final TextEditingController _deepgramAPIKey = TextEditingController();
  //make one for googlemapsapi key
  final TextEditingController _googleMapsAPIKey = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _sshPortController.dispose();
    _rigsController.dispose();
    _geminiAPIKey.dispose();
    _deepgramAPIKey.dispose();
    _googleMapsAPIKey.dispose();

    super.dispose();
  }

  Future<void> _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ipController.text = prefs.getString('ipAddress') ?? '';
      _usernameController.text = prefs.getString('username') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _sshPortController.text = prefs.getString('sshPort') ?? '';
      _rigsController.text = prefs.getString('numberOfRigs') ?? '';
      _geminiAPIKey.text = prefs.getString('geminiAPI') ?? '';
      _deepgramAPIKey.text = prefs.getString('deepgramAPI') ?? '';
      _googleMapsAPIKey.text = prefs.getString('mapsAPI') ?? '';
    });
  }

  Future<void> _saveLGSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_ipController.text.isNotEmpty) {
      await prefs.setString('ipAddress', _ipController.text);
    }
    if (_usernameController.text.isNotEmpty) {
      await prefs.setString('username', _usernameController.text);
    }
    if (_passwordController.text.isNotEmpty) {
      await prefs.setString('password', _passwordController.text);
    }
    if (_sshPortController.text.isNotEmpty) {
      await prefs.setString('sshPort', _sshPortController.text);
    }
    if (_rigsController.text.isNotEmpty) {
      await prefs.setString('numberOfRigs', _rigsController.text);
    }
  }

  Future<void> _saveAPISettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_geminiAPIKey.text.isNotEmpty) {
      await prefs.setString('geminiAPI', _geminiAPIKey.text);
    }
    if (_deepgramAPIKey.text.isNotEmpty) {
      await prefs.setString('deepgramAPI', _deepgramAPIKey.text);
    }
    if (_googleMapsAPIKey.text.isNotEmpty) {
      await prefs.setString('mapsAPI', _googleMapsAPIKey.text);
    }
  }

  bool isLGScreen = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      endDrawer: AppDrawer(
        size: size,
      ),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140.0),
          child: UpperBar(lgStatus: lgStatus, scaffoldKey: _scaffoldKey)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.h,
            ),
            Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLGScreen = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: isLGScreen
                              ? Theme.of(context).cardColor
                              : Theme.of(context).cardColor.withOpacity(0.4),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        "LG Rig",
                        style: googleTextStyle(
                            40.sp, FontWeight.w600, Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 160.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLGScreen = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: !isLGScreen
                              ? Theme.of(context).cardColor
                              : Theme.of(context).cardColor.withOpacity(0.4),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        "Set API Keys",
                        style: googleTextStyle(
                            40.sp, FontWeight.w600, Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            isLGScreen
                ? Column(
                    children: [
                      Container(
                        width: size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              width: size.width * 0.4,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "IP Address",
                                      style: googleTextStyle(
                                          35.sp, FontWeight.w600, Colors.white),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      keyboardType: TextInputType.number,
                                      style: googleTextStyle(
                                          25.sp,
                                          FontWeight.w500,
                                          Theme.of(context).primaryColor),
                                      controller: _ipController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                          ),
                                          child: Icon(
                                            Icons.computer,
                                            color: Theme.of(context).hintColor,
                                            size: 25,
                                          ),
                                        ),
                                        hintText: translate(
                                            'connectionManager.hintTextIP'),
                                        hintStyle: googleTextStyle(
                                            25.sp,
                                            FontWeight.w500,
                                            Theme.of(context).primaryColor),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 30, horizontal: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              width: size.width * 0.4,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "SSH Port",
                                      style: googleTextStyle(
                                          35.sp, FontWeight.w600, Colors.white),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      style: googleTextStyle(
                                          25.sp,
                                          FontWeight.w500,
                                          Theme.of(context).primaryColor),
                                      controller: _sshPortController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                          ),
                                          child: Icon(
                                            Icons.settings_ethernet,
                                            color: Theme.of(context).hintColor,
                                            size: 25,
                                          ),
                                        ),
                                        hintText:
                                            translate('connectionManager.22'),
                                        hintStyle: googleTextStyle(
                                            25.sp,
                                            FontWeight.w500,
                                            Theme.of(context).primaryColor),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 30, horizontal: 30),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35.h),
                      Container(
                        width: size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              width: size.width * 0.4,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      translate('connectionManager.lgscreens'),
                                      style: googleTextStyle(
                                          35.sp, FontWeight.w600, Colors.white),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      style: googleTextStyle(
                                          25.sp,
                                          FontWeight.w500,
                                          Theme.of(context).primaryColor),
                                      controller: _rigsController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                          ),
                                          child: Icon(
                                            Icons.memory,
                                            color: Theme.of(context).hintColor,
                                            size: 25,
                                          ),
                                        ),
                                        hintText: translate(
                                            'connectionManager.hintTextScreens'),
                                        hintStyle: googleTextStyle(
                                            25.sp,
                                            FontWeight.w500,
                                            Theme.of(context).primaryColor),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 30, horizontal: 30),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              width: size.width * 0.4,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "LG Username",
                                      style: googleTextStyle(
                                          35.sp, FontWeight.w600, Colors.white),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      style: googleTextStyle(
                                          25.sp,
                                          FontWeight.w500,
                                          Theme.of(context).primaryColor),
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            color: Theme.of(context).hintColor,
                                            size: 25,
                                          ),
                                        ),
                                        hintText: translate(
                                            'connectionManager.hintTextUsername'),
                                        hintStyle: googleTextStyle(
                                            25.sp,
                                            FontWeight.w500,
                                            Theme.of(context).primaryColor),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 30, horizontal: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35.h),
                      Container(
                        width: size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              width: size.width * 0.4,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "LG Password",
                                      style: googleTextStyle(
                                          35.sp, FontWeight.w600, Colors.white),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Stack(children: [
                                      TextField(
                                        obscureText: !passwordVisible,
                                        style: googleTextStyle(
                                            25.sp,
                                            FontWeight.w500,
                                            Theme.of(context).primaryColor),
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 5.0,
                                            ),
                                            child: Icon(
                                              Icons.lock,
                                              color:
                                                  Theme.of(context).hintColor,
                                              size: 25,
                                            ),
                                          ),
                                          hintText: translate(
                                              'connectionManager.hintTextPassword'),
                                          hintStyle: googleTextStyle(
                                              25.sp,
                                              FontWeight.w500,
                                              Theme.of(context).primaryColor),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 30, horizontal: 30),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        padding: EdgeInsets.only(
                                            top: 23.h, right: 20.w),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                passwordVisible =
                                                    !passwordVisible;
                                              });
                                            },
                                            icon: passwordVisible
                                                ? Icon(
                                                    size: 30,
                                                    Icons.visibility_off,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  )
                                                : Icon(
                                                    size: 30,
                                                    Icons.visibility,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  )),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              height: 200,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () async {
                                  await _saveLGSettings();
                                  bool? result = await lg.connectToLG();
                                  print(result);
                                  if (result == true) {
                                    setState(() {
                                      lgStatus = true;
                                    });

                                    print('Connected to LG successfully');
                                  }
                                  if (result == false || result == null) {
                                    print("asdas");
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.21,
                                  height: 175,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        translate('connectionManager.connect'),
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                        style: googleTextStyle(
                                            40.sp,
                                            FontWeight.w600,
                                            Theme.of(context).primaryColor),
                                      ),
                                      Text(
                                        "Liquid Galaxy Rig",
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                        style: googleTextStyle(
                                            40.sp,
                                            FontWeight.w600,
                                            Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Column(
                    key: widget.apiKeysKey,
                    children: [
                      Container(
                        width: size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              width: size.width * 0.4,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Gemini API Key",
                                      style: googleTextStyle(
                                          35.sp, FontWeight.w600, Colors.white),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Stack(children: [
                                      TextField(
                                        obscureText: !geminiVisible,
                                        keyboardType: TextInputType.number,
                                        style: googleTextStyle(
                                            25.sp,
                                            FontWeight.w500,
                                            Theme.of(context).primaryColor),
                                        controller: _geminiAPIKey,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 5.0,
                                            ),
                                            child: Icon(
                                              Icons.computer,
                                              color:
                                                  Theme.of(context).hintColor,
                                              size: 25,
                                            ),
                                          ),
                                          hintText: translate(
                                              'connectionManager.hintGeminiAPI'),
                                          hintStyle: googleTextStyle(
                                              25.sp,
                                              FontWeight.w500,
                                              Theme.of(context).primaryColor),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 30, horizontal: 30),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        padding: EdgeInsets.only(
                                            top: 23.h, right: 20.w),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                geminiVisible = !geminiVisible;
                                              });
                                            },
                                            icon: geminiVisible
                                                ? Icon(
                                                    size: 30,
                                                    Icons.visibility_off,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  )
                                                : Icon(
                                                    size: 30,
                                                    Icons.visibility,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  )),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              width: size.width * 0.4,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Deepgram API Key",
                                      style: googleTextStyle(
                                          35.sp, FontWeight.w600, Colors.white),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Stack(children: [
                                      TextField(
                                        style: googleTextStyle(
                                            25.sp,
                                            FontWeight.w500,
                                            Theme.of(context).primaryColor),
                                        obscureText: !deepgramVisible,
                                        controller: _deepgramAPIKey,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 5.0,
                                            ),
                                            child: Icon(
                                              Icons.settings_ethernet,
                                              color:
                                                  Theme.of(context).hintColor,
                                              size: 25,
                                            ),
                                          ),
                                          hintText: translate(
                                              'connectionManager.hintDeepgramAPI'),
                                          hintStyle: googleTextStyle(
                                              25.sp,
                                              FontWeight.w500,
                                              Theme.of(context).primaryColor),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 30, horizontal: 30),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        padding: EdgeInsets.only(
                                            top: 23.h, right: 20.w),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                deepgramVisible =
                                                    !deepgramVisible;
                                              });
                                            },
                                            icon: deepgramVisible
                                                ? Icon(
                                                    size: 30,
                                                    Icons.visibility_off,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  )
                                                : Icon(
                                                    size: 30,
                                                    Icons.visibility,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  )),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60.h),
                      Container(
                        width: size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              width: size.width * 0.4,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Google Maps API Key",
                                      style: googleTextStyle(
                                          35.sp, FontWeight.w600, Colors.white),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Stack(children: [
                                      TextField(
                                        style: googleTextStyle(
                                            25.sp,
                                            FontWeight.w500,
                                            Theme.of(context).primaryColor),
                                        obscureText: !mapsAPIVisible,
                                        controller: _googleMapsAPIKey,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                // left: 5.0,
                                                ),
                                            child: Icon(
                                              Icons.lock,
                                              color:
                                                  Theme.of(context).hintColor,
                                              size: 25,
                                            ),
                                          ),
                                          hintText: translate(
                                              'connectionManager.hintTextMapsAPI'),
                                          hintStyle: googleTextStyle(
                                              25.sp,
                                              FontWeight.w500,
                                              Theme.of(context).primaryColor),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 30, horizontal: 30),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        padding: EdgeInsets.only(
                                            top: 23.h, right: 20.w),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                mapsAPIVisible =
                                                    !mapsAPIVisible;
                                              });
                                            },
                                            icon: mapsAPIVisible
                                                ? Icon(
                                                    size: 30,
                                                    Icons.visibility_off,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  )
                                                : Icon(
                                                    size: 30,
                                                    Icons.visibility,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  )),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              height: 200,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () async {
                                    await _saveAPISettings();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: size.width * 0.21,
                                    margin: EdgeInsets.only(right: 140.w),
                                    height: 120,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          translate(
                                              'connectionManager.connect'),
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                          style: googleTextStyle(
                                              40.sp,
                                              FontWeight.w600,
                                              Theme.of(context).primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),

      // ),
    );
  }
}
