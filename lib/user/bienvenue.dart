import 'package:degigban/authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'dashboard.dart';

class Bienvenue extends StatefulWidget {
  @override
  _BienvenueState createState() => _BienvenueState();
}

class _BienvenueState extends State<Bienvenue> {

  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      if(user !=null) {
        Timer(Duration(seconds: 5), ()=> Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        ));
      } else {
        Timer(Duration(seconds: 3), ()=> Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        ));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget> [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(13, 173, 181, 1), Color.fromRGBO(137, 217, 82, 1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            )
          ),
          Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              SizedBox(height: 150.0,),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Container(
                        height: MediaQuery.of(context).size.width/3,
                        width: MediaQuery.of(context).size.width/3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/6),
                          image: DecorationImage(
                             image: AssetImage('assets/icons/image164.png'),
                              fit: BoxFit.cover,
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                      ),
                      Text('Denyigban App',
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold)
                      ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                        ),
                      Text('L\'application du citoyen togolais',style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.0,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold)
                      ),
                    ]
                  )
                )
              ),
              SizedBox(height: 100.0,),
              Expanded(flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                    children: <Widget> [
                    Center(
                      child: Text('FAURE 2020', style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 11.0,
                      color: Colors.white )),
                    ),
                    ]
              ),
                  ],
                ))
            ]
          )
        ]
      )
    );
  }
}
