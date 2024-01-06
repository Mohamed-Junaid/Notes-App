import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNoteScreen extends StatelessWidget {
  final title = TextEditingController();
  final content = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection('Notes App');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: content,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
            ),
            GestureDetector(
              onTap: () {
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                fireStore.doc(id).set({
                  'title': title.text.toString(),
                  'content': content.text.toString(),
                  'time': DateTime.now().toString(),
                  'id': id
                });
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: 32.h,
                ),
                width: 727.w,
                height: 38.h,
                decoration: ShapeDecoration(
                  color: Color(0xFFFF4400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Center(
                  child: Text('Add',
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
          ],
        ),
      ),
    );
  }
}
