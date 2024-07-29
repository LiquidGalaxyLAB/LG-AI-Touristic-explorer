import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectionFlag extends StatelessWidget {
  ConnectionFlag({required this.lgStatus, required this.aiStatus});
  final bool lgStatus;
  final bool aiStatus;

  @override
  Widget build(BuildContext context) {
    Color colorLG =
        lgStatus ? const Color.fromARGB(255, 0, 255, 8) : Colors.red;
    Color colorAI =
        aiStatus ? const Color.fromARGB(255, 0, 255, 8) : Colors.red;
    String label1 = lgStatus ? 'LG CONNECTED' : 'LG DISCONNECTED';
    String label2 = aiStatus ? 'AI SERVER CONNECTED' : 'AI SERVER DISCONNECTED';
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
          SizedBox(
            width: 15.0,
          ),
          Icon(
            Icons.circle,
            color: colorAI,
            size: 14,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            label2,
            style: TextStyle(
                color: colorAI, fontWeight: FontWeight.w700, fontSize: 19.sp),
          )
        ],
      ),
    );
  }
}
