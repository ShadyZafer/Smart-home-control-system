import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdp/extras/provider.dart';
import 'package:provider/provider.dart';
import 'mqtt.dart';
import '../extras.dart';

class MasterControl extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/master.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                        height: 35.sp,
                        width: 35.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.sp),
                          color: Color.fromARGB(255, 0, 52, 89).withOpacity(0.5),
                        ),
                        child: Center(child: Icon(CupertinoIcons.back, color: Colors.white,)),
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    Text('Bedroom', style: TextStyle(color: Colors.black, fontSize: 20.sp)),
                    InkWell(
                      onTap: (){
                        //publishMessage('home', 'on');
                      },
                      child: Container(
                        height: 35.sp,
                        width: 35.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.sp),
                          color: Color.fromARGB(255, 0, 52, 89).withOpacity(0.5),
                        ),
                        child: Center(child: Icon(CupertinoIcons.ellipsis_vertical, color: Colors.white,)),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.r),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 120.h,
                                width: double.maxFinite,
                                color: Color.fromARGB(255, 26, 26, 26).withOpacity(0.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(height: 5.h),
                                    Container(
                                      height: 3.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25.r),
                                          color: Colors.white54
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.h, bottom: 7.h),
                                      child: Consumer<change>(
                                        builder: (context, change, child){
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  change.btn[0]
                                                      ?  Provider.of<MqttProvider>(context, listen: false).publishMessage('home/control', '{"light" : "off"}')
                                                      :  Provider.of<MqttProvider>(context, listen: false).publishMessage('home/control', '{"light" : "on"}');
                                                  change.btn1();
                                                },
                                                child:control(
                                                      icon: Icons.lightbulb,
                                                      isPressed: change.btn[0],
                                                      device: 'Lights',
                                                      activeColor: Colors.grey.shade900,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                },
                                                child: Consumer<MqttProvider>(
                                                  builder: (context, mqttProvider, child){
                                                    return preview(
                                                      icon: CupertinoIcons.thermometer,
                                                      data: mqttProvider.sensorData?.temperature.toString() ?? '20 \°C',
                                                      device: 'Temperature',
                                                      activeColor: Colors.green,
                                                    );
                                                  }
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            )
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget control({required IconData icon, required String device, required Color activeColor, double size = 30, required bool isPressed}){
  return Container(
    height: 90.h,
    width: 150.w,
    decoration: BoxDecoration(
      border: Border.all(
        color: isPressed? Color(0xFF3d7f8e) : Colors.transparent,
        width: 2.sp
      ),
      borderRadius: BorderRadius.circular(20.r),
      color: isPressed? Color(0xFF3d7f8e).withOpacity(0.5) : Color.fromARGB(255, 0, 52, 89).withOpacity(0.5),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 10.w),
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
          Text('\t$device', style: TextStyle(color: Colors.white, fontSize: 17.sp)),
          Row(
            children: [
              Container(
                width: 5.w,
                height: 5.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPressed? Colors.green : Colors.grey, // Adjust the color as needed
                ),
              ),
              SizedBox(width: 5.w),
              Text('1 Device', style: TextStyle(color: Color.fromARGB(255, 132, 143, 173), fontSize: 12.sp)),
            ],
          )
        ],
      ),
    ),
  );
}

Widget preview({required String data, required IconData icon, required String device, required Color activeColor, double size = 30}){
  return Container(
    height: 90.h,
    width: 150.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.r),
      color: Color.fromARGB(255, 0, 52, 89).withOpacity(0.5),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              iconCirc(
                width: size.sp,
                height: size.sp,
                backColor: Color.fromARGB(255, 45, 100, 117),
                icon: icon,
                color: Colors.white,
              ),
              SizedBox(width: 10.w),
              txt(
                title: data,
                weight: FontWeight.normal
              )
            ],
          ),
          Text('\t$device', style: TextStyle(color: Colors.white, fontSize: 17.sp)),
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
              SizedBox(width: 5.w),
              Text('1 Device', style: TextStyle(color: Color.fromARGB(255, 132, 143, 173), fontSize: 12.sp)),
            ],
          )
        ],
      ),
    ),
  );
}
