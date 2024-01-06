
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditNoteScreen extends StatelessWidget {
  final String title;
  final String content;
  final String id;
  final String timestamp;

  const EditNoteScreen({
    required this.title,
    required this.content,
    required this.timestamp,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController content = TextEditingController();


    final databaseRef = FirebaseDatabase.instance.ref('Notes App');
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
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
                Navigator.pop(context);
               databaseRef.update({
                      'title': title.text,
                      'content': content.text,
                    })
                    .then((_) {})
                    .catchError((error) {});
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
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
