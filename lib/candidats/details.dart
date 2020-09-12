import 'package:degigban/candidats/photos.dart';
import 'package:degigban/candidats/tous_videos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Future _data;

  Future getCandidats() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("videos").getDocuments();

    return snap.documents;
  }
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
    _data =  getCandidats();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _data,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color.fromRGBO(71, 147, 12, 1),
                  ),
                );
              } else {

                return Container(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                    child: ListView.builder(

                      scrollDirection: Axis.vertical,
                      itemExtent: 145,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index){
                        return Container(
                          padding: EdgeInsets.only(top: 15.0),
                          height: 230,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(13, 173, 181, 1),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                              ),
                              image: DecorationImage(
                                  alignment: Alignment.bottomRight,
                                  image: AssetImage('assets/icons/monument.png')
                              )
                          ),
                          child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    'Portrait',
                                    style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontSize: 20,
                                        color: Colors.white
                                    ),
                                  ),
                                  leading: IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },

                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(width: 16,),
                                    Container(
                                      height: 120.0,
                                      width: 120.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(60.0),
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot.data[index].data['photo']),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data[index].data['nom_complet'],
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data[index].data['nom_parti'],
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                        Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Téléchargez mon ',
                                      style: TextStyle(fontFamily: 'Open Sans'),
                                    ),
                                    Text('Plan d\'actions 2020',
                                        style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            color: Color.fromRGBO(71, 147, 12, 1),
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                IconButton(
                                  icon: Image.asset('assets/icons/image100.png'),
                                  onPressed: () {},
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Bonjour $pseudo,',
                                  style: TextStyle(
                                    color: Color.fromRGBO(13, 173, 181, 1),
                                    fontFamily: 'Open Sans',
                                    fontSize: 23,
                                  )),
                              Text(snapshot.data[index].data['mots'],
                                  style: TextStyle(
                                    color: Color.fromRGBO(13, 173, 181, 0.5),
                                    fontFamily: 'Open Sans',
                                    fontSize: 15.0,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(snapshot.data[index].data['date_mots'],
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(71, 147, 12, 1),
                                              borderRadius: BorderRadius.circular(10.0),
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('${snapshot.data[index].data['likes'].toString()} Mentions J\'aime',
                                            style: TextStyle(
                                                fontFamily: 'Open Sans', fontSize: 18)),
                                      ],
                                    ),
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 0, 0, 1),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: Container(
                                            height: 48,
                                            width: 48,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(24),
                                            ),
                                            child:
                                            StreamBuilder(
                                                stream: Firestore.instance.collection('users').document("candidat_aime").snapshots(),
                                                builder: (context, snapshot) {
                                                  if(snapshot.hasData && snapshot.data) {
                                                    return IconButton(
                                                        icon: Icon(
                                                          CupertinoIcons
                                                              .heart_solid,
                                                          color: Color.fromRGBO(
                                                              255, 0, 0, 1),
                                                          size: 34.0,
                                                        ),
                                                        onPressed: () {
                                                          snapshot.data.setData(
                                                              <String, dynamic>{
                                                                'candidat_aime': snapshot
                                                                    .data[index]
                                                                    .data['nom_complet'],
                                                                'photo_candidat': snapshot
                                                                    .data[index]
                                                                    .data['photo']
                                                              });
                                                          Firestore.instance
                                                              .runTransaction((
                                                              transaction) async {
                                                            DocumentSnapshot freshSnap =
                                                            await transaction
                                                                .get(snapshot
                                                                .data[index]
                                                                .reference);
                                                            await transaction
                                                                .update(
                                                                freshSnap
                                                                    .reference,
                                                                {
                                                                  'likes': freshSnap['likes'] -
                                                                      1
                                                                });
                                                          });
                                                        }
                                                    );
                                                  } else {
                                                    return IconButton(
                                                        icon: Icon(
                                                          CupertinoIcons
                                                              .heart,
                                                          color: Color.fromRGBO(
                                                              255, 0, 0, 1),
                                                          size: 34.0,
                                                        ),
                                                        onPressed: () {
                                                          snapshot.data.setData(
                                                              <String, dynamic>{
                                                                'candidat_aime': snapshot
                                                                    .data[index]
                                                                    .data['nom_complet'],
                                                                'photo_candidat': snapshot
                                                                    .data[index]
                                                                    .data['photo']
                                                              });
                                                          Firestore.instance
                                                              .runTransaction((
                                                              transaction) async {
                                                            DocumentSnapshot freshSnap =
                                                            await transaction
                                                                .get(snapshot
                                                                .data[index]
                                                                .reference);
                                                            await transaction
                                                                .update(
                                                                freshSnap
                                                                    .reference,
                                                                {
                                                                  'likes': freshSnap['likes'] -
                                                                      1
                                                                });
                                                          });
                                                        }
                                                    );
                                                  }
                                                }
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text('Biographie',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 147, 12, 1),
                                    fontFamily: 'Open Sans',
                                    fontSize: 20,
                                  )),
                              Text(snapshot.data[index].data['biographie'],
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 15,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Age:',
                                            style: TextStyle(fontFamily: 'Open Sans')),
                                        Text(
                                          snapshot.data[index].data['age'],
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(71, 147, 12, 1),
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Profession:',
                                            style: TextStyle(fontFamily: 'Open Sans')),
                                        Text(
                                          snapshot.data[index].data['profession'],
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(71, 147, 12, 1),
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Niveau d\'études:',
                                            style: TextStyle(fontFamily: 'Open Sans')),
                                        Text(snapshot.data[index].data['niveau_etudes'],
                                            style: TextStyle(
                                              fontFamily: 'Open Sans',
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(71, 147, 12, 1),
                                              fontSize: 12,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => TousLesVideos()

                                ));

                                Padding(
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
                                            'Vidéos',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.2
                                            )
                                        ),
                                      )
                                  ),
                                );},
                            ),
                            GestureDetector(
                              onTap: () {

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
                                          'Audios',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2
                                          )
                                      ),
                                    )
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Images()));
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
                                          'Images',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2
                                          )
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        )]));
                      }));
              }
            })
    );
  }
}
