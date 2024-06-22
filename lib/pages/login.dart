import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdp/data/base_client.dart';
import 'package:gdp/extras.dart';
import 'package:gdp/pages/home.dart';

import '../data/users.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  var login1 = false;
  var login = false;
  bool isLoading = false;

  @override
  void dispose() {
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/start2.png"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Color.fromARGB(255, 21, 80, 100).withOpacity(0.4),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40.h),
                          txt(
                            title: 'Log In',
                            size: 20,
                          ),
                          SizedBox(height: 20.h),
                          txt(
                            title: 'Username',
                            size: 14,
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            padding: EdgeInsets.only(top: 5.h),
                            height: 80.h,
                            width: double.maxFinite,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.sp,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                    width: 2.sp,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.sp,
                                  ),
                                ),
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  color: Color(0xFFA7A5B2),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                floatingLabelStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'main',
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  login1 = false;
                                  return 'Name is required';
                                }
                                if (value.length <= 3) {
                                  login1 = false;
                                  return 'Name should be longer than 3 letters';
                                }
                                login1 = true;
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          txt(
                            title: 'Password',
                            size: 14,
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            padding: EdgeInsets.only(top: 5.h),
                            height: 80.h,
                            width: double.maxFinite,
                            child: TextFormField(
                              controller: passController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.sp,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                    width: 2.sp,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.sp,
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Color(0xFFA7A5B2),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                floatingLabelStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'main',
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                String pattern =
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-_]).{8,}$';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  login = false;
                                  return 'Password Should Contain Upper case letter, a lower case letter, \na special character & 2 numbers';
                                }
                                login = true;
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: txt(title: 'Success', color: Colors.black),
                                    content: txt(title: 'Login Successful', color: Colors.black),
                                    actions: <Widget>[
                                      TextButton(
                                        child: txt(title: 'OK', color: Colors.red),
                                        onPressed: () {
                                          Navigator.of(context).pop();
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
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                var user = Welcome(
                                  username: nameController.text,
                                  password: passController.text,
                                );
                                var response = await BaseClient().post('/login', user);
                                if (response == 201) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                            child: Container(
                              height: 60.h,
                              width: 350.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp),
                                color: Colors.transparent.withOpacity(0.3),
                              ),
                              child: Center(
                                child: txt(
                                  title: 'Log In',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
