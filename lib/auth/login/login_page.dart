import "package:flutter/material.dart";
import "package:todo_app/auth/signup/signup_page.dart";
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('LogIn'),


        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children:<Widget>[
            Container(
              child: Image.asset('assets/todo.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Form(
                  child: Column(
                    children:<Widget>[


                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty || !value.contains('@'))
                          {
                            return 'Invalid E-mail Id';
                          }
                          else
                          {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty || value.length<6 )
                          {
                            return 'Password length must ne atleast 6';
                          }
                          else
                          {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        child: ElevatedButton(
                          onPressed: (){

                          },
                          child: Text('LogIn'),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        child: TextButton(
                          onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                          },
                          child: Text('Wish to Join Todo?'),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );;
  }
}
