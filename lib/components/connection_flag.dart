import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ConnectionFlag extends StatelessWidget {
  ConnectionFlag({required this.lgStatus});
  final bool lgStatus;

  @override
  Widget build(BuildContext context) {
    Color colorLG =
        lgStatus ? const Color.fromARGB(255, 0, 255, 8) : Colors.red;

    String label1 = lgStatus
        ? 'LG ' + translate('home.appbar.connected')
        : 'LG ' + translate('home.appbar.disconnected');

    return Container(
      padding: EdgeInsets.only(left: 77),
      height: 50,
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: colorLG,
            size: 14,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            label1,
            style: TextStyle(
                color: colorLG, fontWeight: FontWeight.w700, fontSize: 19.sp),
          ),
        ],
      ),
    );
  }
}
