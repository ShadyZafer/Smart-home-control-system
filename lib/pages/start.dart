import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdp/extras.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'home.dart';
import 'signup.dart';
import 'package:widget_mask/widget_mask.dart';

class start extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/start2.png"),
            fit: BoxFit.cover,
             alignment: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 40.h),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: 260.h,
                  width: 350.w,
                  color: Color.fromARGB(255, 21, 80, 100).withOpacity(0.4),
                  child: Column(
                    children: [
                      SizedBox(height: 15.h),
                      WidgetMask(
                        blendMode: BlendMode.srcATop,
                          childSaveLayer: true,
                          mask: Image(image: AssetImage("assets/images/blur3.jpg"),
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomCenter,
                          ),
                          child: Text('\t\t\t\tTake Full Control\n Of Your Smart Home', style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold,color: Colors.white),)),
                      SizedBox(height: 10.h),
                      Text('Experience Unparalleled convenience,\nsecurity, and energy efficiency with our',
                      style: TextStyle(fontSize: 15.sp, color: Color.fromARGB(255, 84, 111, 118)),
                      ),
                      Text('intuitive and innovative app',
                        style: TextStyle(fontSize: 15.sp, color: Color.fromARGB(255, 84, 111, 118)),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: SlideAction(
                          height: 50,
                          sliderButtonIconPadding: 10,
                          elevation: 0,
                          innerColor: Color.fromARGB(255, 55, 184, 193),
                          outerColor: Color.fromARGB(255, 8, 35, 44),
                          sliderRotate: true,
                          sliderButtonIcon: const Icon(
                            Icons.home,
                            color: Color.fromARGB(255, 8, 35, 44),
                          ),
                          text: 'Log In',textStyle: TextStyle(fontSize: 20.sp, color: Color.fromARGB(255, 167, 210, 207)),
                          onSubmit: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => home()),
                            );
                          },
                        ),
                      ),
                      txt(
                        title: 'Sign Up',
                        color: Color(0xff28cedd)
                      )
                    ],
                  ),
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}