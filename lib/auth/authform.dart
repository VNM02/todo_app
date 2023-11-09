import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/screens/home.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  String email="",password="",username="";
  bool isSignUp=true;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  authenticate()
  {

    FocusScope.of(context).unfocus();
    if(_formKey.currentState!.validate())
      {
        submit();
      }
  }
  submit() async{

UserCredential result;

        try
        {
          if(isSignUp)
            {
              result = await _auth.createUserWithEmailAndPassword(email:email, password:password);
              try {
                String uid = result.user!.uid;
                await FirebaseFirestore.instance.collection('users')
                    .doc(uid)
                    .set(
                  {

                    'email': email,
                    'password': password
                  },

                );
                print('User Registered ! User id : ${result.user!.email}');

              }
              catch(err)
              {
                print(err);
              }

            }
          else
            {
              result = await _auth.signInWithEmailAndPassword(email: email, password: password);
            }
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
        }
        on FirebaseAuthException catch  (e) {
          print('Failed with error code am here : ${e.code}');
          print(e.message);
        }


  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          child:ListView(
            children:<Widget>[
              Container(
                child: Image.asset('assets/todo.png'),
              ),
            Container(
              padding: const EdgeInsets.all(10.0),
                child: Form(
                  key:_formKey,
                  child: Column(

                    children:<Widget>[
                      if(isSignUp==true)
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),

                            key: const ValueKey('username'),
                            validator: (value) {
                              if (value == null || value.isEmpty ||
                                  value.length < 5) {
                                return 'Username length is less than 5!!!';
                              }
                              return null;
                            },
                            onChanged: (value){
                              setState(() {
                                username=value;
                              });
                            },
                          ),

                          const SizedBox(height: 10.0),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'E-Mail',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),

                            key: const ValueKey('email'),
                            validator: (value){
                              if(value==null || value.isEmpty || !value.contains('@'))
                                {
                                  return 'Enter E-Mail in proper format!!!';
                                }
                              return null;
                            },
                            onChanged: (value){
                              setState(() {
                                email=value;
                              });
                            },
                          ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),

                        key: const ValueKey('password'),
                        validator: (value){
                          if(value==null || value.isEmpty || value.length<5)
                          {
                            return 'Password length is less than 8!!!';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState(() {
                            password=value;
                          });
                        },
                      ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      //decoration: BoxDecoration(),
                      child: ElevatedButton(
                          onPressed: (){
                            print('Email'+email.toString()+password+password.toString());
                            authenticate();

                          },
                          child:isSignUp?const Text('SignUp',style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )):const Text('Login',style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                      ),
                      ),
                    ),
                      const SizedBox(height: 10.0),
                      Container(
                       child: TextButton(
                         onPressed: (){
                           setState(() {
                             isSignUp=!isSignUp;
                           });
                         },
                         child:isSignUp?const Text('Already a member?'):const Text('Join Todo?'),
                       ),
                      ),
                    ],
                  ),
                ),
            ),
            ],
          ),

    );
  }
}
