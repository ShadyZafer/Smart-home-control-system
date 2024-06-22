import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color acc() => Color.fromARGB(255, 13, 51, 62);

Widget iconCirc({required IconData icon, required Color color, double width = 40, double height = 40, double iconSize = 20, required Color backColor}){
  return Container(
    width: width.sp, // Adjust the width as needed
    height: height.sp, // Adjust the height as needed
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backColor, // Adjust the color as needed
    ),
    child: Center(
      child: Icon(icon, color: color, size: iconSize.sp),
    ),
  );
}

Widget devices({required IconData icon, required String device, required Color activeColor, double size = 25, String number = '2 Devices'}){
  return Container(
      height: 80.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color.fromARGB(255, 55, 184, 193).withOpacity(0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconCirc(
                width: size.sp,
                height: size.sp,
                backColor: Color.fromARGB(255, 45, 100, 117),
                icon: icon,
                color: Colors.white,
            ),
            txt(
              title: device,
              size: 14,
              weight: FontWeight.normal
            ),
            Row(
              children: [
                Container(
                  width: 5.sp,
                  height: 5.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeColor, // Adjust the color as needed
                  ),
                ),
                SizedBox(width: 5),
                txt(
                  title: number,
                  size: 12,
                  weight: FontWeight.normal,
                  color: Colors.grey
                )
              ],
            )
          ],
        ),
      ),
    );
}

Widget roomDev({required IconData icon}){
  return Container(
    height: 55.sp,
    width : 55.sp,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.r),
      color: Color.fromARGB(255, 49, 126, 152).withOpacity(0.9),
    ),
    child: Center(
      child: Icon(icon, color: Color.fromARGB(255, 55, 184, 193),),
    ),
  );
}

Widget txt({required String title, Color color = Colors.white, FontWeight weight = FontWeight.bold, double size = 17})
=> Text(
  title,
  style: TextStyle(
    color: color,
    fontWeight: weight,
    fontFamily: 'main',
    fontSize: size.sp
  ),
  softWrap: true,
);
