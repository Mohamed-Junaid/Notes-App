import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_notes/screens/home_page.dart';
import 'package:personal_notes/screens/login_screen.dart';
import 'package:personal_notes/screens/toastMessage.dart';


class PhoneOTP extends StatefulWidget {
  final verificationId;
  const PhoneOTP({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<PhoneOTP> createState() => _PhoneOTPState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _PhoneOTPState extends State<PhoneOTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4400),
        elevation: 0,leading: IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      ),body: Column(
      children: [
        OtpTextField(
          numberOfFields: 6,
          focusedBorderColor: Colors.black,
          showFieldAsBox: false,
          onCodeChanged: (String code) {},
          onSubmit: (String verificationCode) async {

            final credentials = PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: verificationCode);
            try{
              await auth.signInWithCredential(credentials);
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>HomePage()));
            }catch(e){
              ToastMessage().toastmessage(message: e.toString());
            }
            setState(() {});
          }, // end onSubmit
        ),
      ],
    ),
    );
  }
}
