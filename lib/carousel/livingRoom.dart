import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gdp/extras/bedroom.dart';
import 'package:gdp/pages/LivingControl.dart';

import '../extras.dart';

class Living extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LivingControl()),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            image: DecorationImage(
              image: AssetImage('assets/images/living.jpg'),
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
                    Container(
                      width: 40.sp, // Adjust the width as needed
                      height: 40.sp, // Adjust the height as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF264854), // Adjust the color as needed
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/couch.svg',
                          color: Colors.white,
                          width : 25.sp,
                          height: 25.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    txt(
                      title: 'Living Room',
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
                    roomDev(icon: Icons.ac_unit),
                    SizedBox(height: 5.h),
                    roomDev(icon: Icons.window_outlined),
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