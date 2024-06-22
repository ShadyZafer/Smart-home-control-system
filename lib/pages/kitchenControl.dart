import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../extras/bedroom.dart';
import '../extras/mqtt.dart';
import '../extras/provider.dart';

class KitchenControl extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/kitchen.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
          child: Consumer<change>(
            builder: (context, change, child){
              return Column(
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
                        Text('Kitchen', style: TextStyle(color: Color(0xff193841), fontSize: 20.sp)),
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
                                    height: 220.h,
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
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        change.btn[1]
                                                            ?  Provider.of<MqttProvider>(context, listen: false).publishMessage('home/control', '{"light" : "on"}')
                                                            :  Provider.of<MqttProvider>(context, listen: false).publishMessage('home/control', '{"light" : "off"}');
                                                        change.btn1();
                                                      },
                                                      child: control(
                                                        icon: Icons.lightbulb,
                                                        isPressed: change.btn[0],
                                                        device: 'Lights',
                                                        activeColor: Colors.grey.shade900,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        change.btn2();
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
                                                ),
                                                SizedBox(height: 10.h),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10.w),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          change.btn[1]
                                                              ? Provider.of<MqttProvider>(context, listen: false).publishMessage('home', 'off')
                                                              : Provider.of<MqttProvider>(context, listen: false).publishMessage('home', 'on');
                                                          change.btn2();
                                                        },
                                                        child: preview(
                                                          icon: CupertinoIcons.flame_fill,
                                                          data: change.temp,
                                                          device: 'Flame Sensor',
                                                          activeColor: Colors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
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
              );
            }
          )
        ),
      ),
    );
  }

}