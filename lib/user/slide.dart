import 'package:degigban/candidats/ls.dart';
import 'package:degigban/chat/chat.dart';
import 'package:flutter/material.dart';


class SlideOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.75,
                child: Image.asset('assets/icons/image13.png'),
              ),
            ),
            SizedBox(height: 30.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text('Opinion citoyen', style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Open Sans'),
                  ),
                ),
                SizedBox(height: 20.0,),
                Center(
                  child: Text('La bonne gouvernance', style: TextStyle(
                      color: Color.fromRGBO(71, 147, 12, 1),
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans'),
                  ),
                ),
              ],
            ),

            Center(
              child: Text('du Togo passe par vos mots !', style: TextStyle(
                  color: Color.fromRGBO(71, 147, 12, 1),
                  fontSize: 20.0,
                  fontFamily: 'Open Sans'),
              ),
            ),
            SizedBox(height: 30.0,),
            Column(
              children: <Widget>[
                Text('Construisez votre pays...',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 173, 181, 1),
                        fontFamily: 'Open Sans', fontSize: 17)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(71, 147, 12, 1),
                              borderRadius: BorderRadius.circular(4.0),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Vos critiques constructives, ',
                            style: TextStyle(
                                fontFamily: 'Open Sans', fontSize: 10)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(71, 147, 12, 1),
                              borderRadius: BorderRadius.circular(4.0),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Vos analyses, ',
                            style: TextStyle(
                                fontFamily: 'Open Sans', fontSize: 10)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(71, 147, 12, 1),
                              borderRadius: BorderRadius.circular(4.0),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Vos points de vue, ',
                            style: TextStyle(
                                fontFamily: 'Open Sans', fontSize: 10)),
                      ],
                    ),
                  ],
                ),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('sont lus et écoutés ', style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: 'Open Sans'),
                      ),
                      Text('dans l\'anonymat', style: TextStyle(
                          color: Colors.red,
                          fontSize: 11.0,
                          fontFamily: 'Open Sans'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0,),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient:LinearGradient(
                  colors: [Color.fromRGBO(13, 173, 181, 1), Color.fromRGBO(137, 217, 82, 1)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: GestureDetector(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24.0,
                ),
                onTap: () {Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Chat()));},
              ),
            ),

          ],
        ),
    );
  }
}


class SlideTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.75,
              child: Image.asset('assets/icons/image122.png'),
            ),
          ),
          SizedBox(height: 30.0,),
          Center(
            child: Text('Campagne Electorale', style: TextStyle(
                color: Color.fromRGBO(71, 147, 12, 1),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Open Sans'),
            ),
          ),
          Center(
            child: Text('2020', style: TextStyle(
                color: Color.fromRGBO(71, 147, 12, 1),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Open Sans'),
            ),
          ),
          SizedBox(height: 30.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text('Soyez informés du plan d\'actions et de tous les moments chauds',
                    style: TextStyle(
                        fontFamily: 'Open Sans', fontSize: 11)
                ),
              ),
              Center(
                child: Text('de la campagne électorale de vos candidats',
                    style: TextStyle(
                        fontFamily: 'Open Sans', fontSize: 11)
                ),
              ),
              Center(
                child: Text('aux élections de 2020', style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    fontFamily: 'Open Sans'),
                ),
              ),
            ],
          ),
          SizedBox(height: 35,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ListPa()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 30.0
                  ),
                  child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width*0.35,
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
                            'Suivre la file',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
