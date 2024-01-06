import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_notes/screens/signup_screen.dart';
import 'package:personal_notes/common/toastMessage.dart';

import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Widget buildTextFormField({
    required String hintText,
    required TextInputAction action,
    required TextEditingController controller}) {

    return Padding(
      padding: EdgeInsets.only(left: 26.w, top: 16.h),
      child: SizedBox(
        width: 325.w,
        height: 48.h,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Color(0xFFA0A0A0),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.43.h,
              ),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Color(0xFFE5E5E5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Color(0xFFE5E5E5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Color(0xFFE5E5E5)),
            ),
          ),
          textInputAction: action,
          obscureText: hintText == 'Password',
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w,top: 10.h),
                child: Text(
                  'Welcome',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color:  Color(0xFFFF4400),
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.60.h,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 26.w, top: 28.h),
                child: SizedBox(
                  width: 282.w,
                  child: Text(
                    'Sign in into your account',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.60.h,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 26.w,
                  top: 4.h,
                ),
                child: SizedBox(
                  width: 325.w,
                  child: Text(
                    'Get access to your personal notes',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Color(0xFF79747E),
                          fontSize: 14.sp,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          height: 1.43.h,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 26.w,
                  top: 40.h,
                ),
                child: SizedBox(
                  width: 78.w,
                  height: 14,
                  child: Text(
                    'Email  Address',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.17.h,
                        )),
                  ),
                ),
              ),
              buildTextFormField(
                hintText: 'Email',
                action: TextInputAction.next,
                controller: email,
              ),

              buildTextFormField(
                hintText: 'Password',
                action: TextInputAction.done,
                controller: password,
              ),
             GestureDetector(
               onTap: (){
                 auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((value) => {
                   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>HomePage()))
                 })
                     .onError((error, stackTrace) => ToastMessage()
                     .toastmessage(message:'Incorrect email or password'));

               },
                  child: Container(
                    margin: EdgeInsets.only(top: 32.h, left: 24.w, right: 24.w),
                    width: 327.w,
                    height: 48.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFF4400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Center(
                      child: Text('Sign in',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.h,
                            ),
                          )),
                    ),
                  ),
                ),

              Padding(
                padding: EdgeInsets.only(left: 120.w, top: 21.h, right: 111.w),
                child: SizedBox(
                  width: 144.w,
                  child: Text('Forgot Password?',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Color(0xFFFF4400),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.h,
                        ),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 45.w, top: 45.h, right: 22.w, bottom: 91.h),
                child: Row(
                  children: [
                    Text(
                      'Don’t have an account ?',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.25.h,
                          )),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    SizedBox(
                      width: 138.w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SignupScreen()));
                        },
                        child: Text(
                          'Register now',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Color(0xFFFF4400),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                height: 1.h,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
