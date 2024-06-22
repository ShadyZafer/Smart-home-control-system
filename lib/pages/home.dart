import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../carousel/exterior.dart';
import '../carousel/guestBed.dart';
import '../carousel/kitchen.dart';
import '../carousel/livingRoom.dart';
import '../carousel/masterBed.dart';
import '../extras.dart';
import '../extras/mqtt.dart';
import '../extras/navbar.dart';
import '../extras/provider.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final _controller = PageController();
  List items = [Living(), MasterBed(), GuestBed(), Kitchen(), Exterior()];
  bool isButtonToggled = false;

  @override
  void initState() {
    super.initState();
    Provider.of<MqttProvider>(context, listen: false).addListener(_mqttListener);
  }

  @override
  void dispose() {
    Provider.of<MqttProvider>(context, listen: false).removeListener(_mqttListener);
    super.dispose();
  }

  void _mqttListener() {
    final mqttProvider = Provider.of<MqttProvider>(context, listen: false);
    if (mqttProvider.latestFlameMessage != null) {
      _showPopup('Flame Alert', mqttProvider.latestFlameMessage!, 'Turn off buzzer');
      mqttProvider.clearLatestFlameMessage();
    }
    if (mqttProvider.latestRainMessage != null) {
      _showPopup('Rain Alert', mqttProvider.latestRainMessage!, 'ok');
      mqttProvider.clearLatestRainMessage();
    }
  }

  void _showPopup(String title, String message, String prompt) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: txt(title: prompt, color: Colors.red),
              onPressed: () {
                Provider.of<MqttProvider>(context, listen: false).publishMessage('home/control', '{"buzzer": "off"}');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => home()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: navbar(),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Color.fromARGB(255, 12, 26, 37).withOpacity(0.5),
            child: Padding(
              padding: EdgeInsets.only(top: 10.h, left: 15.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Provider.of<change>(context, listen: false).subscribe(context);
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/images/ali.jpeg'),
                                radius: 20.r,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            txt(
                              title: 'Hello Ali',
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isButtonToggled = !isButtonToggled; // Toggle the button state on press
                              if (isButtonToggled == false) {
                                Provider.of<MqttProvider>(context, listen: false).disconnect();
                              } else if (isButtonToggled == true) {
                                Provider.of<MqttProvider>(context, listen: false).connect();
                              }
                            });
                          },
                          child: Icon(
                            CupertinoIcons.power,
                            color: isButtonToggled ? Colors.white : Color.fromARGB(255, 55, 184, 193),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: isButtonToggled ? Colors.redAccent : Color.fromARGB(255, 55, 184, 193).withOpacity(0.4),
                            padding: EdgeInsets.all(10.sp),
                            elevation: 0,
                            fixedSize: Size(45, 45),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Container(
                      height: 80.h,
                      width: 370.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Color.fromARGB(255, 55, 184, 193).withOpacity(0.4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 7.h, right: 15.w, left: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                txt(
                                  title: 'Energy',
                                  size: 15,
                                ),
                                txt(
                                  title: 'Consumption',
                                  size: 15,
                                ),
                                SizedBox(height: 13),
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.calendar, color: Color.fromARGB(255, 55, 184, 193), size: 20.sp),
                                    SizedBox(width: 5),
                                    txt(
                                      title: '13/11/2024',
                                      size: 13,
                                      weight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    iconCirc(
                                      backColor: acc(),
                                      width: 25.sp,
                                      height: 25.sp,
                                      iconSize: 15.sp,
                                      icon: Icons.bolt,
                                      color: Color.fromARGB(255, 55, 184, 193),
                                    ),
                                    SizedBox(height: 5),
                                    txt(
                                      title: '30.5kWh',
                                      size: 14,
                                      weight: FontWeight.normal,
                                    ),
                                    txt(
                                      title: 'Today',
                                      color: Color.fromARGB(255, 132, 143, 173),
                                      weight: FontWeight.normal,
                                      size: 13,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 25),
                                SizedBox(
                                  width: 60.w,
                                  child: Column(
                                    children: [
                                      iconCirc(
                                        backColor: acc(),
                                        width: 25.sp,
                                        height: 25.sp,
                                        iconSize: 15.sp,
                                        icon: Icons.thermostat,
                                        color: Color.fromARGB(255, 55, 184, 193),
                                      ),
                                      SizedBox(height: 5),
                                      Consumer<MqttProvider>(
                                        builder: (context, mqttProvider, child) {
                                          return txt(
                                            title: mqttProvider.sensorData?.temperature.toString() ?? '20\°C',
                                            size: 14,
                                            weight: FontWeight.normal,
                                          );
                                        },
                                      ),
                                      txt(
                                        title: 'Now',
                                        color: Color.fromARGB(255, 132, 143, 173),
                                        weight: FontWeight.normal,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: txt(
                      title: 'My Devices',
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        devices(
                          icon: Icons.lightbulb,
                          device: 'Lights',
                          activeColor: Colors.grey.shade900,
                        ),
                        SizedBox(width: 10.w),
                        devices(
                          icon: Icons.air_outlined,
                          device: 'Fans',
                          number: '1 Device',
                          activeColor: Colors.grey.shade900,
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          child: devices(
                            icon: Icons.window_outlined,
                            device: 'Windows',
                            number: '2 Devices',
                            activeColor: Colors.green,
                          ),
                          onTap: () {},
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Column(
                    children: [
                      SizedBox(
                        height: 290.h,
                        child: PageView.builder(
                          controller: _controller,
                          // itemCount: pages.length,
                          itemBuilder: (_, index) {
                            return items[index % items.length];
                          },
                        ),
                      ),
                      SizedBox(height: 7.h),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: items.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 4,
                          dotWidth: 12,
                          activeDotColor: Color.fromARGB(255, 55, 184, 193),
                          dotColor: Color.fromARGB(255, 84, 87, 96),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
