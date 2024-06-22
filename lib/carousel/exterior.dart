import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gdp/extras/bedroom.dart';
import 'package:gdp/pages/outdoorsControl.dart';

import '../extras.dart';

class Exterior extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => outdoorControl()),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Container(
          height: double.maxFinite,
          width : double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            image: DecorationImage(
              image: AssetImage('assets/images/home.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    iconCirc(
                        icon: CupertinoIcons.bed_double_fill,
                        color: Colors.white,
                        backColor: Color(0xFF264854)
                    ),
                    SizedBox(width: 10.w),
                    txt(
                        title: 'Garden',
                        weight: FontWeight.normal,
                        size: 15
                    )
                  ],
                ),
                SizedBox(height: 15.h),
                Column(
                  children: [
                    roomDev(icon: Icons.lightbulb),
                    SizedBox(height: 5.h),
                    roomDev(icon: Icons.water_drop),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}