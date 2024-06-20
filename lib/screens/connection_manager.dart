import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lg_ai_touristic_explorer/components/connection_flag.dart';
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionManager extends StatefulWidget {
  const ConnectionManager({super.key});

  @override
  State<ConnectionManager> createState() => _ConnectionManagerState();
}

class _ConnectionManagerState extends State<ConnectionManager> {
  bool connectionStatus = false;

  late LGConnection lg;
  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      connectionStatus = result!;
    });
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _loadSettings();
    _connectToLG();
  }

  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _sshPortController = TextEditingController();
  final TextEditingController _rigsController = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _sshPortController.dispose();
    _rigsController.dispose();
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
    });
  }

  Future<void> _saveSettings() async {
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkBackgroundColor,
      endDrawer: AppDrawer(
        size: size,
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: darkSecondaryColor,
          toolbarHeight: 150,
          elevation: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 50.h,
                      bottom: 55.h,
                    ),
                    child: Image.asset(
                      "assets/images/rame_170.png",
                      scale: 3.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 5.w, top: 45.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "AI Touristic Explorer",
                      style: googleTextStyle(35, FontWeight.w700, white),
                    ),
                    ConnectionFlag(
                      status: connectionStatus,
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                icon: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 45, 0),
                    child: Image.asset(drawerLogo)))
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.h,
            ),
            Container(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: darkSecondaryColor,
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
                                25.sp, FontWeight.w500, darkBackgroundColor),
                            controller: _ipController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Icon(
                                  Icons.computer,
                                  color: Colors.cyan,
                                  size: 25,
                                ),
                              ),
                              hintText: 'Enter Master IP',
                              hintStyle: googleTextStyle(
                                  25.sp, FontWeight.w500, darkBackgroundColor),
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
                      color: darkSecondaryColor,
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
                                25.sp, FontWeight.w500, darkBackgroundColor),
                            controller: _sshPortController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Icon(
                                  Icons.settings_ethernet,
                                  color: Colors.cyan,
                                  size: 25,
                                ),
                              ),
                              hintText: '22',
                              hintStyle: googleTextStyle(
                                  25.sp, FontWeight.w500, darkBackgroundColor),
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
            SizedBox(height: 25.h),
            Container(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: darkSecondaryColor,
                    ),
                    width: size.width * 0.4,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "No. of LG rigs",
                            style: googleTextStyle(
                                35.sp, FontWeight.w600, Colors.white),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextField(
                            style: googleTextStyle(
                                25.sp, FontWeight.w500, darkBackgroundColor),
                            controller: _rigsController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Icon(
                                  Icons.memory,
                                  color: Colors.cyan,
                                  size: 25,
                                ),
                              ),
                              hintText: 'Enter the number of rigs',
                              hintStyle: googleTextStyle(
                                  25.sp, FontWeight.w500, darkBackgroundColor),
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
            SizedBox(height: 25.h),
            Container(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: darkSecondaryColor,
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
                                25.sp, FontWeight.w500, darkBackgroundColor),
                            controller: _usernameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.cyan,
                                  size: 25,
                                ),
                              ),
                              hintText: 'Enter your username',
                              hintStyle: googleTextStyle(
                                  25.sp, FontWeight.w500, darkBackgroundColor),
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
                      color: darkSecondaryColor,
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
                          TextField(
                            obscureText: true,
                            style: googleTextStyle(
                                25.sp, FontWeight.w500, darkBackgroundColor),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.cyan,
                                  size: 25,
                                ),
                              ),
                              hintText: 'Enter your password',
                              hintStyle: googleTextStyle(
                                  25.sp, FontWeight.w500, darkBackgroundColor),
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
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          await _saveSettings();
          bool? result = await lg.connectToLG();
          print(result);
          if (result == true) {
            setState(() {
              connectionStatus = true;
            });

            print('Connected to LG successfully');
          }
          if (result == false || result == null) {
            print("asdas");
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "Connect to LG",
            textAlign: TextAlign.center,
            style: googleTextStyle(28.sp, FontWeight.w700, darkBackgroundColor),
          ),
          width: size.width * 0.1,
          height: size.width * 0.1,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              color: const Color.fromARGB(255, 99, 222, 239),
              borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }
}
