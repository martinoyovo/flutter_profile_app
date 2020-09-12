import 'package:degigban/user/civisme.dart';
import 'package:degigban/user/slide.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  var firestore = Firestore.instance;
  DocumentReference snap =  Firestore.instance.collection("users").document('candidat_aime');
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategorySelector(),
    );
  }
}

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String uid = '';
  String pseudo = '';
  String telephone = '';

  getUid() {}

  @override
  void initState() {
    this.uid = '';
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this.uid = val.uid;
        this.pseudo = val.displayName;
        this.telephone = val.phoneNumber;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var pseud = '$pseudo';
    var caracter = pseud.split('');
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Container(
            height: 100.0,
            child:  Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 30.0
                        ),
                        child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                            color: Color.fromRGBO(71, 147, 12, 1),
                              borderRadius: BorderRadius.all(Radius.circular(18))  ,
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.perm_identity,
                                color: Color.fromRGBO(255, 255, 0, 1),
                                size: 30.0,
                              ),
                            ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Civisme()));
                          },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 30.0
                    ),
                    child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width*0.25,
                        decoration: BoxDecoration(
                          gradient:LinearGradient(
                            colors: [Color.fromRGBO(13, 173, 181, 1), Color.fromRGBO(137, 217, 82, 1)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width/8))  ,
                        ),
                        child: Center(
                          child:
                          Text(
                              'Civisme',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                              )
                          ),
                        )
                    ),
                  ),
                ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SlideOne()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 30.0
                          ),
                          child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width*0.25,
                              decoration: BoxDecoration(
                                gradient:LinearGradient(
                                  colors: [Color.fromRGBO(13, 173, 181, 1), Color.fromRGBO(137, 217, 82, 1)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width/8))  ,
                              ),
                              child: Center(
                                child:
                                Text(
                                    'Opinion',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,

                                    )
                                ),
                              )
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SlideTwo()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 30.0
                          ),
                          child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width*0.25,
                              decoration: BoxDecoration(
                                gradient:LinearGradient(
                                  colors: [Color.fromRGBO(13, 173, 181, 1), Color.fromRGBO(137, 217, 82, 1)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width/8))  ,
                              ),
                              child: Center(
                                child:
                                Text(
                                    'Campagne',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                    )
                                ),
                              )
                          ),
                        ),
                      ),
                ])
                  )],
                ),
              )),
        SizedBox(height: 36,),
        Center(
          child: Text('Bienvenue $pseudo,', style: TextStyle(color: Color.fromRGBO(71, 147, 12, 1),
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2
          )),
        ),
        SizedBox(height: 36,),
        Center(
          child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromRGBO(13, 173, 181, 1), Color.fromRGBO(137, 217, 82, 1)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width/2))
              ),
            child: Center(
              child: Text(caracter[0].toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 90,
                  )
              ),
            ),
          ),
        ),
        SizedBox(height: 36,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Vous aimez SEM Faure? ',
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 18,
                      color: Color.fromRGBO(13, 173, 181, 1)
                  ),
                ),
                Text(
                  'Cliquez sur la photo pour suivre ses activités',
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 14,
                      color: Color.fromRGBO(13, 173, 181, 1)
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                    image: NetworkImage (''),
                  )
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

