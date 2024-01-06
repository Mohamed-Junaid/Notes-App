
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_notes/common/toastMessage.dart';

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
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    void fetchNoteData() async {
      DocumentSnapshot noteSnapshot =
      await FirebaseFirestore.instance.collection('Notes App').doc(id).get();

      if (noteSnapshot.exists) {
        Map<String, dynamic> noteData = noteSnapshot.data() as Map<String, dynamic>;
        titleController.text = noteData['title'];
        contentController.text = noteData['content'];
      }
    }
    fetchNoteData();
    void updateNote() {
      FirebaseFirestore.instance.collection('Notes App').doc(id).update({
        'title': titleController.text,
        'content': contentController.text,
        'time': DateTime.now().toString(),
      }).then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        ToastMessage().toastmessage(message:'Updated');
      });
    }
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
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                updateNote();
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
