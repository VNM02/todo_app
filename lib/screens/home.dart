import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  String uid='';
  final FirebaseAuth _auth=FirebaseAuth.instance;
  void initState() {
  getid();
    // TODO: implement initState
    super.initState();
  }
  getid() async{
    final User user=await _auth.currentUser!;
    setState(() {
      uid=user.uid;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Todo-App')),
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
      actions: [
        IconButton(
            icon:Icon( Icons.logout),
          onPressed: () async{
              await FirebaseAuth.instance.signOut();
        },
        )
      ],
      ),
      body:Container(
        padding: EdgeInsets.all(10),

        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
          child:StreamBuilder(stream: FirebaseFirestore.instance.collection('tasks').doc(uid).collection('mytasks').snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return Container(

                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    
                  ),
                );
              }
            else
              {
                var tasks=snapshot.data!.docs;
                if(tasks.length>0)
                  {
                    return ListView.builder(itemCount:tasks.length,itemBuilder:(context,index){

                      return  Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.amberAccent[400],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2.0, // Border width
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Title: ${tasks[index]['title']}'),
                                SizedBox(height: 10.0),
                                Text('Description: ${tasks[index]['description']}'),
                              ],
                            ),
                            Container(
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async{
                                  await FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(uid)
                                      .collection('mytasks')
                                      .doc(tasks[index]['time'])
                                      .delete();
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    } );
                  }
                else
                  {
                    return Center(
                      child: Text('Click on the button below to add tasks!!!'
                      ,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }

              }
          },)
      ),
        floatingActionButton:FloatingActionButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Task()));
          },
          child: Icon(Icons.add,color: Colors.white,),
        ),

    );
  }
}
