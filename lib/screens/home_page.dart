import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_notes/screens/profile.dart';
import 'package:personal_notes/common/toastMessage.dart';

import 'create_note.dart';
import 'edit_notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fireStore = FirebaseFirestore.instance.collection('Notes App').snapshots();
  final databaseRef = FirebaseDatabase.instance.ref('Notes App');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFF4400),
        title: Text(
          'My Notes',
          style: TextStyle(color: Colors.white),
        ),
        actions: [IconButton(
          icon: Icon(Icons.account_circle_outlined,color: Colors.white,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    Profile()));
          },
        ),],
      ),
      body: Column(
        children: [
          // Center(
          //   child: Text('Your notes will appear here'),
          // ),
    StreamBuilder<QuerySnapshot>(
    stream: fireStore,
    builder: (BuildContext contex,
    AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting)
        return CircularProgressIndicator();

      if (snapshot.hasError)
        return Text('Error');

      return Expanded(
        child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 280.w,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (snapshot.data!.docs[index]['title'].toString()),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    (snapshot.data!.docs[index]['content'].toString()),
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text((snapshot.data!.docs[index]['time'].toString()),
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.grey))
                                ]),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditNoteScreen(
                                            title: snapshot.data!.docs[index]['title'].toString(),
                                            content: snapshot.data!.docs[index]['content'].toString(),
                                            timestamp: snapshot.data!.docs[index]['time'].toString(),
                                            id: snapshot.data!.docs[index]['id'].toString(),
                                          ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteConfirmationDialog( snapshot.data!.docs[index]['id']);
                                },
                              ),
                            ],
                          ),
                        ],
                      )));
            }),
      );
    } )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNoteScreen()),
          );
        },
        backgroundColor: Color(0xFFFF4400),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel',style: TextStyle(color: Color(0xFFFF4400)),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteNote(docId);

              },
              child: Text('Delete',style: TextStyle(color: Color(0xFFFF4400)),),
            ),
          ],
        );
      },
    );
  }

}  void _deleteNote(String docId) {
  FirebaseFirestore.instance
      .collection('Notes App')
      .doc(docId)
      .delete()
      .then((_) {

    Fluttertoast.showToast(
      msg: "Note deleted successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }).catchError((error) {
    Fluttertoast.showToast(
      msg: "something went wrong",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  });
}




