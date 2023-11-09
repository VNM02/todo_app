import 'package:flutter/material.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();

  addTask() async
  {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final User user= _auth.currentUser!;
    final uid=user.uid;
    var time=DateTime.now();
    await FirebaseFirestore.instance.collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set(
      {
        'title':titleController.text,
        'description':descController.text,
        'time':time.toString()
      }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
        centerTitle: true,
        titleSpacing: 00.0,

        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(

          children: <Widget>[
            Container(
              child:TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(

              child:TextField(
                controller: descController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  addTask();
                },
                child: Text(
                  'Add Task',
                  style:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

