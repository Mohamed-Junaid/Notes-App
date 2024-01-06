import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_notes/screens/home_page.dart';
import 'package:personal_notes/screens/login_screen.dart';
import 'package:personal_notes/screens/phone_auth.dart';
import 'package:personal_notes/common/toastMessage.dart';

import '../firebase/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget buildTextFormField({
    required String hintText,
    required TextInputAction action,
    required TextEditingController controller,}) {
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
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 1.17.h,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
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
          obscureText: hintText.contains('Password'),
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
                padding: EdgeInsets.only(left: 26.w, top: 48.h),
                child: SizedBox(
                  width: 282.w,
                  child: Text(
                    'Register your account',
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
                    'Get access to your order, products',
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

              // buildTextFormField(
              //   hintText: 'User Name',
              //   action: TextInputAction.next,
              //   controller: userName,
              // ),

              buildTextFormField(
                hintText: 'Email',
                action: TextInputAction.next,
                controller: email,
              ),

              // buildTextFormField(
              //   hintText: 'Phone Number',
              //   action: TextInputAction.next,
              //   controller: phone,
              // ),

              buildTextFormField(
                hintText: 'Password',
                action: TextInputAction.next,
                controller: password,
              ),
                 GestureDetector(
                  onTap: () {
                    auth.createUserWithEmailAndPassword(email: email.text, password: password.text,).then((value) => {
                      ToastMessage().toastmessage(message: 'Successfully registered')
                    }).onError((error, stackTrace) => ToastMessage().toastmessage(message:
                    'something went wrong'));
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
                      child: Text('Sign up',
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
                ),SizedBox(height: 20.h,),
              Row(
                children: [
                  SizedBox(
                    width: 34.w,
                  ),
                  SizedBox(
                      width: 132.w,
                      height: 0.h,
                      child: Divider(color: Color(0xffCDD1D0))),
                  SizedBox(width: 15.w),
                  Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 15.w),
                  SizedBox(
                      width: 132.w,
                      height: 0.h,
                      child: Divider(color: Color(0xffCDD1D0))),
                  SizedBox(width: 15.w),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: 106.w,top: 20.h),
                child: Row(
                  children: [
                    GestureDetector(  onTap: () {
                      AuthService().signInWithGoogle(context).catchError((error) {

                        print('Error signing in with Google: $error');

                      });

                    },
                      child: CircleAvatar(
                        radius: 24.r,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          radius: 23.r,
                          backgroundColor: Colors.white,
                          child:
                          Image.asset("assets/images/gg.png", width: 46.w, height: 36.h),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 55.w,
                    ),
                    GestureDetector(onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PhoneAuth()));
                    },
                      child: CircleAvatar(
                        radius: 24.r,
                        backgroundColor:Colors.grey,
                        child: CircleAvatar(
                          radius: 23.r,
                          backgroundColor: Colors.white,
                          child:
                          Image.asset("assets/images/ff.png", width: 46.w, height: 36.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Padding(
                padding: EdgeInsets.only(
                    left: 74.w, top: 40.h, right: 57.w, bottom: 55.h),
                child: Row(
                  children: [
                    Text(
                      'Already have an account ?',
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
                      width: 75.w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                        child: Text(
                          'Sign in',
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
              ),

            ],
          ),
        ),
      ),

    );
  }
  signInWithGoogle()async{
GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();

GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;

AuthCredential credential=GoogleAuthProvider.credential(
  accessToken: googleAuth?.accessToken,
  idToken: googleAuth?.idToken
);

UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
print(userCredential.user?.displayName);

if (userCredential.user !=null){
  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
}
  }
}
