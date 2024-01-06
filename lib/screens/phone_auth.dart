import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_notes/screens/phone_otp.dart';

import 'toastMessage.dart';

class phoneAuth extends StatefulWidget {
  const phoneAuth({Key? key}) : super(key: key);

  @override
  State<phoneAuth> createState() => _phoneAuthState();
}

TextEditingController phone = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _phoneAuthState extends State<phoneAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor:  Color(0xFFFF4400),
          elevation: 0,leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ),
        body: SingleChildScrollView(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Text('Mobile Number',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCDD1D0))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCDD1D0))),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCDD1D0)))),
                    controller: phone,
                    keyboardType: TextInputType.number
                ),
              ),SizedBox(height: 30.h,),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 26.w),
                  child: GestureDetector(onTap: () {
                    auth.verifyPhoneNumber(phoneNumber: phone.text,verificationCompleted: (_){},
                        verificationFailed: (e){
                          ToastMessage().toastmessage(message:'Error');
                        },
                        codeSent: (String verificationId,int? token){
                          Navigator.of(context).push(MaterialPageRoute(builder:
                              (BuildContext a)=>PhoneOTP(verificationId: verificationId,)));

                        },
                        codeAutoRetrievalTimeout: (e){
                          ToastMessage().toastmessage(message: e.toString());
                        });
                  },
                    child: Container(
                      width: 80.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                          color:  Color(0xFFFF4400),
                          borderRadius: BorderRadius.circular(29.r)),
                      child: Center(
                          child: Text(
                            'Get OTP',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),

                ),
              ),
            ])));
  }
}